---
artifact: top_riskiest_assumptions
agent: yuki_idea_challenger
workflow_plan: workflow_plan_20260605_003
input_from: idea_challenge_brief_20260605_003.md
context_budget: tiny
produced_at: "2026-06-05"
handoff_to: nova_evidence_scout
---

# Top Riskiest Assumptions

Ranked by: (desirability risk × feasibility risk × viability risk). Test highest-ranked first.

## A1 — Structured agent workflows beat unstructured prompting for solo operators
**Rank: 1 (highest risk)**
Assumption: users prefer a disciplined multi-step workflow over asking a single Claude session directly.
Why risky: zero evidence this is true for solo founders. The alternative (one prompt) is free, instant, and already used.
Test type: behavioral — watch whether Rika-Chan actually completes a full product_idea_debate workflow vs. shortcuts.
Evidence needed: adoption behavior data; competitor analysis of structured vs. unstructured AI product tools.

## A2 — Artifact discipline reduces total cognitive load
**Rank: 2**
Assumption: maintaining workflow_plan.md, handoffs, context packs, and source logs costs less mental energy than it saves.
Why risky: artifact overhead is real. If writing idea_challenge_brief.md feels like homework, the system will be abandoned.
Test type: usability — is the first workflow cycle faster or slower than a raw conversation?
Evidence needed: user time-to-output data; friction points in first workflow run.

## A3 — 14 agents provide signal that a single agent cannot
**Rank: 3**
Assumption: specialist agent personas (Yuki vs. Nova vs. Vera vs. Bumi) produce meaningfully different and better outputs than a single well-prompted session.
Why risky: without persona separation enforced by actual model isolation, agents may produce similar outputs regardless of persona.
Test type: output quality comparison — same input, single session vs. agent team workflow.
Evidence needed: qualitative output diff across 3+ workflows.

## A4 — Rika-Chan will maintain approval gate discipline under time pressure
**Rank: 4**
Assumption: the human decision-maker consistently stops at approval gates and does not bypass them when momentum builds.
Why risky: approval gates only work if they are respected. Systemic bypass turns the OS into a rubber stamp.
Test type: behavioral — track how many approval gates are actually triggered vs. bypassed over 10 workflow cycles.
Evidence needed: usage log data.

## A5 — Sequential handoff is more token-efficient than a single long session
**Rank: 5**
Assumption: breaking work into agent handoffs with context compaction reduces total token cost vs. one long Claude session.
Why risky: handoff overhead (workflow_plan.md, context packs, handoff.md) may add tokens rather than reduce them for short workflows.
Test type: cost measurement — count tokens per workflow type vs. equivalent single session.
Evidence needed: token usage data across 5+ workflow cycles.
