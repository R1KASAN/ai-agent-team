---
command: codex-refactor
tier: optional_utility
core_flow: false
maps_archived: rex_codex_refactorer → coda_codex_builder (Rex → Coda + Kyuuei)
description: Surgically refactor scoped code without changing observable behaviour.
entry_agent: coda_codex_builder
context_budget: small
required_input: debug_report.md or explicit refactor scope from codex_task_packet.md
optional_input: supporting artifact paths, constraints, risk notes, approval notes; never full chat history
forbidden_actions: bypassing Minori, skipping artifact gates, starting downstream workflows automatically, using large/dynamic context without approval, overwriting existing files without approval, deciding product strategy, editing out-of-scope files, deploying production, modifying auth/payment/database/infrastructure without approval
produces: refactor_report.md
approval_gate: out-of-scope refactor requires Rika-Chan approval before proceeding
stop_condition: refactor_report.md produced; routes to /codex-security-check
ref: workflows/codex_build_loop.md
---

Optional owner-invokable utility — not part of the core flow. Coda (refactor mode) refactors only the
scoped area. Behaviour must be preserved. Any discovered out-of-scope issue is flagged and held — not
fixed — until Rika-Chan approves expansion.
