---
workflow_id: memory_intake
slash_command: /memory-intake
entry_agent: Mira Memory Librarian
context_budget: small
version: "1.1"
changelog: "v1.1 — Added Step 4: Mira writes Karpathy-format note to knowledge/inbox/ after graph update."
---

# Workflow: memory_intake

## Purpose

Convert raw knowledge (notes, URLs, documents, screenshots) into governed, structured memory entries ready for the knowledge graph and Obsidian-compatible backlinks — **and into the `knowledge/` wiki layer for direct Claude Code querying**.

## Prerequisites

- Raw input: text note, URL, file reference, screenshot path, or document
- `logs/source_log.md` available for appending

## Flow

```
Raw input
→ Minori: workflow_plan.md                    [context_budget: tiny]
→ Mira: knowledge_intake_note.md              [context_budget: small]
         + source_log update
         *** STOP if PII or sensitive data found → Rika-Chan review ***
→ Mira: graph_update.md                       [context_budget: small]
        + memory_graph_note.md (Obsidian-compatible)
→ Mira: knowledge/inbox/[slug].md             [context_budget: tiny]
         + knowledge/README.md index update
→ context_pack candidate flagged for next session
```

## Agent Sequence

| Step | Agent | Input | Output | Stop Condition |
|------|-------|-------|--------|---------------|
| 1 | Minori | raw input | `workflow_plan.md` | Plan complete |
| 2 | Mira | raw input | `knowledge_intake_note.md` + `source_log` update | Metadata tagged; privacy assessed |
| 3 | Mira (graph-build backend) | `knowledge_intake_note.md` | `graph_update.md` + `memory_graph_note.md` | Entity/relation map updated |
| 4 | Mira | `knowledge_intake_note.md` | `knowledge/inbox/[slug].md` + README index update | Wiki note written; index appended |

## Approval Gates

- **Step 2:** PII detected → stop; Rika-Chan reviews before graph/wiki write
- **Step 2:** Sensitive data (`privacy_level: sensitive` or `restricted`) → Rika-Chan notified before proceeding
- Importing large source batch (10+ items) → Rika-Chan approval before Mira runs

## Stop Conditions

- PII or restricted data found → halt at Step 2; route to Rika-Chan before graph update
- Source credibility very low + no corroboration → flag in intake note; do not use as primary evidence
- Raw input is too large for `small` budget → compact or split before intake

## Memory Stack Integration

```
Raw Input → Mira (tag/privacy + wiki write) → knowledge/inbox/ (Karpathy wiki — Claude-queryable)
         → Mira graph-build backend → graph_update.md / Obsidian-compatible backlinks
         → Tsumugi read-only recall (README first, selected notes, graph fallback)
         → Context Pack (scoped agent context)
         → Agent Handoff
```

NotebookLM-py is not part of normal memory intake. It is Nova-V-only deep source reading, gated
per command by Rika-Chan, and its output is not truth until Nova-V verifies it.

## Output Artifacts

`knowledge_intake_note.md` · `graph_update.md` · `memory_graph_note.md` ·
`knowledge/inbox/[slug].md` · `logs/source_log.md` update · `knowledge/README.md` index update

## Workflow Type

`sequential_handoff`
