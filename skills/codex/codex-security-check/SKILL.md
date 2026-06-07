---
name: codex-security-check
version: "1.0"
trust_status: Core
team: codex
invoked_by: kyuuei_test_debug; /codex-security-check
input: build_report.md or refactor_report.md
output: security_check.md
template: templates/security_check.md
---

# Codex Security Check Skill

Checks build or refactor output against `governance/security_guardrails.md`. A blocked verdict is a hard stop.

## Protocol

1. Scan changed files for secrets or credentials in code or comments.
2. Check auth, payment, db, and infra changes — any present without approval gate clearance → blocked.
3. Check all user-facing inputs for validation at system boundaries.
4. Check API responses for over-exposure (fields beyond what acceptance criteria requires).
5. Check third-party dependencies added in this task — flag any from unknown sources.
6. Assign verdict: `pass` / `conditional_pass` / `blocked`.
7. Write `security_check.md` with findings per category.

## Verdict Definitions

- `pass` — no issues found
- `conditional_pass` — low-severity findings; documented; PR may proceed with caveats
- `blocked` — hard stop; PR and ship-check cannot proceed until issue is resolved and skill re-runs

## Forbidden

- Do not downgrade a blocked finding to conditional_pass.
- Do not skip the secrets scan.
- No external calls.
