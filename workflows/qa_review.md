---
workflow_id: qa_review
slash_command: /qa-review
entry_agent: Tessa QA/UX Inspector
context_budget: small
version: "1.1"
---

## Entry Gate

This workflow may only start from a Minori-approved `workflow_plan.md` or `handoff.md`. If no Minori workflow_plan exists, stop and run Input Gatekeeper first.

---

# Workflow: qa_review

## Purpose

Review a completed build from a UX and product-flow perspective. Ensures the implementation serves the intended user and meets acceptance criteria before governance and ship check.

## Prerequisites

- `build_report.md` from Coda (build complete)
- `acceptance_criteria.md` from Poom
- `prd.md` available as reference

## Flow

```
build_report.md
→ Tessa: qa_ux_report.md                      [context_budget: small]
         *** STOP if verdict is blocked ***
→ Governance review (governance/ checklist)   [context_budget: small]
         → governance_check.md
         *** STOP if verdict is block → Rika-Chan resolves ***
→ Kaizen pass (token convention, at session close)
```

## Agent Sequence

| Step | Owner | Input | Output | Stop Condition |
|------|-------|-------|--------|---------------|
| 1 | Tessa | `build_report.md` + `acceptance_criteria.md` | `qa_ux_report.md` | All criteria checked; UX findings logged |
| 2 | Governance review (Rika-Chan gate + `governance/` docs) | `qa_ux_report.md` | `governance_check.md` | Privacy, security, data risks reviewed |

> Kaizen (token/context waste) is applied as a shared convention at session close, not a separate agent step.

## Approval Gates

- **Step 1 → 2:** `qa_ux_report.md` verdict must not be `blocked` — fix build first
- **Step 2:** Any `block` in `governance_check.md` → Rika-Chan resolves before workflow closes
- `qa_ux_report.md` risk flag of type `security` or `privacy` → escalated to Rika-Chan

## Stop Conditions

- `qa_ux_report.md` overall_verdict is `blocked` → stop; route back to Coda for fix before governance review runs
- Any acceptance criterion `fail` → stop; do not mark review complete
- `governance_check.md` verdict is `block` → stop; Rika-Chan resolves

## Output Artifacts

`qa_ux_report.md` · `governance_check.md`

## Workflow Type

`sequential_handoff`
