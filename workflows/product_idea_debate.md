---
workflow_id: product_idea_debate
slash_command: /product-idea-debate
entry_agent: minori_lead_conductor
context_budget: small
version: "2.0"
---

# Workflow: product_idea_debate  (v2.0 — Startup Studio OS v1.0 pivot)

## Purpose

Challenge and improve a product or project idea before any evidence search, PRD, or build begins.
Produces a Product Opportunity Brief for Rika-Chan approval.

## What changed from v1.0

- **Nova → Vera two-step replaced by Nova-V (NV)** — a single merged agent that finds evidence and
  verifies it in one loop (≤2 hops). Output is `verified_evidence_pack.md` (code `ep`).
- **Gina (governance) and Kai (kaizen) are no longer active workflow steps.** Their functions are
  preserved as backend: governance → Rika-Chan hard gates + `governance/` docs; kaizen → shared token
  convention. They are reference-only, not agents in the chain.
- Active chain length: 6 thinking steps (Mi → Yu → NV → So → Bu → Po) + Rika-Chan gate.

## Prerequisites

- `workflow_plan.md` produced by Minori via `idea_gate`
- Rika-Chan has not yet approved a PRD — this workflow runs before that

## Flow

```
Rika-Chan idea input
→ Minori: workflow_plan.md                    [context_budget: small]   wp
→ Yuki:   idea_challenge_brief.md             [context_budget: small]
→ Nova-V: verified_evidence_pack.md           [context_budget: small]   ep
          (find evidence → verify in one loop, ≤2 hops)
          + assumption_log update
          + risk_log update
→ Sora:   strategic_lens.md                   [context_budget: small]   sl
→ Bumi:   business_analysis_brief.md          [context_budget: small]   ba
→ Poom:   product_opportunity_brief.md        [context_budget: small]   pb
          *** APPROVAL GATE — Rika-Chan ***
```

> Backend reference (not active steps): governance review = Rika-Chan hard gates + `governance/`
> docs; kaizen waste review = shared token convention in CLAUDE.md. Invoke `/governance-check`
> on demand only if a privacy/legal/security flag is raised.

## Agent Sequence

| Step | Agent | Input | Output | Stop Condition |
|------|-------|-------|--------|---------------|
| 1 | Minori | raw idea | `workflow_plan.md` | Plan complete |
| 2 | Yuki | `workflow_plan.md` | `idea_challenge_brief.md` | Riskiest assumptions identified |
| 3 | Nova-V | `idea_challenge_brief.md` | `verified_evidence_pack.md` | Evidence found + claims classified (≤2 hops) |
| 4 | Sora | `verified_evidence_pack.md` | `strategic_lens.md` | Bet and moat identified |
| 5 | Bumi | `strategic_lens.md` | `business_analysis_brief.md` | WTP signal and business risk assessed |
| 6 | Poom | `business_analysis_brief.md` | `product_opportunity_brief.md` | Brief complete |

## Approval Gates

- **Step 6 → build:** Rika-Chan must approve `product_opportunity_brief.md` before any PRD begins
- Any `large` or `dynamic` context budget escalation → Rika-Chan approval
- Any privacy / legal / security flag → Rika-Chan hard gate (governance backend)

## Stop Conditions

- Missing input artifact at any step → generate artifact first, do not skip
- `strategic_lens.md` recommends `kill` → stop; Rika-Chan decides before Bumi runs
- `business_analysis_brief.md` verdict is `not_viable` → stop; Rika-Chan decides before Poom runs
- Any Rika-Chan hard gate triggered → stop and ask the owner

## Output Artifacts

`idea_challenge_brief.md` · `verified_evidence_pack.md` · `strategic_lens.md` ·
`business_analysis_brief.md` · `product_opportunity_brief.md`

## Workflow Type

`sequential_handoff`

## Governance

- Sequential-by-default: no parallel fanout unless all six conditions + Rika-Chan approval.
- Agent Registry Lock: Nova-V is the only evidence/verify agent; Nova, Vera, Gina, Kai are archived
  (backend functions, not invocable in this chain).
- Source quality + verification handled inside Nova-V per `llm_wiki/evidence_source_rules.md`.
