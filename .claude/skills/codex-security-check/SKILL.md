---
name: codex-security-check
version: "1.0"
trust_status: Core
team: codex
invoked_by: kyuuei_test_debug; /codex-security-check
input: build_report.md or refactor_report.md
output: security_check.md
ref: skills/codex/codex-security-check/SKILL.md
---

Checks for secrets, auth issues, input validation gaps, and data exposure against governance/security_guardrails.md. A blocked verdict is a hard stop — no PR or ship until resolved and re-run. No external calls.
