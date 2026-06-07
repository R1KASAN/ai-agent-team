---
log: assumption_log
maintained_by: Vera Critical Verifier
appended_by: Vera · Yuki · Minori
version: "1.0"
---

# Assumption Log

Record every labeled assumption produced during any workflow. Assumptions must be validated by evidence before being used as the basis for product, architectural, or business decisions.

## Entry Format

```yaml
- assumption_id: ""       # e.g. A1, A2 — unique across project
  date: ""
  workflow_id: ""
  assumption: ""
  labeled_by: ""          # agent that identified it
  risk_level: ""          # high / medium / low
  status: ""              # unvalidated / validated / falsified / deferred
  evidence_ref: ""        # evidence_pack or source that validates/falsifies
  notes: ""
```

## Status Rules

- `unvalidated` — assumption exists but no evidence collected yet
- `validated` — evidence supports the assumption (cite source)
- `falsified` — evidence contradicts the assumption (update product direction)
- `deferred` — validation deprioritised; must not be used as primary basis for decisions

---

## Assumptions

<!-- Entries appended here by Vera, Yuki, or Minori during live workflows. -->
<!-- Most recent entry at top. -->

