---
template: files_likely_affected
produced_by: Aki System Architect
workflow: prd_to_codex_tasks
companion_to: handoffs/technical_task_packet.md (ttp-20260607-001)
version: "1.0"
---

# Files Likely Affected — Feedback-to-Action (working title)
## AI Assistant: Scattered Client Feedback → Clear Next Actions

```yaml
file_list_id: fla-20260607-001
produced_by: Aki System Architect
source_technical_packet: handoffs/technical_task_packet.md (ttp-20260607-001)
date: "2026-06-07"
status: written — scoped for Codex context-loading; ACTIVE now that codex_task_packet.md (ctp-20260607-001) exists and the gate in technical_task_packet.md §6 cleared via dec-20260607-007. The Codex packet's "Files to Create" table layers in two Shape-A-driven additions (a shared-access-gate unit and minimal beta-window hosting/deploy config) on top of this file's unit list — both already implied here by the "no account... beyond what is needed to run a controlled manual beta (flagged in §6)" framing; this file's content remains accurate as written and required no edits.
purpose: "Exists so Coda loads only what is needed — per Aki's Token-Efficiency Rules and the workflow's Codex Handoff Rule. No full-repo, no full-PRD, no strategy context passed to Codex."
```

---

## Context: This Is a Greenfield Build

A repo-wide check (`find` for app/src/build directories) confirms there is **no existing
product codebase** in this repository — only the agent-team scaffolding (`agents/`, `workflows/`,
`handoffs/`, etc.). This file therefore lists **files Coda will create**, not files Coda will
modify. There is nothing to "modify" yet; the product does not exist.

This is the cleanest possible starting condition for a one-shot architecture (`technical_task_packet.md`
§1) — there is no legacy state-handling, no existing database, no existing auth system to strip
out or work around. Coda starts clean and should stay clean, per the constraints named in
`technical_task_packet.md` §5.

---

## Files Coda Would Create (once the gate clears and `codex_task_packet.md` is written)

> Exact paths/filenames are intentionally left as a Coda-level decision within the constraints
> below — Aki scopes architecture and boundaries, not file-naming conventions or framework choice
> (per Aki's persona: "writes for Codex, not for herself" and "prefers simple architecture over
> clever architecture"). The list below names **what must exist as a distinct, swappable unit**,
> which is the information Coda needs to plan its own file layout.

| Unit | Purpose | Maps to component (`technical_task_packet.md` §2) |
|------|---------|----|
| Project scaffold (package manifest, entry point, build/run config) | Minimal new-project setup for a small single-page web tool | — (infrastructure-of-the-build, not a product component) |
| Input Surface UI unit(s) | Single page: paste field, upload control, "Process" trigger, output display with copy-to-clipboard for each of the two outputs | Input Surface (UI) |
| Processing Orchestrator / request-handler unit(s) | Server-side: receives one request, drives extract→generate→generate, returns one response, retains nothing | Processing Orchestrator |
| Extraction Service interface + implementation unit(s) | Image → feedback text, behind a clean swappable interface (named explicitly in Constraints — supports both the quality-iteration need and the anti-lock-in / future-differentiation seam) | Extraction Service |
| Generation Service interface + implementation unit(s) | Feedback text → (exactly one next action, exactly one Thai draft), behind a clean swappable interface, with "exactly one" enforced at both prompt and parsing layers | Generation Service |
| Output Renderer (likely part of the Input Surface UI unit) | Displays the two outputs; pure client-side; no further calls | Output Renderer |
| Environment/config file for model-API access | Holds whatever the chosen model API(s) require to be called | Supports Extraction + Generation Services — **NOTE: how secrets/credentials are stored and deployed is itself wrapped into the §6 gate in `technical_task_packet.md` (paid-API-usage approval); naming that this file must exist is not authorization for its contents or deployment method** |

## Files Coda Must NOT Create (explicit negative list — directly from `out_of_scope.md` and `technical_task_packet.md` §5)

So Coda does not "helpfully" add something that quietly breaks the architecture under test:

- Any database schema, migration, or persistent-storage config file
- Any session-store, cache-with-content, or content-bearing log configuration
- Any account/auth/login module or user-table
- Any billing/payment/subscription integration file
- Any platform-connector module (LINE API, Messenger, Drive, Notion, WhatsApp, Telegram, etc.)
- Any voice/audio-input handling module
- Any scheduling/reminder/automation module
- Any third-output (checklist), multi-draft-variant, or in-product-editing module

If a build step seems to require any of the above, that is a signal to stop and flag — exactly the
reasoning that produced the halt documented in `technical_task_packet.md` §6 and
`handoffs/approval_request_20260607_002.md`, not a green light to proceed quietly.

---

> Companion to: `handoffs/technical_task_packet.md` (ttp-20260607-001) · `handoffs/codex_task_packet.md` (ctp-20260607-001 — written and active)
> Status: written and ACTIVE; scoped for Codex context-loading; gate cleared via dec-20260607-007
