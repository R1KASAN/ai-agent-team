---
workflow_id: evidence_crosscheck
slash_command: /evidence-crosscheck
entry_agent: Minori Lead Conductor
context_budget: small
version: "2.0"
---

# Workflow: evidence_crosscheck

## Purpose

Find and verify evidence for a specific research question without relying on raw web search as final truth. Produces a verified evidence pack ready for downstream agents.

## Prerequisites

- Research question or `evidence_questions_for_nova_v.md` from Yuki
- `workflow_plan.md` from Minori

## Flow

```
Research question
→ Minori: workflow_plan.md                    [context_budget: small]
→ Nova-V: source_candidate_list.md            [context_budget: small]
          *** APPROVAL if >10 sources or high-stakes domain ***
→ Nova-V: verified_evidence_pack.md           [context_budget: small]
          (evidence discovery + verification in one loop, ≤2 hops)
          + assumption_log update
          + risk_log update
→ handoff to Sora / Bumi (if part of larger workflow)
```

## Agent Sequence

| Step | Agent | Input | Output | Stop Condition |
|------|-------|-------|--------|---------------|
| 1 | Minori | research question | `workflow_plan.md` | Plan complete |
| 2 | Nova-V | `workflow_plan.md` | `source_candidate_list.md` | Source candidates identified |
| 3 | Nova-V | `source_candidate_list.md` | `verified_evidence_pack.md` | Evidence collected and claims classified |

## Approval Gates

- **Step 2 → 3:** Rika-Chan approval if source batch >10 or domain is high-stakes (finance, legal, privacy, security, health, infra)
- Any `large` or `dynamic` context budget → Rika-Chan approval

## Stop Conditions

- Confidence too low and sources conflict → stop at Step 3; extend evidence pack before proceeding
- High-stakes domain with unresolved source conflict → escalate to Rika-Chan before downstream use
- Privacy/legal/security/source-quality flag → run `/governance-check`; blocked verdict stops downstream use

## Evidence Rules

- Web search = source discovery only; not used as final evidence
- NotebookLM-py = Nova-V-only deep source reading of approved selected sources; per-command Rika-Chan approval required
- NotebookLM-py output is not truth; Nova-V must verify every downstream claim
- LLM Wiki = source selection rules only; not factual evidence
- Sources failing Nova's quality rubric must be excluded or flagged

## Output Artifacts

`source_candidate_list.md` · `verified_evidence_pack.md` · `logs/source_log.md` update

## Workflow Type

`sequential_handoff`
