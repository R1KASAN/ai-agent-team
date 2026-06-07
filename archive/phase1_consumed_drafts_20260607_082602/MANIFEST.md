# Manifest — Phase 1 Consumed Drafts Archive

Folder: `archive/phase1_consumed_drafts_20260607_082602/`
Created: 2026-06-07, as a process-violation fix (drafts had been deleted instead of archived,
breaking the No-Overwrite / archive-only rule). Approved by Rika-Chan 2026-06-07.

## 1. Purpose

This folder preserves the 7 Phase-1 full-file drafts that were merged into live files during
Phase 1 Steps A+B. They were originally removed (violation); this archive restores them so that
**nothing from Phase 1 is deleted** — backups (pre-merge v1), archive (consumed v2 drafts), and
live (merged v2) now coexist as three distinct, traceable copies.

## 2. Reconstruction source

No filesystem copy of the drafts existed at the time of the fix (they had already been removed).
Each file was reconstructed **verbatim from this session's `Write` tool-call records** — the
session transcript is the verified source of truth for draft content, since every draft was
authored via `Write` earlier in the same session before being merged and removed. Drafts 1–6 were
additionally cross-checked by diffing against their live merged counterparts (see §4).

## 3. Archived files and checksums (SHA-1)

| # | Archived path | SHA-1 | Marker present |
|---|---|---|---|
| 1 | `.claude/commands/idea-gate.draft.md` | `942696459cff0d5b9b257cecd5247940258908a9` | n/a — command files carry no `version:` field; content ≡ live |
| 2 | `workflows/idea_gate.draft.md` | `808bcfaa2eb5fdd8bfe3eea8d32229f1b1865b7f` | `version: "2.0-draft"` ✓ |
| 3 | `.claude/agents/minori_lead_conductor.draft.md` | `a18411ade3e8b1aa6d4335dbc24e2fe239d585b1` | `version: "2.0-draft"` ✓ |
| 4 | `agents/claude_team/minori_lead_conductor.draft.md` | `904a9bd2e09f9eb78791c07bcb36ec56f2f70730` | `version: "2.0-draft"` + `status`/`draft_of` ✓ |
| 5 | `agents/claude_team/mira_memory_librarian.draft.md` | `71ee51077e1ebc94098e37d19a7929d5d25e5cb7` | `version: "1.3-draft"` + `status`/`draft_of` ✓ |
| 6 | `agents/claude_team/tsumugi_second_brain.draft.md` | `2858267204befdffd92e1998b633a6b34e7bf876` | `version: "1.2-draft"` + `status`/`draft_of` ✓ |
| 7 | `HOW_TO_USE.draft.md` | `35c76fa1e6aec095fc3aded49bc9269406c766be` | Phase-1 append-section header ✓ |

## 4. Expected draft-vs-live differences (fidelity check)

Each archived draft was diffed against its live merged counterpart with draft-markers normalized
away. Expected outcomes:

- **Files 1, 4, 5, 6 — exact MATCH.** No content differences beyond the draft-only frontmatter
  fields (`version: "...-draft"`, `status`, `draft_of`), which are absent from live by design.
- **Files 2 (`idea_gate`) and 3 (minori `.claude` stub) — differ only in two intentionally-removed
  clauses:**
  - The original "Backs … `.draft.md`" changelog clause (draft-only provenance note).
  - The 2-line "(full draft: `…draft.md`)" pointer (draft-only cross-reference).
  Both clauses were deliberately stripped during the Phase 1 merge so that live files reference
  only live paths. Their presence in the draft and absence in live is the **correct, expected**
  draft↔live delta — confirmed by direct marker inspection, not a sign of corruption or drift.

No other content differences were found. Two "DIFF" lines surfaced during the verification pass
were artifacts of an imperfect normalization `sed` (it stripped the `.draft` path segment but left
a stray "Backs…" clause / deduped the wrong line) — cosmetic glitches in the verification one-liner
itself, not file problems. Direct marker inspection confirmed both archived and live files are
correct.

## 5. Confirmation — live merged files unchanged

All six live files were scanned post-fix:
- No `-draft` / `status: full-file draft` / `draft_of` markers leaked into live files.
- `workflows/idea_gate.md` and the minori `.claude` stub contain **zero** `.draft` references —
  all paths point to live files only.
- The Phase 1 A+B merge (Steps A+B) remains intact and untouched by this archive-restore fix.

## 6. Confirmation — nothing deleted, no scope creep

- Three copies coexist: `backups/phase1_merge_20260607_082602/` (pre-merge v1 originals),
  `archive/phase1_consumed_drafts_20260607_082602/` (this folder — consumed v2 drafts), and the
  live merged v2 files. No `rm` was executed during this fix.
- JS workflows: still exactly **1** (`idea-stresstest.js`), **not executed**.
- `decision_ledger.md` / `lessons_ledger.md`: **0 data rows** (header + separator only) — no
  ledger writes occurred.
- NotebookLM-py: **not activated**. No Phase 2 fields introduced.
- No Phase C/D/E work started.

## 7. Status

Archive-restore process violation corrected and accepted by Rika-Chan (2026-06-07), conditional on
this manifest. Stopped pending explicit owner approval for any further phase.
