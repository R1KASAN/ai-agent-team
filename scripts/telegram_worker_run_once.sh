#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
REPO_ROOT=$(cd "$SCRIPT_DIR/.." && pwd)
QUEUE_DIR="$REPO_ROOT/runtime/queue"
SAFE_LOG="$REPO_ROOT/scripts/safe_log_write.sh"

die() { echo "ERROR: $*" >&2; exit 1; }
now_date() { date +"%Y-%m-%d"; }
now_stamp() { date +"%Y-%m-%dT%H:%M:%S%z"; }

get_field() {
  local file="$1" key="$2"
  awk -F': ' -v key="$key" '$1 == key { print substr($0, index($0, ": ") + 2); exit }' "$file" |
    sed 's/^"//; s/"$//'
}

set_field() {
  local file="$1" key="$2" value="$3" tmp
  tmp="$(mktemp "${file}.XXXXXX")"
  awk -v key="$key" -v value="$value" '
    BEGIN { done = 0 }
    $0 ~ "^" key ": " { print key ": " value; done = 1; next }
    { print }
    END { if (done == 0) print key ": " value }
  ' "$file" > "$tmp"
  mv "$tmp" "$file"
}

extract_payload() {
  local file="$1"
  awk '
    /^```text$/ { in_payload = 1; next }
    /^```$/ && in_payload == 1 { exit }
    in_payload == 1 { print }
  ' "$file"
}

