---
name: codex-implement
version: "1.0"
trust_status: Core
team: codex
invoked_by: coda_codex_builder; /codex-implement
input: codex_task_packet.md; files_likely_affected.md
output: build_report.md
template: templates/build_report.md
---

# Codex Implement Skill

Implements a scoped task with surgical, minimal changes.

## Protocol

1. Read `codex_task_packet.md` — load scope, acceptance criteria, and approval gates.
2. Load only the files listed in `files_likely_affected.md`. Do not load the full codebase.
3. Check approval_gates: if any item (auth, payment, db, infra) is not cleared → stop and flag.
4. Make the smallest change that satisfies each acceptance criterion.
5. Do not refactor, rename, or clean up code outside the task scope.
6. Write `build_report.md` with: files changed, lines added/removed, acceptance criteria status, any scope flags.

## Required Fields in Output

- `task_id`, `files_changed`, `acceptance_criteria` (each with status), `scope_flags`, `approval_gates_status`

## Forbidden

- Do not load files outside `files_likely_affected.md` without explicit approval.
- Do not implement auth, payment, db, or infra items without individual Rika-Chan clearance.
- Do not refactor beyond task scope.
- No shell execution beyond the declared task. No external calls.
