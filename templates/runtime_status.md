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

## Index Row Format

Append or update a compact row in `logs/runtime_status.md`:

| run_id | command | workflow_id | runtime_mode | current_status | current_agent | approval_state | input_artifact | latest_artifact | next_step | updated_at |
|---|---|---|---|---|---|---|---|---|---|---|
| run-YYYYMMDD-NNN | /idea-gate | idea_gate | level_1_status_only | planned | Minori Lead Conductor | none | raw_input | handoffs/workflow_plan_YYYYMMDD_NNN.md | route_or_stop | YYYY-MM-DD |

## Rules

- Do not paste full chat history, source text, vault contents, or large artifacts into the runtime
  status row.
- Use artifact paths, not artifact bodies.
- Do not create an extra agent call only to update runtime status.
- `task_queue` means the planned next step in the status row, not a real scheduler.
- `artifact_return` means the latest output artifact path, not copied artifact content.
- Agent-level audit logs still use `templates/agent_run_log.md` under `logs/agent_runs/`.
