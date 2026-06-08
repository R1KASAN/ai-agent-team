#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
REPO_ROOT=$(cd "$SCRIPT_DIR/.." && pwd)
QUEUE_DIR="$REPO_ROOT/runtime/queue"

usage() {
  cat >&2 <<'EOF'
Usage:
  telegram_queue.sh enqueue --user-id ID --message-id ID --text '/idea text'
  telegram_queue.sh enqueue --user-id ID --message-id ID --text '/ask yuki question'
  telegram_queue.sh status
  telegram_queue.sh approve <run_id>
  telegram_queue.sh reject <run_id>
  telegram_queue.sh budget <run_id> tiny|small|medium

Notes:
  - This script never invokes an LLM.
  - Queue items are one file per request under runtime/queue/.
EOF
  exit 2
}

die() { echo "ERROR: $*" >&2; exit 1; }
now() { date +"%Y-%m-%dT%H:%M:%S%z"; }

ensure_queue_dir() { mkdir -p "$QUEUE_DIR"; }

sanitize_id() {
  printf '%s' "$1" | tr -c 'A-Za-z0-9_-' '-'
}

queue_path() {
  local run_id="$1"
  case "$run_id" in
    *[!A-Za-z0-9_-]*|"") die "invalid run_id: $run_id";;
  esac
  printf '%s/%s.md' "$QUEUE_DIR" "$run_id"
}

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

has_high_risk_signal() {
  printf '%s\n' "$1" |
    grep -Eiq 'auth|authentication|login|oauth|payment|billing|stripe|database|db|infra|infrastructure|hosting|deploy|production|paid api|paid tool|privacy|security|legal|client data|PII|token|secret|credential|ชำระเงิน|จ่ายเงิน|ฐานข้อมูล|โฮสต์|ดีพลอย|ความเป็นส่วนตัว|กฎหมาย'
}

make_unique_run_id() {
  local message_id="$1" base run_id n path
  base="run-tg-$(date +%Y%m%d-%H%M%S)-$(sanitize_id "${message_id:-local}")"
  run_id="$base"
  n=2
  path="$(queue_path "$run_id")"
  while [ -e "$path" ]; do
    run_id="${base}-${n}"
    path="$(queue_path "$run_id")"
    n=$((n + 1))
  done
  printf '%s' "$run_id"
}

