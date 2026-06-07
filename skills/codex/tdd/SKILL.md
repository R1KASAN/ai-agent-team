---
name: tdd
version: "1.0"
trust_status: Core
team: codex
invoked_by: kyuuei_test_debug; coda_codex_builder
input: acceptance criteria from codex_task_packet.md
output: failing test stubs (before implementation); passing tests (after implementation)
---

# TDD Skill

Applies test-driven development: write failing tests first, then confirm implementation makes them pass.

## Protocol (Red → Green → Refactor)

**Red phase** (before implementation):
1. Read acceptance criteria from `codex_task_packet.md`.
2. Write one failing test per criterion. Tests must fail because the feature does not exist yet.
3. Hand back to Coda for implementation.

**Green phase** (after implementation):
1. Run all tests written in the Red phase.
2. Confirm each now passes.
3. If any test still fails → route to /codex-debug.

**Refactor phase** (optional):
1. If Coda refactor utility is in scope: clean up implementation without breaking tests.
2. Re-run full test suite to confirm.

## When to Apply

Apply when `codex_task_packet.md` specifies `tdd: true` or when Kyuuei initiates before Coda.

## Forbidden

- Do not write tests that pass before the feature exists.
- Do not skip the Red phase.
- No external calls.
