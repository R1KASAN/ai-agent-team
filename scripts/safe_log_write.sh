#!/usr/bin/env bash
set -euo pipefail

# safe_log_write.sh — Layer 1 of the 2-layer audit-logging fix.
#
# The real fix for "row lost from a race condition": every write to the single shared status
# index (logs/runtime_status.md) and every drop into logs/agent_runs/ goes through ONE locked,
# append-only, read-back-verified path instead of an ad-hoc full-file rewrite.
#
# Portability: macOS does NOT ship flock (util-linux). The lock is a portable mkdir-mutex
# (mkdir is atomic on POSIX — exactly one writer wins). flock is not required and not used.
#
# Modes:
#   status  append  --run-id ID --row 'ROW'   Append one table row to logs/runtime_status.md
#   status  update  --run-id ID --row 'ROW'   Replace the existing row for ID (status transition)
#   agent-run       --run-id ID [< content]   Write logs/agent_runs/<ID>.md (no-overwrite, auto-suffix)
#
# Every mode: acquire lock -> mutate via temp file -> read-back verify -> atomic mv -> release.
# On any verify failure the live file is left UNTOUCHED and the script exits non-zero (fail loud).

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
REPO_ROOT=$(cd "$SCRIPT_DIR/.." && pwd)

STATUS_FILE="$REPO_ROOT/logs/runtime_status.md"
AGENT_RUNS_DIR="$REPO_ROOT/logs/agent_runs"

die() { echo "ERROR: $*" >&2; exit 1; }

usage() {
  cat >&2 <<'EOF'
Usage:
  safe_log_write.sh status append --run-id <run-id> --row '<full markdown table row>'
  safe_log_write.sh status update --run-id <run-id> --row '<full markdown table row>'
  safe_log_write.sh agent-run     --run-id <YYYYMMDD-HHMMSS-command-agent>  < entry.md

Notes:
  - <run-id> must be alphanumeric, hyphen, or underscore only.
  - <row> must be a single line (paths only, never pasted bodies).
  - agent-run reads the entry body from stdin.
EOF
  exit 2
}

# ---- portable mkdir-mutex lock ----------------------------------------------
LOCK_DIR=""
release_lock() { [ -n "$LOCK_DIR" ] && rm -rf -- "$LOCK_DIR" 2>/dev/null || true; }

acquire_lock() {
  local lock="$1" max_tries=100 stale_min=1 tries=0
  trap release_lock EXIT INT TERM
  while ! mkdir "$lock" 2>/dev/null; do
    # Reap a stale lock only if it is BOTH old AND its recorded holder is no longer alive.
    # Time-only reap could evict a live writer slow >stale_min (two concurrent writers); checking
    # the holder pid (written to lock/pid below) removes that hazard while preserving crash recovery.
    # If the pid file is missing/empty (writer crashed before writing it) fall back to time-only reap.
    if [ -d "$lock" ] && find "$lock" -maxdepth 0 -mmin "+$stale_min" 2>/dev/null | grep -q .; then
      local holder=""
      [ -r "$lock/pid" ] && holder="$(cat "$lock/pid" 2>/dev/null || true)"
      if [ -z "$holder" ] || ! kill -0 "$holder" 2>/dev/null; then
        rm -rf -- "$lock" 2>/dev/null || true
        continue
      fi
    fi
    tries=$((tries + 1))
    [ "$tries" -ge "$max_tries" ] && die "could not acquire lock after ${max_tries} tries: $lock"
    sleep 0.1
  done
  LOCK_DIR="$lock"
  echo "$$" > "$lock/pid" 2>/dev/null || true
}

count_rows() { grep -c '^| run-' "$1" 2>/dev/null || true; }

# current_status enum — policy is enum-only (templates/runtime_status.md "Status Values").
# The status table is fixed-layout; current_status is field 6 when the row is split on '|'
# (leading empty field 1). Field index verified against live rows via `awk -F'|' '{print $6}'`.
# approval_state has no enum in the template, so it is intentionally NOT policed here.
STATUS_ENUM="planned running awaiting_approval blocked complete aborted"
validate_status_value() {
  local v
  v="$(printf '%s\n' "$1" | awk -F'|' '{print $6}' | sed 's/^[[:space:]]*//; s/[[:space:]]*$//')"
  case " $STATUS_ENUM " in
    *" $v "*) :;;
    *) die "current_status '$v' not in enum ($STATUS_ENUM); see templates/runtime_status.md Status Values";;
  esac
}

validate_run_id() {
  case "$1" in
    *[!A-Za-z0-9_-]*|"") die "invalid run-id '$1' (allowed: A-Z a-z 0-9 _ -)";;
  esac
}

