---
command: codex-debug
tier: optional_utility
core_flow: false
maps_archived: bugsy_codex_debugger → kyuuei_test_debug (Bugsy merged into Kyuuei)
description: Reproduce, trace, hypothesize, and minimally fix a failing test or bug.
entry_agent: kyuuei_test_debug
context_budget: small
required_input: test_report.md with failures; or explicit bug description
optional_input: supporting artifact paths, constraints, risk notes, approval notes; never full chat history
forbidden_actions: bypassing Minori, skipping artifact gates, starting downstream workflows automatically, using large/dynamic context without approval, overwriting existing files without approval, deciding product strategy, editing out-of-scope files, deploying production, modifying auth/payment/database/infrastructure without approval
produces: debug_report.md
approval_gate: none; scope-expanding fixes require Rika-Chan approval before implementation
stop_condition: debug_report.md produced; routes to /codex-refactor (Coda) or back to /codex-test (Kyuuei)
ref: workflows/codex_build_loop.md
---

Optional owner-invokable utility — not part of the core flow. Kyuuei (debug mode) follows
debug-mantra: reproduce → trace → hypothesize → fix minimally. Fix must not exceed task packet scope
without approval.
