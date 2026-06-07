---
workflow_id: kaizen_review
slash_command: /kaizen-review
entry_agent: Minori (gate)
context_budget: tiny
version: "1.1"
---

# Workflow: kaizen_review

## Purpose

Standalone token and context waste review for a completed workflow session. Identifies inefficiencies, agent overuse, repeated context, and skill candidates. Kaizen is now a **shared token convention** applied at session close (the standalone Kai agent is archived); this workflow runs the convention as an explicit pass when invoked.

## Prerequisites

- Completed workflow with artifact sequence available
- `workflow_plan.md` from the reviewed session
- `logs/kaizen_log.md` available for appending

## Flow

```
Completed workflow artifact list
→ Kaizen pass (token convention)              [context_budget: tiny]
        → kaizen_report.md + kaizen_log update
→ (if skill candidates found)
  → Draft skill_candidate_note.md             [context_budget: small]
           status: proposed
```

## Agent Sequence

| Step | Owner | Input | Output | Stop Condition |
|------|-------|-------|--------|---------------|
| 1 | Kaizen pass (token convention) | workflow_plan + artifact list (not full content) | `kaizen_report.md` + `kaizen_log` update | All waste categories reviewed |
| 2 | Owner draft | `kaizen_report.md` skill_candidates section | `skill_candidate_note.md` | Skill stub documented (if candidates found) |

## Approval Gates

- Skill candidates → require Skill Trust Gate + Rika-Chan approval before use
- Workflow redesign recommendation → flag to Minori for next session planning

## Stop Conditions

- No waste found → `overall_verdict: efficient`; no further action needed
- Review exceeds `tiny` budget → compact immediately; the kaizen pass must not bloat the session it is reviewing

## Embedded vs Standalone

**Embedded:** Applied as the final convention pass in `product_idea_debate`, `qa_review`, `governance_check`, `llm_wiki_update`, and `memory_intake`.

**Standalone:** Triggered via `/kaizen-review` after any session where waste is suspected or Rika-Chan requests a review.

## Kaizen Token Rule

The kaizen pass must not load full artifact content to do a waste review — it reviews the artifact *list* and *structure*, not the full content of each artifact.

## Output Artifacts

`kaizen_report.md` · `logs/kaizen_log.md` update · `skill_candidate_note.md` (if applicable)

## Workflow Type

`sequential_handoff`