write_queue_item() {
  local run_id="$1" user_id="$2" message_id="$3" telegram_command="$4" job_hint="$5" target_agent="$6" budget_cap="$7" requires_approval="$8" approval_state="$9" queue_state="${10}" payload="${11}"
  local rel_path="runtime/queue/${run_id}.md"
  local mapped="command=/idea-gate; job_hint=${job_hint}; target_agent=${target_agent}; payload_ref=${rel_path}#payload"
  local created path tmp
  created="$(now)"
  path="$(queue_path "$run_id")"
  tmp="$(mktemp "${path}.XXXXXX")"
  cat > "$tmp" <<EOF
---
artifact: telegram_queue_item
version: "1.0"
runtime_mode: telegram_gateway_v1
run_id: $run_id
telegram_user_id: "$user_id"
telegram_message_id: "$message_id"
telegram_command: "$telegram_command"
mapped_idea_gate_payload: "$mapped"
job_hint: "$job_hint"
target_agent: "$target_agent"
budget_cap: $budget_cap
requires_approval: $requires_approval
approval_state: $approval_state
queue_state: $queue_state
latest_artifact: ""
created_at: "$created"
updated_at: "$created"
---

# Payload

\`\`\`text
$payload
\`\`\`
EOF
  mv "$tmp" "$path"
  printf '%s\n' "$rel_path"
}

cmd_enqueue() {
  local user_id="" message_id="" text=""
  while [ $# -gt 0 ]; do
    case "$1" in
      --user-id) user_id="${2:-}"; shift 2;;
      --message-id) message_id="${2:-}"; shift 2;;
      --text) text="${2:-}"; shift 2;;
      *) usage;;
    esac
  done
  [ -n "$user_id" ] && [ -n "$message_id" ] && [ -n "$text" ] || usage
  ensure_queue_dir

  local telegram_command payload job_hint target_agent budget_cap requires_approval approval_state queue_state run_id path
  telegram_command="${text%% *}"
  payload=""
  job_hint=""
  target_agent=""

  case "$telegram_command" in
    /idea)
      payload="${text#"$telegram_command"}"
      payload="${payload# }"
      [ -n "$payload" ] || die "/idea requires text"
      job_hint="idea-debate"
      budget_cap="small"
      ;;
    /ask)
      local rest
      rest="${text#"$telegram_command"}"
      rest="${rest# }"
      target_agent="${rest%% *}"
      payload="${rest#"$target_agent"}"
      payload="${payload# }"
      [ -n "$target_agent" ] && [ -n "$payload" ] || die "/ask requires target agent and question"
      job_hint="consult"
      budget_cap="tiny"
      ;;
    *)
      die "unsupported Telegram command for enqueue: $telegram_command"
      ;;
  esac

  requires_approval=false
  approval_state=none
  queue_state=queued
  if has_high_risk_signal "$text"; then
    requires_approval=true
    approval_state=pending
    queue_state=needs_approval
  fi

  run_id="$(make_unique_run_id "$message_id")"
  path="$(write_queue_item "$run_id" "$user_id" "$message_id" "$telegram_command" "$job_hint" "$target_agent" "$budget_cap" "$requires_approval" "$approval_state" "$queue_state" "$payload")"

  echo "queued: $run_id"
  echo "path: $path"
  echo "queue_state: $queue_state"
  echo "budget_cap: $budget_cap"
  if [ "$queue_state" = "needs_approval" ]; then
    echo "next_step: /approve $run_id"
  else
    echo "next_step: bash scripts/telegram_worker_run_once.sh after approval if needed"
  fi
}

cmd_status() {
  ensure_queue_dir
  echo "Telegram Gateway Queue Status"
  for state in queued needs_approval approved running blocked complete rejected; do
    echo "$state: $(count_state "$state")"
  done
  echo
  echo "Pending items:"
  local file found=0
  for file in "$QUEUE_DIR"/*.md; do
    [ -e "$file" ] || continue
    case "$(get_field "$file" queue_state)" in
      queued|needs_approval|approved|blocked)
        found=1
        echo "- $(get_field "$file" run_id) | state=$(get_field "$file" queue_state) | budget=$(get_field "$file" budget_cap) | command=$(get_field "$file" telegram_command)"
        ;;
    esac
  done
  [ "$found" -eq 1 ] || echo "- none"
}

cmd_approve() {
  [ $# -eq 1 ] || usage
  local file
  file="$(queue_path "$1")"
  [ -f "$file" ] || die "queue item not found: $1"
  set_field "$file" queue_state approved
  set_field "$file" approval_state approved
  set_field "$file" updated_at "\"$(now)\""
  echo "approved: $1"
}

cmd_reject() {
  [ $# -eq 1 ] || usage
  local file
  file="$(queue_path "$1")"
  [ -f "$file" ] || die "queue item not found: $1"
  set_field "$file" queue_state rejected
  set_field "$file" approval_state rejected
  set_field "$file" updated_at "\"$(now)\""
  echo "rejected: $1"
}

cmd_budget() {
  [ $# -eq 2 ] || usage
  local run_id="$1" budget="$2" file state
  case "$budget" in tiny|small|medium) :;; *) die "budget must be tiny, small, or medium";; esac
  file="$(queue_path "$run_id")"
  [ -f "$file" ] || die "queue item not found: $run_id"
  set_field "$file" budget_cap "$budget"
  state="$(get_field "$file" queue_state)"
  if [ "$state" = "blocked" ]; then
    set_field "$file" queue_state needs_approval
    set_field "$file" approval_state pending_budget_upgrade
  fi
  set_field "$file" updated_at "\"$(now)\""
  echo "budget_cap updated: $run_id -> $budget"
  echo "next_step: /approve $run_id"
}

[ $# -ge 1 ] || usage
cmd="$1"; shift
case "$cmd" in
  enqueue) cmd_enqueue "$@";;
  status) cmd_status "$@";;
  approve) cmd_approve "$@";;
  reject) cmd_reject "$@";;
  budget) cmd_budget "$@";;
  -h|--help) usage;;
  *) usage;;
esac
