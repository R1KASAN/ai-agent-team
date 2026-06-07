---
name: codex-test
version: "1.0"
trust_status: Core
team: codex
invoked_by: kyuuei_test_debug; /codex-test
input: build_report.md; acceptance criteria from codex_task_packet.md
output: test_report.md
ref: skills/codex/codex-test/SKILL.md
---

Writes and runs tests against each acceptance criterion in the task packet. Any failure routes to /codex-debug before moving forward. No tests are skipped without explicit justification in test_report.md. No external calls.
