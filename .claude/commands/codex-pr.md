---
command: codex-pr
tier: optional_utility
core_flow: false
maps_archived: pria_codex_pr_maker → coda_codex_builder (Pria → Coda + Kyuuei)
description: Produce a PR summary with changed files, test evidence, and risk notes.
entry_agent: coda_codex_builder
context_budget: small
required_input: security_check.md with pass or conditional_pass verdict
optional_input: supporting artifact paths, constraints, risk notes, approval notes; never full chat history
forbidden_actions: bypassing Minori, skipping artifact gates, starting downstream workflows automatically, using large/dynamic context without approval, overwriting existing files without approval, deciding product strategy, editing out-of-scope files, deploying production, modifying auth/payment/database/infrastructure without approval
produces: pr_summary.md
approval_gate: blocked security_check.md prevents this command from starting
stop_condition: pr_summary.md produced; routes to /codex-ship-check; never merges
ref: workflows/codex_build_loop.md
---

Optional owner-invokable utility — not part of the core flow. Cannot start if /codex-security-check
(Kyuuei) returned a blocked verdict. Coda (PR mode) summarises all changes, test results, and risk
notes into pr_summary.md for /codex-ship-check pre-ship review. Never merges — merge is a human action.
