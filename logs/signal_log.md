---
log: signal_log
owner: Rika-Chan
written_by: Hikari (append-only, auto, with Decision suggestions) under standing approval dec-20260607-001
human_fields: Rika-Chan accepts/edits suggested Decision + Reasoning + Status
related_logs: [logs/decision_log.md, knowledge/reference/decision_ledger.md]
phase: "Phase 1b-Enhanced — signal → suggested decision, auto-appended (no outcome column yet)"
version: "1.2"
---

# Signal Log

Hikari **auto-appends** one row per signal it surfaces via `/scout` (append-only, standing approval
`dec-20260607-001`). New rows arrive with **Hikari's suggested Decision + Reasoning** and `Status = open`; the
**owner reviews, accepts, or edits the suggestion**.

> Rows may also originate from **Product Scout mode** (`/scout <URL>`): Hikari fetches one public link
> and appends a single row with `Signal Type = link-scout: <topic>` (standing approval
> `dec-20260607-002`). Full detail (summary + all angles) lives in that run's `product_scout_brief.md`. **Phase 1 stops at the decision** — no
revenue/outcome column yet. Once the first product ships, add an `Outcome` column and link signal →
product (see plan: `plan-phase-1-only-signal-decision-tracking.md`, Phase 2).

> Rows are **leads, not facts** — `Confidence` is Hikari's read; promoting a signal to a claim still
> requires Nova-V. `sensitive/restricted` signals are NOT auto-written (Hikari flags them to Rika-Chan).
> **Decision/Reasoning are suggestions only** — owner can freely accept, edit, or reword.

## Why this log exists

- Surface the **pattern** in what you choose to build vs skip — before any product ships.
- Force a one-sentence reason at decision time (cheap discipline).
- Build the foundation so Phase 2 outcome-tracking drops in without rewriting.

## How to use (owner: ~30 sec, review & optionally edit)

1. Run `/scout` → Hikari surfaces ≤3 signals AND auto-appends one row per signal with **suggested Decision + Reasoning** below.
2. For each row, you can:
   - **Accept:** Leave the suggested Decision + Reasoning as-is. Just set `Status` if needed.
   - **Edit Decision:** Change from "BUILD (suggested)" to "SKIP", "DEFER", etc.
   - **Edit Reasoning:** Reword the suggested reason to match your thinking.
   - **Set Status:** change from `open` to `in_progress`, `closed`, `shipped`, etc.
3. If a decision is a real strategic/financial/build commitment, ALSO log it in
   `logs/decision_log.md`; Mira later mirrors gate outcomes into `decision_ledger.md`.

**Append-only rule (Hikari):** add new rows at the table bottom only; never edit/reorder/delete
existing rows, never touch the frontmatter or header row. Owner edits of suggested rows are **fully encouraged**
(that is the intended human step — review and refine).

## Field reference

| Field | Meaning |
|-------|---------|
| `Date` | When the signal surfaced (YYYY-MM-DD) |
| `Signal Type` | Category — e.g. AI trend, hiring market, platform shift, regulation, tooling gap |
| `Confidence` | Hikari's read: `high` / `medium` / `low` |
| `Opportunity Angle` | What you *could* build off it (short) |
| `Decision` | Hikari's suggestion based on confidence (e.g., `BUILD (suggested)`) → owner can accept or edit to `BUILD` / `SKIP` / `DEFER` / `RESEARCH` |
| `Reasoning` | Hikari's suggested reason (e.g., "High confidence + clear angle") → owner can accept or reword 1–2 sentences |
| `Status` | `open` (auto, awaiting owner review) → `in_progress` / `closed` / `shipped` / `archived` |

## Signals

<!-- Hikari appends new rows at the BOTTOM (append-only). Owner fills pending Decision/Reasoning/Status. -->
<!-- Example (delete or keep as reference):
| 2026-06-07 | AI agent frameworks | high | Build an agent orchestrator | pending | pending | open |
-->

| Date | Signal Type | Confidence | Opportunity Angle | Decision | Reasoning | Status |
|------|-------------|------------|-------------------|----------|-----------|--------|
