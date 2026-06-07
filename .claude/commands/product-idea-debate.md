---
command: product-idea-debate
description: Run the sequential product idea debate from challenge through product opportunity brief.
entry_agent: minori_lead_conductor → yuki_idea_challenger
context_budget: small
required_input: classified idea from /idea-gate; workflow_plan.md must exist
optional_input: supporting artifact paths, constraints, risk notes, approval notes; never full chat history
forbidden_actions: bypassing Minori, skipping artifact gates, starting downstream workflows automatically, using large/dynamic context without approval, overwriting existing files without approval, skipping Rika-Chan approval for strategic, evidence, PRD, roadmap, or implementation-readiness decisions
produces: idea_challenge_brief.md, verified_evidence_pack.md, strategic_lens.md, business_analysis_brief.md, product_opportunity_brief.md
approval_gate: Rika-Chan approval required after product_opportunity_brief.md before PRD/build
stop_condition: product_opportunity_brief.md produced; downstream PRD/build starts only after Rika-Chan approval
ref: workflows/product_idea_debate.md
---

Sequential 6-step thinking workflow. Minori gates first, then Yuki challenges, Nova-V verifies
evidence, Sora/Bumi apply strategic and business lenses, and Poom writes the product opportunity
brief. Rika-Chan approval is required after the brief before any PRD/build work starts.
