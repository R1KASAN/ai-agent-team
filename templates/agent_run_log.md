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

- Do not paste full source content, full chat history, or full vault contents.
- Redact sensitive/restricted details and link only to approved artifacts.
- NotebookLM-py entries require the Rika-Chan approval reference.
