---
template: notebooklm_mission
version: "1.0"
owner: nova_v
---

# NotebookLM-py Mission

```yaml
mission_id: ""
requested_by: "Nova-V"
approval_ref: ""        # required before install/login/add-source/query/export
approved_at: ""
source_scope: []
privacy_screen:
  privacy_level: ""
  pii_present: false
  restricted_present: false
  decision: ""          # approved | blocked | fallback

notebooklm_actions:
  install: false
  login: false
  add_source: false
  query: false
  export: false

query_summary: ""
structured_output_path: ""
nova_v_verification_path: ""
mira_write_target: "knowledge/research/[slug].md"
graph_update_path: ""
fallback_used: ""
```

## Rules

- NotebookLM-py output is not truth.
- Nova-V verifies every claim before downstream use.
- Mira writes research notes after verification.
- Sensitive/restricted sources require explicit Rika-Chan approval or fallback.
