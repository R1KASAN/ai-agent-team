---
command: product-idea-to-prd
description: Convert an approved product opportunity brief into a full PRD and MVP scope.
entry_agent: poom_product_manager
context_budget: medium
required_input: approved product_opportunity_brief.md (Rika-Chan approval required before start)
optional_input: supporting artifact paths, constraints, risk notes, approval notes; never full chat history
forbidden_actions: bypassing Minori, skipping artifact gates, starting downstream workflows automatically, using large/dynamic context without approval, overwriting existing files without approval, skipping Rika-Chan approval for strategic, evidence, PRD, roadmap, or implementation-readiness decisions
produces: prd.md
approval_gate: approved brief required as entry; Rika-Chan approval required before PRD is handed to Aki; Gate Scope Pre-Clarification required before Aki
stop_condition: prd.md produced; Aki does not auto-start
ref: workflows/product_idea_to_prd.md
---

Cannot start without an approved brief. Poom writes the PRD and stops. Aki receives it only after
Rika-Chan confirms the PRD is ready for technical planning and Minori records **Expected Gates +
Pre-Decide vs Defer** in `workflow_plan.md`.
