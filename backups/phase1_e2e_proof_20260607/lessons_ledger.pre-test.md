---
type: lessons_ledger
owner: mira_memory_librarian
read_by: [mira_memory_librarian, minori_lead_conductor, claude_code]
feeds: knowledge/instincts/
version: "1.0"
---

# Lessons Ledger

Raw, per-workflow lessons captured after a run completes — "what worked / what didn't / what to
always do." **Mira** appends; this is the staging area for instinct promotion.

## How it works
- After a completed workflow, **Mira** appends 1-3 lessons (one row each).
- When the *same* lesson is confirmed **≥ 3 times**, Mira promotes it to an instinct note in
  `knowledge/instincts/` and links back here.
- Keep rows terse — this is signal, not prose.

## Format
`| date | workflow | lesson | type | confirm_count | promoted? |`
- `type`: `do-always` · `avoid` · `design-rationale` · `correction`

<!-- LESSONS START -->
| date | workflow | lesson | type | confirm_count | promoted? |
|------|----------|--------|------|---------------|-----------|
<!-- LESSONS END -->
