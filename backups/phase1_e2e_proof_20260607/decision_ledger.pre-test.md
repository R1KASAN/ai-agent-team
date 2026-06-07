---
type: decision_ledger
owner: mira_memory_librarian
read_by: [tsumugi_second_brain, minori_lead_conductor, claude_code]
graph: "each row → Graphify `Decision` node, linked [[..]] to its artifact (Obsidian-compatible)"
version: "1.0"
---

# Decision Ledger

Every Rika-Chan gate outcome, appended by **Mira** after the decision. Makes "what did we decide
about X?" queryable, and feeds the Graphify decision graph + Tsumugi proactive recall.

## How it works
- **Mira writes** one row per Rika-Chan `approve` / `stop` / `hold`. No other agent writes here.
- Each row links its artifact with an Obsidian `[[backlink]]`; Mira also emits a `Decision` node in
  `graph_update.md` (relations: `supersedes`, `derived-from`, `relates-to`).
- **Tsumugi reads** this on proactive recall; cite the row when surfacing a past decision.
- `privacy_level: sensitive/restricted` context → record the decision, redact the detail.

## Format
`| date | gate | artifact | decision | reason | outcome |`

<!-- LEDGER START -->
| date | gate | artifact | decision | reason | outcome |
|------|------|----------|----------|--------|---------|
<!-- LEDGER END -->
