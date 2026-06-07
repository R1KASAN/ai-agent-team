---
template: codex_task_packet
produced_by: Aki System Architect
workflow: prd_to_codex_tasks
version: "1.0"
---

# Codex Task Packet

```yaml
task_id: ""
produced_by: Aki System Architect
source_prd: ""
source_technical_packet: ""
date: ""
context_budget: small
```

## Goal

> One sentence. What must Codex accomplish?

## Scope

> Exactly what Codex must do. Unambiguous.

-

## Out of Scope

> Exactly what Codex must NOT do in this task.

-

## Files to Modify

| File | Change |
|------|--------|
| | |

## Files to Create

| File | Purpose |
|------|---------|
| | |

## Acceptance Criteria

> Directly from `acceptance_criteria.md`. Numbered for traceability.

1.
2.
3.

## Test Plan Reference

`test_plan.md` — path: ``

## Constraints

> Hard constraints Codex must not violate.

-

## Forbidden Actions in This Task

- Do not edit files outside the scope list above without flagging
- Do not add features not listed in scope
- Do not modify auth / payments / database / infra without Rika-Chan approval
- Do not merge or deploy

## Approval Gates

| Item | Gate |
|------|------|
| | rika_chan |

## Context Budget

`small` — load only files listed above + this packet

---

> Codex receives only this packet + listed files. Nothing else.
> Passes to: `coda_codex_builder.md`
