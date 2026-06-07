---
name: codex-refactor
version: "1.0"
trust_status: Core
team: codex
invoked_by: coda_codex_builder; /codex-refactor
input: debug_report.md or explicit refactor scope from codex_task_packet.md
output: refactor_report.md
template: templates/refactor_report.md
---

# Codex Refactor Skill

Improves code structure within a declared scope. Observable behaviour must not change.

## Protocol

1. Confirm the refactor scope from `codex_task_packet.md` or `debug_report.md`.
2. Load only the files in scope.
3. Apply changes: rename for clarity, extract functions, reduce duplication — within scope only.
4. Run the existing test suite. All tests must pass before and after.
5. If an out-of-scope issue is found: document as `out_of_scope_finding` in refactor_report.md. Do not fix.
6. Write `refactor_report.md` with: files changed, changes made, test results, out-of-scope findings.

## Required Fields in Output

- `scope`, `files_changed`, `changes` (list), `test_result`, `out_of_scope_findings`

## Forbidden

- Do not change observable behaviour.
- Do not fix bugs during refactor — route failures to Kyuuei.
- Do not expand scope without Rika-Chan approval.
- No external calls.