count_state() {
  local state="$1" count=0 file
  for file in "$QUEUE_DIR"/*.md; do
    [ -e "$file" ] || continue
    if grep -q "^queue_state: $state$" "$file"; then
      count=$((count + 1))
    fi
  done
  printf '%s' "$count"
}

find_next_approved() {
  local file
  while IFS= read -r file; do
    if grep -q '^queue_state: approved$' "$file"; then
      printf '%s' "$file"
      return 0
    fi
  done < <(find "$QUEUE_DIR" -maxdepth 1 -type f -name '*.md' | sort)
  return 1
}

status_row_action() {
  local run_id="$1"
  if grep -q "^| $run_id |" "$REPO_ROOT/logs/runtime_status.md"; then
    echo update
  else
    echo append
  fi
}

write_status_row() {
  local run_id="$1" status="$2" approval_state="$3" input_artifact="$4" latest_artifact="$5" next_step="$6"
  local row action
  row="| $run_id | /telegram-gateway | telegram_gateway | telegram_gateway_v1 | $status | Telegram Gateway Worker | $approval_state | $input_artifact | $latest_artifact | $next_step | $(now_date) |"
  action="$(status_row_action "$run_id")"
  bash "$SAFE_LOG" status "$action" --run-id "$run_id" --row "$row" >/dev/null
}

make_dispatch_artifact() {
  local run_id="$1" queue_rel="$2" telegram_command="$3" job_hint="$4" target_agent="$5" budget_cap="$6" mapped="$7" payload="$8"
  local base path rel n
  base="$REPO_ROOT/handoffs/telegram_dispatch_${run_id}.md"
  path="$base"
  n=2
  while [ -e "$path" ]; do
    path="$REPO_ROOT/handoffs/telegram_dispatch_${run_id}-${n}.md"
    n=$((n + 1))
  done
  rel="${path#"$REPO_ROOT/"}"
  cat > "$path" <<EOF
---
artifact: telegram_gateway_dispatch
runtime_mode: telegram_gateway_v1
run_id: $run_id
source_queue_item: $queue_rel
telegram_command: "$telegram_command"
job_hint: "$job_hint"
target_agent: "$target_agent"
budget_cap: $budget_cap
created_at: "$(now_stamp)"
llm_invoked: false
---

# Telegram Gateway Dispatch

This v1 worker dispatches the approved Telegram queue item into a compact \`/idea-gate\` handoff. It
does not invoke an LLM automatically.

## Mapped Payload

\`\`\`text
$mapped
\`\`\`

## Paste Into Claude/Codex Session

\`\`\`text
/idea-gate $payload
\`\`\`

## Payload

\`\`\`text
$payload
\`\`\`
EOF
  printf '%s' "$rel"
}

write_agent_run_log() {
  local run_id="$1" queue_rel="$2" artifact_rel="$3" telegram_command="$4" job_hint="$5" budget_cap="$6"
  local agent_run_id="${run_id#run-}-telegram-gateway-worker"
  bash "$SAFE_LOG" agent-run --run-id "$agent_run_id" >/dev/null <<EOF
---
template: agent_run_log
version: "1.0"
---

run_id: $agent_run_id
created_at: "$(now_stamp)"
agent: Telegram Gateway Worker
command: /telegram-gateway
mode: queue_dispatch_no_llm
workflow_id: telegram_gateway
context_budget: $budget_cap

files_read:
  - workflows/telegram_gateway.md
  - $queue_rel
files_written:
  - $artifact_rel
sources_used: []
approval_gates_hit: []

notebooklm_mission_info:
  used: false

final_artifact_paths:
  - $artifact_rel
redactions: []
notes: >
  Telegram Gateway v1 worker processed one approved queue item. telegram_command=$telegram_command,
  job_hint=$job_hint. No LLM was invoked; the dispatch artifact carries the compact /idea-gate payload.
EOF
}

print_pending_summary() {
  echo "No approved Telegram queue item to process."
  for state in queued needs_approval approved running blocked complete rejected; do
    echo "$state: $(count_state "$state")"
  done
}

main() {
  [ -d "$QUEUE_DIR" ] || { print_pending_summary; exit 0; }
  [ -f "$SAFE_LOG" ] || die "missing safe log helper: $SAFE_LOG"

  local file
  if ! file="$(find_next_approved)"; then
    print_pending_summary
    exit 0
  fi

  local run_id queue_rel telegram_command job_hint target_agent budget_cap approval_state mapped payload artifact_rel
  run_id="$(get_field "$file" run_id)"
  queue_rel="${file#"$REPO_ROOT/"}"
  telegram_command="$(get_field "$file" telegram_command)"
  job_hint="$(get_field "$file" job_hint)"
  target_agent="$(get_field "$file" target_agent)"
  budget_cap="$(get_field "$file" budget_cap)"
  approval_state="$(get_field "$file" approval_state)"
  mapped="$(get_field "$file" mapped_idea_gate_payload)"
  payload="$(extract_payload "$file")"

  if [ "$budget_cap" = "tiny" ] && [ "$job_hint" != "consult" ]; then
    set_field "$file" queue_state blocked
    set_field "$file" latest_artifact "\"$queue_rel\""
    set_field "$file" updated_at "\"$(now_stamp)\""
    write_status_row "$run_id" blocked "$approval_state" "$queue_rel" "$queue_rel" "run นี้หมด budget แล้ว; ใช้ /budget $run_id medium แล้ว /approve $run_id ถ้าต้องการให้ต่อ"
    echo "blocked: $run_id budget_cap=tiny is only allowed for consult"
    echo "run นี้หมด budget แล้ว; ใช้ /budget $run_id medium แล้ว /approve $run_id ถ้าต้องการให้ต่อ"
    exit 0
  fi

  set_field "$file" queue_state running
  set_field "$file" updated_at "\"$(now_stamp)\""
  write_status_row "$run_id" running "$approval_state" "$queue_rel" "$queue_rel" "dispatch_to_idea_gate"

  artifact_rel="$(make_dispatch_artifact "$run_id" "$queue_rel" "$telegram_command" "$job_hint" "$target_agent" "$budget_cap" "$mapped" "$payload")"
  write_agent_run_log "$run_id" "$queue_rel" "$artifact_rel" "$telegram_command" "$job_hint" "$budget_cap"

  set_field "$file" queue_state complete
  set_field "$file" latest_artifact "\"$artifact_rel\""
  set_field "$file" updated_at "\"$(now_stamp)\""
  write_status_row "$run_id" complete "$approval_state" "$queue_rel" "$artifact_rel" "none - dispatch artifact ready for /idea-gate"

  echo "complete: $run_id"
  echo "artifact: $artifact_rel"
}

main "$@"
