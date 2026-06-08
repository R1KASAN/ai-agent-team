---
log: risk_log
maintained_by: Rika-Chan Decision Gate
appended_by: Minori · Nova-V · Kyuuei · Rika-Chan
version: "1.1"
note: "Owner re-attributed 2026-06-08 from archived Gina/Vera/Seco to active agents. Governance + security functions are preserved via Rika-Chan hard gates, Kyuuei backend security check, and governance/ docs (see CLAUDE.md archived-agents table)."
---

# Risk Log

Record every risk identified during any workflow. High-severity risks must be reviewed at the
Rika-Chan hard gate and surfaced to the owner before the workflow proceeds past the relevant gate.

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

<!-- Entries appended here by Minori, Nova-V, Kyuuei, or Rika-Chan during live workflows. -->
<!-- Most recent entry at top. -->

