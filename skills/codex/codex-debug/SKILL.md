---
name: codex-debug
version: "1.0"
trust_status: Core
team: codex
invoked_by: kyuuei_test_debug; /codex-debug
input: test_report.md with failures; or explicit bug description
output: debug_report.md
template: templates/debug_report.md
---

# Codex Debug Skill

Diagnoses and minimally fixes a failure. Applies debug-mantra principles (Reference Only) as a reasoning guide.

## Protocol

1. **Reproduce** — confirm the failure is reproducible from the test_report.md steps.
2. **Trace** — identify the code path that leads to the failure. Load only relevant files.
3. **Hypothesize** — form 2–3 candidate causes ranked by likelihood.
4. **Fix minimally** — implement the fix for the most likely cause. Change only what is necessary.
5. Re-run the failing test. If still failing → repeat from step 3 with next hypothesis.
6. Check that the fix does not break any passing tests.
7. Write `debug_report.md` with: root cause, hypothesis list, fix applied, tests re-run, scope flags.

## Scope Rule

If the root cause requires a fix outside the task packet scope → document it in debug_report.md as `out_of_scope_finding`, do not fix it, and flag for Rika-Chan.

## Forbidden

- Do not fix multiple bugs in one pass — one hypothesis, one fix.
- Do not expand scope without Rika-Chan approval.
- No external calls.
