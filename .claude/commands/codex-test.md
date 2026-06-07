---
command: codex-test
description: Write and run tests to verify build output against acceptance criteria.
entry_agent: kyuuei_test_debug
context_budget: small
required_input: build_report.md; acceptance criteria from codex_task_packet.md
optional_input: supporting artifact paths, constraints, risk notes, approval notes; never full chat history
forbidden_actions: bypassing Minori, skipping artifact gates, starting downstream workflows automatically, using large/dynamic context without approval, overwriting existing files without approval, deciding product strategy, editing out-of-scope files, deploying production, modifying auth/payment/database/infrastructure without approval
produces: test_report.md
approval_gate: none
stop_condition: failures route to /codex-debug; all passing routes to /codex-security-check
ref: workflows/codex_build_loop.md
---

Kyuuei verifies every acceptance criterion in the task packet. Any test failure stops forward
progress and triggers Kyuuei debug mode via /codex-debug.
