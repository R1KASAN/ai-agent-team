---
name: codex-ship-check
version: "1.0"
trust_status: Core
team: codex
invoked_by: kyuuei_test_debug; /codex-ship-check
input: pr_summary.md
output: ship_check.md
template: templates/ship_check.md
---

# Codex Ship Check Skill

Runs the pre-ship readiness checklist. Best possible verdict: `ready_pending_approval`. Never deploys.

## Checklist

- [ ] Build passes with no errors
- [ ] All tests pass (test_report.md: overall_result = pass)
- [ ] No lint or type errors in changed files
- [ ] Security check verdict: pass or conditional_pass (security_check.md)
- [ ] UX review verdict: pass or conditional_pass (qa_ux_report.md)
- [ ] PR summary complete with risk notes (pr_summary.md)
- [ ] No unresolved `out_of_scope_findings` from debug or refactor
- [ ] No uncovered approval gates from codex_task_packet.md

## Verdict Definitions

- `ready_pending_approval` — all checklist items passed; awaiting Rika-Chan deployment decision
- `not_ready` — one or more checklist items failed; deployment blocked

## Forbidden

- Do not deploy or push to production.
- Do not issue a verdict above `ready_pending_approval`.
- Do not clear an item without evidence from the relevant artifact.
- No external calls.
