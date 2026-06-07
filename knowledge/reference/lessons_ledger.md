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
| 2026-06-07 | archive-restore process fix | Consumed/merged drafts must be archived before deletion, even when "fully merged into live" — archive-only and No-Overwrite apply regardless of perceived redundancy; reconstruct-from-session-record + checksum-verify is an acceptable recovery when an archive step was skipped | correction | 1 | no |
| 2026-06-07 | Phase 1 idea-stresstest.js proof run | The Workflow tool's top-level `args` parameter arrives inside the script as a JSON-encoded **string**, not an object — boolean approval flags like `rika_dynamic_approved` silently evaluate falsy. **Reconfirmed 2026-06-07 in a separate Claude Code session via diagnostic probe** (`typeof args === "string"`, `args.rika_dynamic_approved === undefined`) — proves this is a Workflow-tool-level behaviour, not a Codex-session quirk. Workaround: wrap the call in an inline launcher using `workflow({scriptPath}, realArgsObject)`, which passes a real in-process object. **3rd confirmation 2026-06-07 (Test 4):** isolated A/B probe proved it directly — top-level tool with a proper JSON-object `args` → child still sees `typeof "string"` (guard aborts); inline `workflow({scriptPath}, obj)` → child sees `typeof "object"`, `rika_dynamic_approved === true` (guard PASSES). Promoted to instinct `knowledge/instincts/workflow-args-typed-launcher.md` | do-always | 3 | yes |
| 2026-06-07 | idea-stresstest proof retry | High-value instinct candidate: Root cause of the "no StructuredOutput" failure was a global `CLAUDE_CODE_SUBAGENT_MODEL` override pointing to an invalid model ID (`claude-opus-4-6-thinking`) in `/Users/ark1/.claude.json` — not a script/schema issue. Removed the override; subagents now inherit the session model. | correction | 1 | no |
<!-- LESSONS END -->
