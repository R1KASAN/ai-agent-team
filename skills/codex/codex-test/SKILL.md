---
name: codex-test
version: "1.0"
trust_status: Core
team: codex
invoked_by: kyuuei_test_debug; /codex-test
input: build_report.md; acceptance criteria from codex_task_packet.md
output: test_report.md
template: templates/test_report.md
---

# Codex Test Skill

Writes and runs tests against each acceptance criterion. No criterion may be skipped without documented justification.

## Protocol

1. Read acceptance criteria from `codex_task_packet.md`.
2. For each criterion: write a test that would fail if the criterion is not met.
3. Run all tests.
4. For each test: record pass / fail / skipped + reason.
5. If any test fails → do not continue to security check; route to /codex-debug.
6. If all pass → write `test_report.md` and route to /codex-security-check.

## Required Fields in Output

- `task_id`, `tests` (list: criterion, test_name, result, reason), `overall_result` (pass/fail), `failures` (if any)

## TDD Option

If invoked before implementation (TDD mode), write failing tests first and hand back to Coda before running.

## Forbidden

- Do not skip a failing test without explicit justification in test_report.md.
- Do not mark overall_result as pass if any test failed.
- No external calls beyond the local test runner.
