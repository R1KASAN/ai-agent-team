---
command: codex-ship-check
tier: optional_utility
core_flow: false
maps_archived: shippo_codex_ship_checker → kyuuei_test_debug (Shippo → Coda + Kyuuei + Rika-Chan ship gate)
description: Run the pre-ship readiness checklist covering build, tests, lint, UX, and security.
entry_agent: kyuuei_test_debug
context_budget: small
required_input: pr_summary.md
optional_input: supporting artifact paths, constraints, risk notes, approval notes; never full chat history
forbidden_actions: bypassing Minori, skipping artifact gates, starting downstream workflows automatically, using large/dynamic context without approval, overwriting existing files without approval, deciding product strategy, editing out-of-scope files, deploying production, modifying auth/payment/database/infrastructure without approval
produces: ship_check.md
approval_gate: Rika-Chan final sign-off required before any deployment; best verdict is ready_pending_approval
stop_condition: ship_check.md produced; never deploys; deployment requires explicit Rika-Chan action
ref: workflows/codex_build_loop.md · governance/approval_gates.md
---

Optional owner-invokable utility — not part of the core flow. Last automated step before Rika-Chan
decides on deployment. Kyuuei (ship-check mode) produces ship_check.md and stops. Deployment is always
a human decision (Rika-Chan ship/deploy hard gate).
