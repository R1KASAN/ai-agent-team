---
type: instincts_index
owner: mira_memory_librarian
read_by: [minori_lead_conductor, claude_code, tsumugi_second_brain]
promoted_from: knowledge/reference/lessons_ledger.md
version: "1.0"
---

# Instincts

Confirmed patterns the team has learned — a lesson seen **≥ 3 times** in `lessons_ledger.md`,
promoted by **Mira** to a durable instinct note here. This is how the OS compounds: **Minori reads
instincts at classify-time**, so the dispatcher gets smarter over time without retraining.

## Rules
- **Mira writes** instinct notes; one note per distinct pattern. No other agent writes here.
- Each instinct is an Obsidian-linked note and a `Instinct` node in Graphify `graph_update.md`
  (relation `derived-from` → its lesson rows).
- An instinct can be **retired** if later contradicted — mark `status: retired`, don't delete.
- Instincts are guidance, not gates. They never override Rika-Chan hard gates or Sequential-by-Default.

## Note format (`knowledge/instincts/[slug].md`)
```
---
type: instinct
status: active        # active | retired
confidence: high      # high | medium
derived_from: [lessons rows / dates]
---
# <instinct title>
**Pattern:** <what consistently happens>
**Apply when:** <trigger / weight / job>
**Action:** <what to do>
[[related]]
```

## Index
> Mira appends one line per instinct.
> Format: `- [title](slug.md) — apply-when · status · date`

<!-- INSTINCTS START -->
- [Run JS Dynamic Workflows through an inline `workflow()` launcher, never the top-level Workflow tool's `args`](workflow-args-typed-launcher.md) — apply-when launching any JS Dynamic Workflow with an `args.*`-keyed guard · active · 2026-06-07
<!-- INSTINCTS END -->
