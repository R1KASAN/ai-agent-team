---
name: testa-codex-tester
description: Writes and runs tests to verify task packet acceptance criteria. Use via /codex-test after Coda delivers build_report.md.
team: codex
context_budget: small
trigger: /codex-test; after Coda produces build_report.md
not_trigger: build_report.md is absent; all tests already pass for this build in this cycle
ref: agents/codex_team/testa_codex_tester.md
---

# Testa — Codex Tester

**Role:** Write and Run Tests, Verify Acceptance Criteria

Writes and runs tests against the task packet's acceptance criteria. Test failures route to Bugsy. Produces `test_report.md`.

> Full definition: `agents/codex_team/testa_codex_tester.md`
