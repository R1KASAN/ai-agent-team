---
workflow_id: memory_consolidate
type: sub_workflow
parent_workflows:
  - memory_intake
  - llm_wiki_update
slash_command: null
entry_agent: Mira Memory Librarian
context_budget: small
version: "1.1"
---

# Sub-workflow: memory_consolidate

## Purpose

Consolidate scattered intake notes, graph updates, and session artifacts into a coherent, interlinked knowledge base state. Run periodically or at the end of a knowledge-heavy phase — not after every session.

## When to Use

- After multiple `memory_intake` runs have accumulated unlinked notes
- At the end of a research phase before starting `product_idea_debate`
- When Obsidian vault has grown disconnected — backlinks missing, clusters not updated
- When `llm_wiki/` rules have drifted from current workflow practice

## When NOT to Use

- After a single intake session — `memory_intake` alone is sufficient
- During active build loops — consolidation is between phases, not mid-workflow

---

## Flow

```
Accumulated intake notes + graph updates
→ Minori: workflow_plan.md                    [context_budget: small]
→ Mira: re-tag and merge duplicate entries    [context_budget: small]
         + source_log deduplication
→ Mira: graph reconciliation                  [context_budget: small]
        + missing backlinks added
        + cluster connections updated
→ LLM Wiki alignment check                    [context_budget: small]
        + flag rules that have drifted
        + produce llm_wiki_update.md (proposed)
→ Kaizen pass (token convention)              [context_budget: tiny]
```

## Agent Sequence

| Step | Agent | Input | Output | Stop Condition |
|------|-------|-------|--------|---------------|
| 1 | Minori | accumulated note list | `workflow_plan.md` | Plan complete |
| 2 | Mira | intake notes batch | merged notes + deduped `source_log` | No duplicate entries remain |
| 3 | Mira (graph-build backend) | merged notes + existing graph | reconciled `graph_update.md` | Missing backlinks added; clusters current |
| 4 | LLM Wiki alignment check | graph state + current `llm_wiki/` files | `llm_wiki_update.md` (proposed) | Drifted rules identified |
| 5 | Kaizen pass (token convention) | artifact list | `kaizen_report.md` | Waste review complete |

## Approval Gates

- Step 4 → LLM Wiki changes stay `proposed` until Rika-Chan or Minori approves
- Any sensitive data found during re-tagging → Rika-Chan governance gate before proceeding
- Large source batch deduplication (>20 entries) → Rika-Chan awareness before Mira runs

## Stop Conditions

- PII found in previously untagged notes → stop at Step 2; route to Rika-Chan governance gate
- Graph reconciliation requires loading full vault → stop; scope to relevant clusters only
- Session context approaches `medium` budget → checkpoint and continue in new session

## Relationship to Parent Workflows

- `memory_intake` feeds raw notes into this sub-workflow
- `llm_wiki_update` consumes the `llm_wiki_update.md` proposed output from Step 4

## Output Artifacts

Merged `knowledge_intake_note.md` entries · `graph_update.md` · updated Obsidian notes · `llm_wiki_update.md` (proposed) · `kaizen_report.md` · `logs/source_log.md` update

## Workflow Type

`sequential_handoff`
