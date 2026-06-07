---
log: source_log
maintained_by: Nova Evidence Scout
appended_by: Nova · Mira
version: "1.0"
---

# Source Log

Record every external source used in any evidence pack, memory intake, or research workflow. Sources without entries here are not valid as primary evidence.

## Entry Format

```yaml
- source_id: ""           # e.g. S1, S2 — unique across project
  date: ""
  workflow_id: ""
  source_url_or_path: ""
  source_type: ""         # article / paper / book / dataset / interview / screenshot / note / official_doc
  captured_at: ""
  owner: ""               # author / organisation / unknown
  topic: ""
  entities: []
  confidence: ""          # high / medium / low
  privacy_level: ""       # public / internal / sensitive / restricted
  usage_decision: ""      # approved / pending / restricted / excluded
  quality_verdict: ""     # pass / flag / fail (per Nova's rubric)
  related_project: ""
  last_verified_at: ""
  notes: ""
```

## Quality Rules

- `No source + no timestamp + low confidence` → not valid as primary evidence
- `privacy_level: restricted` → requires Gina review before use
- `usage_decision: excluded` → must not appear in any evidence pack

---

## Sources

<!-- Entries appended here by Nova or Mira during live workflows. -->
<!-- Most recent entry at top. -->

