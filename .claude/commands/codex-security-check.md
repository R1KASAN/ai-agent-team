---
command: codex-security-check
tier: optional_utility
core_flow: false
maps_archived: seco_codex_security_checker → kyuuei_test_debug (Seco → Kyuuei backend check)
description: Check build or refactor output for secrets, auth issues, input validation gaps, and data exposure.
entry_agent: kyuuei_test_debug
context_budget: small
required_input: build_report.md or refactor_report.md
optional_input: supporting artifact paths, constraints, risk notes, approval notes; never full chat history
forbidden_actions: bypassing Minori, skipping artifact gates, starting downstream workflows automatically, using large/dynamic context without approval, overwriting existing files without approval, deciding product strategy, editing out-of-scope files, deploying production, modifying auth/payment/database/infrastructure without approval
produces: security_check.md
approval_gate: none; blocked verdict is self-enforcing — stops the entire workflow
stop_condition: blocked verdict = no PR, no ship; conditional_pass or pass routes to /codex-pr
ref: workflows/codex_build_loop.md · governance/approval_gates.md
---

Optional owner-invokable utility — not part of the core flow. Kyuuei (security backend check) enforces
the governance/security guardrails. A blocked verdict is a hard stop — /codex-pr and /codex-ship-check
cannot proceed until the issue is resolved and the check re-runs. Security findings also escalate to a
Rika-Chan hard gate.
