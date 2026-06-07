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
| 2026-06-07 | archive-restore process fix (No-Overwrite / archive-only) | [[archive/phase1_consumed_drafts_20260607_082602/MANIFEST.md]] | approve (conditional) | 7 Phase-1 drafts had been deleted instead of archived after merge — a process violation. Reconstruction from session Write-records + checksum verification accepted; one condition attached: write a MANIFEST documenting paths, source, checksums, expected draft↔live deltas, and confirmation live files were untouched | MANIFEST.md created and accepted; archive-restore fix closed; no live files modified |
| 2026-06-07 | global Claude Code subagent model override fix | [[handoffs/global_env_backup_20260607_001.md]] | approve removal | Owner chose removal over pinning a replacement model so subagents inherit the session-resolved model and avoid future stale-alias drift | Removed `CLAUDE_CODE_SUBAGENT_MODEL=claude-opus-4-6-thinking` from `/Users/ark1/.claude.json`; left `ENABLE_EXPERIMENTAL_MCP_CLI=true` untouched; trivial subagent check passed |
| 2026-06-07 | Test 4 close-out (idea-stresstest.js Workflow retry) | [[handoffs/graph_update_20260607_003.md]] | close as confirmed-blocked, do not force a pass | The retry aborted on `dynamic_not_approved` because the Workflow tool stringifies `args`, masking `rika_dynamic_approved`. A documented launcher-wrapper workaround exists, but running the heavy/strategic stresstest merely to force a green result was judged not worth the token spend; the real, now-doubly-confirmed root cause is more valuable on record than a forced pass | Test 4 closed as confirmed-diagnosed-and-blocked; `lessons_ledger.md` args-stringification row `confirm_count` raised 1→2 |
| 2026-06-07 | Phase 1b signal_log auto-append standing approval | [[logs/signal_log.md]] | approve (standing, append-only) | Owner does not want to hand-write signal rows; Hikari may auto-append signal rows to `logs/signal_log.md` with append-only guarantees (no overwrite/edit/delete of existing rows, no frontmatter/header changes). Satisfies No-Overwrite Rule; `logs/` already multi-writer. Signals stay leads-not-facts (Nova-V still required to promote a claim) | Standing approval recorded ([[logs/decision_log.md]] dec-20260607-001); Hikari + Minori + scout.md updated to auto-append; owner fills only Decision/Reasoning on `pending` rows |
| 2026-06-07 | Test 3 (Heavy/strategic) gate close-out — waive open questions + one-time dynamic budget grant | [[handoffs/approval_request_20260607_001.md]] | waive (3 open questions) + approve (context_budget: dynamic, one-time, Test 4 proof run only) | approval_request_20260607_001.md's own `test_context` field confirms this was raised as a "Phase 1 proof run — Test 3 (Heavy/strategic gate)" — a deliberate proof-test scaffold, not a genuine B2B product-pivot question; spending real strategic-decision effort on synthetic questions would be wasteful. Waiving closes the strategic-pivot hard gate for this synthetic scenario while keeping the dynamic-budget gate's authority intact (one-time grant, not standing) | dec-20260607-003 recorded ([[logs/decision_log.md]]); Test 4 (idea-stresstest.js, args-string-bug workaround attempt) cleared to proceed using a real, owner-granted `rika_dynamic_approved=true` value |
<!-- LEDGER END -->
