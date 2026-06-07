---
workflow_id: product_idea_to_prd
slash_command: /product-idea-to-prd
entry_agent: Minori Lead Conductor
context_budget: small
version: "1.1"
---

## Entry Gate

This workflow may only start from a Minori-approved `workflow_plan.md` or `handoff.md`. If no Minori workflow_plan exists, stop and run Input Gatekeeper first.

---

# Workflow: product_idea_to_prd

## Purpose

Convert an approved Product Opportunity Brief into an MVP-first PRD with acceptance criteria and explicit out-of-scope list.

## Prerequisites

- `product_opportunity_brief.md` approved by Rika-Chan
- `business_analysis_brief.md` and `strategic_lens.md` available as context

## Flow

```
Approved product_opportunity_brief.md
→ Minori: workflow_plan.md                    [context_budget: small]
→ Poom: prd.md                                [context_budget: small]
         + mvp_scope.md
         + acceptance_criteria.md
         + out_of_scope.md
→ Sora: strategic review of prd.md            [context_budget: small]
→ Bumi: business review of prd.md             [context_budget: small]
→ Governance review (Rika-Chan gate + `governance/` docs) [context_budget: small]
         → governance_check.md
         *** APPROVAL GATE — Rika-Chan ***
```

## Agent Sequence

| Step | Agent | Input | Output | Stop Condition |
|------|-------|-------|--------|---------------|
| 1 | Minori | approved brief | `workflow_plan.md` | Plan complete |
| 2 | Poom | `product_opportunity_brief.md` | `prd.md` + companions | PRD complete with all sections |
| 3 | Sora | `prd.md` | strategic review notes | Strategy alignment confirmed or flagged |
| 4 | Bumi | `prd.md` + Sora notes | business review notes | Business model alignment confirmed or flagged |
| 5 | Governance review | `prd.md` | `governance_check.md` | Privacy, legal, security reviewed |

## Approval Gates

- **Entry:** `product_opportunity_brief.md` must be Rika-Chan-approved before this workflow starts
- **Step 5 exit:** Rika-Chan must approve the final `prd.md` before any build begins
- **Before Aki:** `workflow_plan.md` must include Gate Scope Pre-Clarification with Expected Gates +
  Pre-Decide vs Defer before PRD handoff to Aki
- Any scope addition beyond initial MVP → Rika-Chan approval
- Any auth / payments / database / infra items in PRD → flagged for Rika-Chan before Aki runs
- If auth / payments / database / infra / paid API / hosting is likely, Minori asks Rika-Chan which
  gates to pre-decide and which to defer to `Coda proposes options + Rika-Chan approves before
  implementation/spend/deploy`

## Stop Conditions

- Sora flags a major strategic misalignment → stop; revise PRD before Bumi runs
- Bumi verdict is `not_viable` → stop; Rika-Chan decides before governance review
- `governance_check.md` verdict is `block` → stop; resolve before Rika-Chan sees PRD
- PRD is ready for Aki but Gate Scope Pre-Clarification is missing or unresolved → stop before Aki

## Output Artifacts

`prd.md` · `mvp_scope.md` · `acceptance_criteria.md` · `out_of_scope.md` · `governance_check.md`

## Workflow Type

`sequential_handoff`
