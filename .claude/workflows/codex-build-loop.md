---
workflow: codex-build-loop
status: active
type: sequential
entry_command: /codex-implement
context_budget: small
ref: workflows/codex_build_loop.md
---

# Codex Build Loop — Runtime Reference

Runtime pointer only. Full definition lives in `workflows/codex_build_loop.md`.

## Step Sequence

1. `/codex-implement` → Coda → `build_report.md`
2. `/codex-test` → Kyuuei → `test_report.md`
3. `/codex-debug` → Kyuuei (if failures) → `debug_report.md`
4. `/codex-refactor` → Coda (if scoped refactor) → `refactor_report.md`
5. `/codex-security-check` → Kyuuei backend check → `security_check.md`
6. `/codex-review` → Tessa → `qa_ux_report.md`
7. `/codex-pr` → Coda → `pr_summary.md`
8. `/codex-ship-check` → Kyuuei → `ship_check.md` → Rika-Chan

## Hard Rules

- Each step requires the previous step's artifact before starting.
- `blocked` verdict from Kyuuei or Tessa stops the loop entirely.
- No agent deploys. Deployment requires explicit Rika-Chan action.
- This file does not auto-trigger any step. Commands are invoked manually.
