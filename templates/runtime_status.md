---
template: runtime_status
produced_by: Minori Lead Conductor
runtime_mode: level_1_status_only
version: "1.0"
---

# Runtime Status Template

Level 1 Runtime is status-only. It provides workflow visibility without spawning agents, scheduling
tasks, enabling parallel/fanout, or changing the sequential-by-default routing law.

## Status Values

`planned` | `running` | `awaiting_approval` | `blocked` | `complete` | `aborted`

## Runtime Modes

`level_1_status_only` (pipeline / sequential routes) | `adhoc_consult` (Minori-gated single-agent
fast-path — see Fast-Path Consult in `workflows/idea_gate.md`) | `telegram_gateway_v1`
(approval-first Telegram inbox/queue dispatch; no LLM from status/approve/reject/budget). An
`adhoc_consult` row is structurally distinct from a pipeline row and its output artifact follows the
collision-proof name `handoffs/adhoc_<agent-key>_<YYYYMMDD_HHMMSS>.md`.

## Index Row Format

Append or update a compact row in `logs/runtime_status.md`:

| run_id | command | workflow_id | runtime_mode | current_status | current_agent | approval_state | input_artifact | latest_artifact | next_step | updated_at |
|---|---|---|---|---|---|---|---|---|---|---|
| run-YYYYMMDD-NNN | /idea-gate | idea_gate | level_1_status_only | planned | Minori Lead Conductor | none | raw_input | handoffs/workflow_plan_YYYYMMDD_NNN.md | route_or_stop | YYYY-MM-DD |

## Append + Verify Write Protocol (Layer 1 — the real fix for row loss)

This file is a single shared table; an ad-hoc full-file rewrite (or two concurrent writers) can
silently drop another run's row. All writes go through one locked, append-only, read-back-verified
helper — never a hand-edited full-file rewrite:

- Append a row: `scripts/safe_log_write.sh status append --run-id <id> --row '<one-line row>'`
  (portable `mkdir`-mutex lock; appends after the last data row; reads back to confirm rows went up
  by exactly one and `<id>` appears exactly once; on mismatch leaves the file untouched and exits
  non-zero).
- Transition an existing row: `scripts/safe_log_write.sh status update --run-id <id> --row '<row>'`
  (edits only the line matching `<id>`; verifies exactly one match).

## Usage Guidance (Layer 2 — prevention)

- Sequential-by-default = one writer at a time; do not run two concurrent sessions writing this file.
- One `run_id` per run; edit only your own run's row by `run_id`; never rewrite the whole table.
- Paths, never bodies — keep every row one line so append + verify stays reliable.

## Rules

- Do not paste full chat history, source text, vault contents, or large artifacts into the runtime
  status row.
- Use artifact paths, not artifact bodies.
- Do not create an extra agent call only to update runtime status.
- `task_queue` means the planned next step in the status row, not a real scheduler.
- `artifact_return` means the latest output artifact path, not copied artifact content.
- Agent-level audit logs still use `templates/agent_run_log.md` under `logs/agent_runs/`, written via
  the same `scripts/safe_log_write.sh agent-run` helper.
