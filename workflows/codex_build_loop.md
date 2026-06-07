---
workflow_id: codex_build_loop
slash_command: /codex-implement
entry_agent: Coda Codex Builder
context_budget: small
version: "1.1"
---

## Entry Gate

This workflow may only start from a Minori-approved `workflow_plan.md` or `handoff.md`. If no Minori workflow_plan exists, stop and run Input Gatekeeper first.

---

# Workflow: codex_build_loop

## Purpose

Execute a scoped build task using Codex slash command skills. Produces tested, security-checked, PR-ready output for Rika-Chan deployment approval.

## Prerequisites

- `codex_task_packet.md` approved and complete
- `acceptance_criteria.md` available
- `test_plan.md` available
- `files_likely_affected.md` available
- All approval-required items resolved before start

## Flow

```
codex_task_packet.md
→ Coda /codex-implement: build_report.md      [context_budget: small]
→ Kyuuei /codex-test: test_report.md          [context_budget: small]
         if failures → Kyuuei /codex-debug: debug_report.md
                     → Kyuuei re-run
→ Coda /codex-refactor: refactor_report.md    [context_budget: small]
         (only if explicitly requested in task packet)
→ Kyuuei /codex-security-check: security_check.md  [context_budget: small]
→ Coda /codex-pr: pr_summary.md              [context_budget: small]
→ Kyuuei /codex-ship-check: ship_check.md    [context_budget: small]
         *** APPROVAL GATE — Rika-Chan deployment decision ***
```

## Agent Sequence

| Step | Agent | Slash Command | Input | Output | Stop Condition |
|------|-------|--------------|-------|--------|---------------|
| 1 | Coda | `/codex-implement` | task packet + files | `build_report.md` | Scope implemented |
| 2 | Kyuuei | `/codex-test` | `build_report.md` + criteria | `test_report.md` | All criteria tested |
| 2a | Kyuuei | `/codex-debug` | `test_report.md` (failures) | `debug_report.md` | Root cause fixed |
| 3 | Coda | `/codex-refactor` | passing `test_report.md` | `refactor_report.md` | If in scope only |
| 4 | Kyuuei | `/codex-security-check` | `build_report.md` + files | `security_check.md` | All categories checked |
| 5 | Coda | `/codex-pr` | all prior reports | `pr_summary.md` | PR summary complete |
| 6 | Kyuuei | `/codex-ship-check` | all prior reports | `ship_check.md` | Checklist complete |

## Approval Gates

- **Exit (Step 6):** Rika-Chan must approve `ship_check.md` before any production deployment
- Any build touching auth / payments / database / infra → flag in `build_report.md`; stop pending approval
- Security `blocked` verdict → stop at Step 4; do not proceed to PR summary

## Stop Conditions

- `build_report.md` flags an unapproved auth/payments/db/infra item → stop; request approval
- `test_report.md` shows failures → route to Kyuuei debug mode; do not proceed to refactor or security
- `security_check.md` verdict is `blocked` → stop; fix required before PR
- `ship_check.md` verdict is `not_ready` or `blocked` → stop; do not present for deployment

## Codex Context Rule

Each agent receives only its defined inputs. No agent in this workflow receives full repo, strategy context, or prior Claude Team discussion.

## Output Artifacts

`build_report.md` · `test_report.md` · `debug_report.md` (if needed) · `refactor_report.md` (if needed) · `security_check.md` · `pr_summary.md` · `ship_check.md`

## Workflow Type

`sequential_handoff`
