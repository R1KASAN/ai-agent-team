---
workflow_id: prd_to_codex_tasks
slash_command: /prd-to-codex-tasks
entry_agent: Minori Lead Conductor
context_budget: small
version: "1.0"
---

## Entry Gate

This workflow may only start from a Minori-approved `workflow_plan.md` or `handoff.md`. If no Minori workflow_plan exists, stop and run Input Gatekeeper first.

---

# Workflow: prd_to_codex_tasks

## Purpose

Convert an approved PRD into an implementation-ready Codex task packet with test plan and scoped file list. Bridges Claude Team planning and Codex Team execution.

## Prerequisites

- `prd.md` approved by Rika-Chan
- `acceptance_criteria.md` complete
- Gate Scope Pre-Clarification exists in `workflow_plan.md`
- No auth / payments / database / infra items pending approval unless explicitly deferred to a named
  checkpoint

## Flow

```
Approved prd.md + acceptance_criteria.md
→ Minori: workflow_plan.md                    [context_budget: small]
          + Expected Gates + Pre-Decide vs Defer
→ Aki: technical_task_packet.md               [context_budget: small]
        + codex_task_packet.md
        + test_plan.md
        + files_likely_affected.md
        *** STOP if approval-required items found ***
→ Poom: acceptance_criteria.md review         [context_budget: tiny]
         (confirm criteria are testable and unambiguous)
```

## Agent Sequence

| Step | Agent | Input | Output | Stop Condition |
|------|-------|-------|--------|---------------|
| 1 | Minori | approved PRD | `workflow_plan.md` | Plan complete |
| 2 | Aki | `prd.md` + `acceptance_criteria.md` | `technical_task_packet.md` + `codex_task_packet.md` + `test_plan.md` + `files_likely_affected.md` | All four artifacts complete |
| 3 | Poom | `acceptance_criteria.md` | Confirmed or revised criteria | Criteria are testable and unambiguous |

## Approval Gates

- **Entry:** `prd.md` must be Rika-Chan-approved
- **Before Step 2:** Minori must complete Gate Scope Pre-Clarification in `workflow_plan.md`; if
  predictable gates exist, each must be marked Pre-Decide or Defer before Aki starts
- **Step 2:** Any task touching auth / payments / database / infra → Aki must stop and produce `approval_request.md` before writing Codex task packet
- **Exit:** Codex task packet must not be handed to Coda until all approval-required items are resolved
- If auth / payments / database / infra / paid API / hosting is likely, Minori asks Rika-Chan which
  gates to pre-decide and which to defer to `Coda proposes options + Rika-Chan approves before
  implementation/spend/deploy`

## Stop Conditions

- Gate Scope Pre-Clarification missing, incomplete, or unresolved → stop before Aki
- Technical risk flagged as `high` on an auth/payments/db/infra item → stop; Rika-Chan resolves before packet is delivered to Codex
- Acceptance criteria are ambiguous → Poom revises before packet is finalised
- Codex task packet scope creeps beyond PRD MVP → stop; revise to match approved scope

## Codex Handoff Rule

Codex receives **only:**
- `codex_task_packet.md`
- `acceptance_criteria.md`
- Files listed in `files_likely_affected.md`
- `test_plan.md`

Do not pass full repo, full PRD, or strategy context to Codex.

## Output Artifacts

`technical_task_packet.md` · `codex_task_packet.md` · `test_plan.md` · `files_likely_affected.md`

## Workflow Type

`sequential_handoff`
