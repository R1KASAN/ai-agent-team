---
command: prd-to-codex-tasks
description: Translate an approved PRD into a Codex task packet ready for implementation.
entry_agent: aki_system_architect
context_budget: medium
required_input: approved prd.md
optional_input: supporting artifact paths, constraints, risk notes, approval notes; never full chat history
forbidden_actions: bypassing Minori, skipping artifact gates, starting downstream workflows automatically, using large/dynamic context without approval, overwriting existing files without approval, skipping Rika-Chan approval for strategic, evidence, PRD, roadmap, or implementation-readiness decisions
produces: codex_task_packet.md (includes files_likely_affected, test plan, approval_gates)
approval_gate: approved prd.md required before start; Gate Scope Pre-Clarification required before Aki; auth/payment/db/infra items require separate Rika-Chan approval unless explicitly deferred to a named checkpoint
stop_condition: codex_task_packet.md produced; Codex Team does not auto-start
ref: workflows/prd_to_codex_tasks.md
---

Aki translates the PRD into a scoped, minimal task packet. Before Aki starts, `workflow_plan.md` must
include **Expected Gates + Pre-Decide vs Defer**. High-risk items (auth, payment, db, infra, hosting,
paid API/spend, deploy) are either pre-decided by Rika-Chan or deferred to a named checkpoint such as
`Coda proposes options + Rika-Chan approves before implementation/spend/deploy`; Coda must not
implement unresolved gates.
