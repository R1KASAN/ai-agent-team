---
name: codex-pr
version: "1.0"
trust_status: Core
team: codex
invoked_by: coda_codex_builder; /codex-pr
input: security_check.md with pass or conditional_pass verdict
output: pr_summary.md
template: templates/pr_summary.md
---

# Codex PR Skill

Produces a PR summary. Cannot start if Kyuuei security check returned a blocked verdict.

## Protocol

1. Confirm `security_check.md` verdict is `pass` or `conditional_pass`. If `blocked` → stop immediately.
2. Summarise all changed files with a one-line description of each change.
3. List test results from `test_report.md`.
4. Include security check result from `security_check.md`.
5. List any `conditional_pass` caveats from Kyuuei or Tessa.
6. Write risk notes: what could go wrong, what needs monitoring post-deploy.
7. Write `pr_summary.md`.
8. Hand off to `/codex-ship-check` — do not merge.

## Required Fields in Output

- `task_id`, `changed_files`, `test_summary`, `security_verdict`, `caveats`, `risk_notes`

## Forbidden

- Do not start with a blocked security_check.md.
- Do not merge or push to any branch.
- No external calls.
