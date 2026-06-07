---
workflow_id: governance_check
slash_command: /governance-check
entry_agent: Minori (gate) → Rika-Chan governance gate
context_budget: small
version: "1.1"
---

# Workflow: governance_check

## Purpose

Standalone governance review for any artifact or decision that touches data, privacy, legal, or security concerns. Can be invoked independently or as an embedded step in other workflows. Governance is enforced by the Rika-Chan hard gate + `governance/` docs (the standalone Gina agent is archived; the function is retained).

## Prerequisites

- Artifact to review (any type)
- `logs/risk_log.md` available as reference
- `logs/source_log.md` available if reviewing evidence

## Flow

```
Artifact for review
→ Minori: workflow_plan.md                    [context_budget: small]
→ Governance review (governance/ checklist)   [context_budget: small]
         → governance_check.md + risk_log update
         *** STOP if verdict is block → Rika-Chan resolves ***
→ Kaizen pass (token convention, not an agent step)
```

## Agent Sequence

| Step | Owner | Input | Output | Stop Condition |
|------|-------|-------|--------|---------------|
| 1 | Minori | artifact + context | `workflow_plan.md` | Plan complete |
| 2 | Governance review (Rika-Chan gate + `governance/` docs) | artifact + `risk_log.md` + `source_log.md` | `governance_check.md` + `risk_log` update | All categories reviewed |

> Kaizen (token/context waste) is applied as a shared convention at session close, not a separate agent step.

## Approval Gates

- Any `block` verdict in `governance_check.md` → Rika-Chan must resolve before workflow output is used downstream
- PII, legal, or security flags → Rika-Chan notified even if verdict is `flag` not `block`

## Stop Conditions

- `governance_check.md` verdict is `block` → stop; Rika-Chan resolves before any downstream agent uses the reviewed artifact
- Sensitive data found without prior flagging → stop; Mira must tag before governance review proceeds

## When Embedded vs Standalone

**Embedded:** Called as a step inside `product_idea_debate`, `product_idea_to_prd`, `qa_review`, and `evidence_crosscheck`. The governance review receives the artifact directly from the prior agent.

**Standalone:** Triggered via `/governance-check` when Rika-Chan wants a one-off review of any artifact or decision.

## Output Artifacts

`governance_check.md` · `logs/risk_log.md` update

## Workflow Type

`sequential_handoff`
