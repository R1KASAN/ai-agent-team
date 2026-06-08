---
template: agent_run_log
version: "1.0"
created: "2026-06-07"
---

# Agent Run Log

```yaml
run_id: ""              # YYYYMMDD-HHMMSS-command-agent
created_at: ""
agent: ""
command: ""
mode: ""                # classify | recall | intake | verify | build | test | review | governance | utility
workflow_id: ""
context_budget: small

files_read: []
files_written: []
sources_used: []
approval_gates_hit: []

notebooklm_mission_info:
  used: false
  approval_ref: ""
  mission_id: ""
  source_actions: []
  query_summary: ""
  output_artifact: ""

final_artifact_paths: []
redactions: []
notes: ""
```

## Rules

- Written **inline by the orchestrating session**, never by spawning a separate "logger" agent.
- Write via `scripts/safe_log_write.sh agent-run --run-id <id> < entry.md` — one file per step at
  `logs/agent_runs/<id>.md` (`id = YYYYMMDD-HHMMSS-command-agent`); **no-overwrite** (auto-suffixes
  `-2`, `-3`… on collision, per the No-Overwrite Rule), then verifies the file is non-empty.
- Required for every route beyond pure classification — full pipeline steps **and** fast-path
  consults — immediately after each step returns and before the next step is spawned.
- Do not paste full source content, full chat history, or full vault contents.
- Redact sensitive/restricted details and link only to approved artifacts.
- NotebookLM-py entries require the Rika-Chan approval reference.
