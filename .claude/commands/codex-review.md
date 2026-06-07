---
command: codex-review
description: Run a UX and product-flow review of the built feature against acceptance criteria.
entry_agent: tessa_qa_ux_inspector
context_budget: small
required_input: build_report.md; acceptance criteria from codex_task_packet.md
optional_input: supporting artifact paths, constraints, risk notes, approval notes; never full chat history
forbidden_actions: bypassing Minori, skipping artifact gates, starting downstream workflows automatically, using large/dynamic context without approval, overwriting existing files without approval, deciding product strategy, editing out-of-scope files, deploying production, modifying auth/payment/database/infrastructure without approval
produces: qa_ux_report.md
approval_gate: none; blocked verdict routes to Rika-Chan before governance check
stop_condition: blocked verdict stops workflow before governance review; pass or conditional routes to /governance-check
ref: workflows/qa_review.md
---

Tessa reviews flows, edge cases, and UX quality. A blocked verdict means the feature is not ready —
governance review does not run until Tessa clears it.
