---
log: risk_log
maintained_by: Gina Governance Guardian
appended_by: Gina · Vera · Minori · Seco
version: "1.0"
---

# Risk Log

Record every risk identified during any workflow. High-severity risks must be reviewed by Gina and surfaced to Rika-Chan before the workflow proceeds past the relevant gate.

## Entry Format

```yaml
- risk_id: ""             # e.g. R1, R2 — unique across project
  date: ""
  workflow_id: ""
  risk: ""
  identified_by: ""       # agent that flagged it
  type: ""                # product / technical / business / legal / privacy / security / data / ux
  severity: ""            # high / medium / low
  likelihood: ""          # high / medium / low
  mitigation: ""
  owner: ""               # Rika-Chan / agent / deferred
  status: ""              # open / mitigated / accepted / escalated / closed
  artifacts_ref: []
```

## Severity Rules

- `high` → must surface to Rika-Chan; workflow may not proceed past gate until resolved or accepted
- `medium` → document and monitor; may proceed with explicit acknowledgement
- `low` → log and continue

---

## Risks

<!-- Entries appended here by Gina, Vera, Minori, or Seco during live workflows. -->
<!-- Most recent entry at top. -->

