---
name: codex-review
version: "1.0"
trust_status: Core
team: codex
invoked_by: tessa_qa_ux_inspector; /codex-review
input: build_report.md; acceptance criteria from codex_task_packet.md
output: qa_ux_report.md
template: templates/qa_ux_report.md
---

# Codex Review Skill

Reviews UX flows, edge cases, and product behaviour against acceptance criteria.

## Protocol

1. Read acceptance criteria from `codex_task_packet.md`.
2. For each criterion: assess whether the built feature satisfies it from a user/product perspective.
3. Check edge cases: empty states, error states, permission boundaries, mobile/accessibility if applicable.
4. Assign verdict: `pass` / `conditional_pass` / `blocked`.
5. If `blocked` → write `qa_ux_report.md` and stop; do not route to governance check.
6. If `pass` or `conditional_pass` → write `qa_ux_report.md` and route to /governance-check.

## Verdict Definitions

- `pass` — all criteria met; no UX issues
- `conditional_pass` — minor issues noted; documented with recommended fixes
- `blocked` — critical UX or flow failure; must be resolved before governance review

## Forbidden

- Do not pass a blocked verdict forward to governance review.
- Do not assess security — route that to Kyuuei security utility.
- No external calls.