# Status rows are keyed by a 'run-' prefixed id (templates/runtime_status.md Index Row Format:
# 'run-YYYYMMDD-NNN'). count_rows, the append anchor, and the update matcher all key on '^| run-',
# so a status run-id MUST start with 'run-' or append-verify miscounts and rejects a valid row with
# a misleading "rows N->N" error. Enforced here (status only). agent-run ids use the separate
# 'YYYYMMDD-HHMMSS-command-agent' format and intentionally stay permissive via validate_run_id.
validate_status_run_id() {
  case "$1" in
    run-*) :;;
    *) die "status run-id must start with 'run-' (e.g. run-YYYYMMDD-NNN); got '$1'";;
  esac
}

# ---- status mode -------------------------------------------------------------
status_mode() {
  local action="${1:-}"; shift || true
  local run_id="" row=""
  while [ $# -gt 0 ]; do
    case "$1" in
      --run-id) run_id="${2:-}"; shift 2;;
      --row)    row="${2:-}"; shift 2;;
      *) usage;;
    esac
  done
  [ -n "$run_id" ] && [ -n "$row" ] || usage
  validate_run_id "$run_id"
  validate_status_run_id "$run_id"
  case "$row" in *$'\n'*) die "row must be a single line (no embedded newlines)";; esac
  case "$row" in *"$run_id"*) :;; *) die "row does not contain run-id '$run_id'";; esac
  validate_status_value "$row"
  [ -f "$STATUS_FILE" ] || die "status file not found: $STATUS_FILE"

  acquire_lock "$REPO_ROOT/logs/.runtime_status.lock"

  local tmp before after hits
  tmp="$(mktemp "${STATUS_FILE}.XXXXXX")"
  before="$(count_rows "$STATUS_FILE")"

  if [ "$action" = "append" ]; then
    # Insert after the LAST existing data row; fall back to after the table separator.
    awk -v row="$row" '
      /^\| run-/   { last = NR }
      /^\|[- ]+\|/ { if (sep == 0) sep = NR }
      { line[NR] = $0 }
      END {
        anchor = (last > 0) ? last : sep
        if (anchor == 0) { for (i = 1; i <= NR; i++) print line[i]; print row; exit }
        for (i = 1; i <= NR; i++) { print line[i]; if (i == anchor) print row }
      }
    ' "$STATUS_FILE" > "$tmp"
    after="$(count_rows "$tmp")"
    [ "$after" -eq "$((before + 1))" ] || { rm -f "$tmp"; die "append verify failed: rows ${before}->${after} (expected +1)"; }
  elif [ "$action" = "update" ]; then
    hits="$(grep -c "^| $run_id |" "$STATUS_FILE" || true)"
    [ "$hits" -eq 1 ] || { rm -f "$tmp"; die "update needs exactly one existing row for '$run_id', found $hits"; }
    awk -v rid="$run_id" -v row="$row" '
      $0 ~ ("^\\| " rid " \\|") { print row; next }
      { print }
    ' "$STATUS_FILE" > "$tmp"
    after="$(count_rows "$tmp")"
    [ "$after" -eq "$before" ] || { rm -f "$tmp"; die "update verify failed: row count changed ${before}->${after}"; }
  else
    rm -f "$tmp"; usage
  fi

  # Read-back: the run-id must now appear exactly once.
  hits="$(grep -c "| $run_id |" "$tmp" || true)"
  [ "$hits" -eq 1 ] || { rm -f "$tmp"; die "verify failed: run-id '$run_id' appears $hits time(s), expected 1"; }

  cp "$STATUS_FILE" "${STATUS_FILE}.bak"
  mv "$tmp" "$STATUS_FILE"          # atomic on same filesystem
  rm -f "${STATUS_FILE}.bak"
  echo "OK status $action: $run_id (rows ${before}->${after})"
}

# ---- agent-run mode ----------------------------------------------------------
agent_run_mode() {
  local run_id=""
  while [ $# -gt 0 ]; do
    case "$1" in
      --run-id) run_id="${2:-}"; shift 2;;
      *) usage;;
    esac
  done
  [ -n "$run_id" ] || usage
  validate_run_id "$run_id"
  mkdir -p "$AGENT_RUNS_DIR"

  acquire_lock "$REPO_ROOT/logs/.agent_runs.lock"

  # No-overwrite: auto-suffix instead of clobbering a sibling step's file.
  local path="$AGENT_RUNS_DIR/$run_id.md" n=2
  while [ -e "$path" ]; do
    path="$AGENT_RUNS_DIR/${run_id}-${n}.md"
    n=$((n + 1))
  done

  local tmp; tmp="$(mktemp "${path}.XXXXXX")"
  cat > "$tmp"                      # body from stdin
  [ -s "$tmp" ] || { rm -f "$tmp"; die "agent-run entry is empty (provide body on stdin)"; }
  mv "$tmp" "$path"
  [ -s "$path" ] || die "verify failed: $path missing or empty after write"
  echo "OK agent-run: $path"
}

# ---- dispatch ----------------------------------------------------------------
[ $# -ge 1 ] || usage
mode="$1"; shift
case "$mode" in
  status)    status_mode "$@";;
  agent-run) agent_run_mode "$@";;
  -h|--help) usage;;
  *) usage;;
esac
