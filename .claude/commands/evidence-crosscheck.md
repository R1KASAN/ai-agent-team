---
command: evidence-crosscheck
description: Gather and verify evidence for a specific claim, question, or idea component.
entry_agent: minori_lead_conductor
context_budget: small
required_input: idea_challenge_brief.md or explicit research question
optional_input: supporting artifact paths, constraints, risk notes, approval notes; never full chat history
forbidden_actions: bypassing Minori, skipping artifact gates, starting downstream workflows automatically, using large/dynamic context without approval, overwriting existing files without approval, skipping Rika-Chan approval for strategic, evidence, PRD, roadmap, or implementation-readiness decisions
produces: verified_evidence_pack.md
approval_gate: none; web search is discovery only — not treated as verified fact
stop_condition: verified_evidence_pack.md produced; low-confidence or unsupported claims flagged for Rika-Chan
ref: workflows/evidence_crosscheck.md
---

Nova-V gathers sources and classifies every claim in one evidence+verification loop (≤2 hops). All
findings are labelled FACT / ASSUMPTION / OPINION / UNSUPPORTED / CONTRADICTION /
HALLUCINATION_RISK before use downstream.
