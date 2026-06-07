---
template: codex_task_packet
produced_by: Aki System Architect
workflow: prd_to_codex_tasks
companion_to: handoffs/technical_task_packet.md (ttp-20260607-001), handoffs/test_plan.md (tp-20260607-001), handoffs/files_likely_affected.md (fla-20260607-001)
version: "1.0"
---

# Codex Task Packet
## AI Assistant: Scattered Client Feedback → Clear Next Actions (working title: Feedback-to-Action)

```yaml
task_id: ctp-20260607-001
produced_by: Aki System Architect
source_prd: handoffs/prd.md (prd-20260607-001) — approved dec-20260607-006
source_technical_packet: handoffs/technical_task_packet.md (ttp-20260607-001)
source_test_plan: handoffs/test_plan.md (tp-20260607-001)
source_files_likely_affected: handoffs/files_likely_affected.md (fla-20260607-001)
gate_resolution: handoffs/approval_request_20260607_002.md — RESOLVED via dec-20260607-007 (logs/decision_log.md)
date: "2026-06-07"
context_budget: small
status: ACTIVE — gate cleared, build authorized within the scope below
```

## Goal

Build a small, stateless, single-request-response web tool: a freelancer pastes scattered client
feedback (text or screenshot), clicks one button, and receives exactly one prioritised next action
plus exactly one ready-to-send Thai client-update draft — with nothing about the run retrievable
afterward by anyone.

## Scope

> Exactly what Codex must do. Unambiguous.

- Build the one-screen Input Surface: a text-paste field, an image-upload control, a single
  "Process" trigger, and an output area that renders the two results, each with its own
  copy-to-clipboard affordance. (`technical_task_packet.md` §2 — Input Surface / Output Renderer)
- Build the Processing Orchestrator (server-side request handler): receives one request, drives
  the pipeline (extract → generate next-action → generate draft), returns exactly one JSON
  response `{ next_action, thai_draft }`, and retains nothing after responding.
  (`technical_task_packet.md` §1–3)
- Build the Extraction Service (image path only) behind a clean, swappable interface: turns an
  uploaded image into plain feedback text via a vision-capable model API call; the image itself
  must never be written to disk or passed beyond this one call. (`technical_task_packet.md` §2)
- Build the Generation Service behind a clean, swappable interface: produces (a) exactly one
  prioritised next action and (b) exactly one Thai-language client-update draft from the same
  feedback text, calling a text-generation model API. Enforce "exactly one" at BOTH the
  prompt/instruction layer AND a parsing/validation layer, with a retry-once-then-fail-visibly
  path so the UI never silently shows zero or many outputs. (`technical_task_packet.md` §2, §5)
- Build the minimal beta-access mechanism — **Shape A, per `dec-20260607-007`**: a single
  shared invite link and/or shared password known only to the 10–20 seeded beta testers. This is
  the ENTIRE access mechanism. No accounts, no user table, no per-user identity, no persistent
  per-user state of any kind, no login/registration/password-reset flow. A simple shared-secret
  check that gates entry to the one-screen tool is sufficient and is the ceiling, not the floor,
  of what to build here. (Ruled NOT a full "auth system" — stays inside the locked one-shot
  architecture `dec-20260607-004` and `out_of_scope.md`'s boundary; no separate auth-gate review
  required per `dec-20260607-007` Q2.)
- Wire the model-API calls (one extraction call on the image path; two generation calls — or one
  structured two-part call, an internal Coda design choice — on every run) behind the swappable
  interfaces named above, with no logging of request/response bodies that contain user content.
  (`technical_task_packet.md` §3, §5)
- **Provider research checkpoint (Coda proposes → Rika-Chan approves):** Before committing to a
  specific paid model-API provider or spend ceiling, Coda must research and propose 2–3 viable
  provider options (covering both the vision/extraction need and the text-generation need) with
  approximate per-run and beta-window cost estimates, and present them to Rika-Chan for approval.
  **Do not select or commit spend to a specific provider unilaterally** — this was explicitly
  deferred by Rika-Chan (`dec-20260607-007` Q3) precisely so the choice is made with real
  cost data in front of her, not pre-committed by Aki or assumed by Coda. Build the interfaces
  to be provider-agnostic so this choice can be slotted in once approved, without an architecture
  change.
- Stand up minimal hosting for the beta window sized to "10–20 real users reaching one small
  stateless tool" — the smallest viable managed surface that satisfies that requirement and does
  not foreclose the pending PDPA/privacy review's data-handling questions (e.g., prefer hosting
  options where request/response logs are not retained by default, or can be configured not to be).

## Out of Scope

> Exactly what Codex must NOT do in this task.

- Do not build any account system, user table, login/registration/password-reset flow, session
  store, or any form of persistent per-user identity or state. Shape A is a **shared** secret —
  not a per-user credential system. (`dec-20260607-007` Q1/Q2; `out_of_scope.md` §7;
  `dec-20260607-004`)
- Do not build a database, cache-with-content, content-bearing log, or any persistent-storage
  layer for pasted text, uploaded images, generated outputs, or session/project/client context.
  (`technical_task_packet.md` §5; Acceptance Criterion 5)
- Do not unilaterally select a paid model-API provider or commit to a spend ceiling — that
  decision is explicitly deferred to a "Coda proposes → Rika-Chan approves" checkpoint (see Scope
  above and `dec-20260607-007` Q3). Researching and proposing options is in scope; picking one
  without Rika-Chan's sign-off is not.
- Do not add a third output, multiple draft variants, in-product editing, scheduling/reminders,
  or any platform connector (LINE, Messenger, Drive, Notion, WhatsApp, Telegram, etc.).
  (`out_of_scope.md` §1–4)
- Do not add voice/audio input handling.
- Do not add any billing/payment/subscription integration.
- Do not add a full/heavyweight auth system, password-reset flows, role-based access, or any
  mechanism beyond the single shared invite link/password named in Shape A — building "more auth
  than asked for" is as much a violation of `dec-20260607-007` and the locked architecture
  (`dec-20260607-004`) as building none at all.
- Do not merge or deploy to any production-facing destination without a separate Rika-Chan
  go-ahead at that step (the hosting stood up here is for the beta window, not a permanent
  production commitment).

## Files to Modify

| File | Change |
|------|--------|
| — | None. This is a greenfield build (`files_likely_affected.md` confirms no existing product codebase in this repo). |

## Files to Create

> Exact paths/filenames are a Coda-level decision within the constraints below. See
> `files_likely_affected.md` (fla-20260607-001) for the full unit-by-unit breakdown this table summarizes.

| File / Unit | Purpose |
|------|---------|
| Project scaffold (manifest, entry point, build/run config) | Minimal new single-page web tool setup |
| Input Surface UI unit(s) | Paste field, upload control, "Process" trigger, output display + copy-to-clipboard for both outputs |
| Processing Orchestrator / request-handler unit(s) | One request in → extract→generate→generate → one response out → retains nothing |
| Extraction Service interface + implementation | Image → feedback text, behind a swappable interface, via a vision-capable model API |
| Generation Service interface + implementation | Feedback text → exactly-one next action + exactly-one Thai draft, behind a swappable interface, "exactly one" enforced at prompt AND parsing layers |
| Output Renderer (likely part of Input Surface unit) | Pure client-side rendering of the two outputs; no further calls |
| Shared-access gate unit (Shape A) | Single shared invite-link/password check gating entry to the tool; no accounts, no user table, no per-user state — the entire access mechanism |
| Environment/config file for model-API access | Holds whatever the chosen (Rika-Chan-approved, per the provider checkpoint) model API(s) require — naming the file is not authorization for its contents/secrets-handling method, which remains part of the deferred provider checkpoint and the hosting decision |
| Minimal hosting/deploy config for the beta window | Smallest viable managed surface reachable by 10–20 seeded testers; configured, where possible, to avoid retaining request/response logs containing user content |

## Acceptance Criteria

> Directly from `acceptance_criteria.md` (ac-20260607-001). Numbered for traceability.

1. **(Feature 1 — paste-first text input):** A user can paste raw feedback text of any length/
   source into a single visible field and trigger processing without logging in (beyond the one
   shared Shape-A gate, which is not a per-user login), configuring a connector, or completing
   any setup step. All 5+ varied samples process to completion with no setup friction.
2. **(Feature 2 — screenshot/image upload input):** A user can upload an image of a chat thread,
   comment section, or design-review annotation, and the product extracts feedback content well
   enough to feed a coherent next action and client draft. At least 8 of 10 representative
   samples (spanning chat-bubble, threaded-comment, and annotation styles) produce extraction
   good enough that downstream outputs are coherent and traceable to the image.
3. **(Feature 3 — exactly one prioritised next action):** For any input, the product returns
   exactly one prioritised next action — never zero, never a list — specific enough to act on
   immediately (not generic filler). All 10+ varied runs return exactly one action; a
   native-Thai-speaker/domain-fluent reviewer judges at least 8 of 10 as specific/actionable.
4. **(Feature 4 — exactly one Thai-language client-update draft):** For the same input, the
   product returns exactly one ready-to-send, professionally-toned Thai message a reviewer judges
   sendable with light-or-no editing. At least 8 of 10 drafts meet the reviewer's tone/naturalness/
   sendability bar.
5. **(Feature 5 — self-contained, one-shot session / zero persistent memory):** After any session
   completes, no content from it — pasted text, uploaded image, generated outputs, or any derived
   client-identifying data — is stored, retrievable, or accessible anywhere in the product, by
   anyone, through any surface (UI, history, cache, account-level state). Architecture review
   confirms no persistent storage layer for session/project/client content exists anywhere in
   the stack.

> Note: the Shape A shared-access gate does not introduce a new acceptance criterion — it must be
> built such that it does not compromise Criterion 5 (the shared secret/gate-state is not
> per-user content and must not become a vector for storing or correlating user-identifying data
> across sessions).

## Test Plan Reference

`test_plan.md` (tp-20260607-001) — path: `handoffs/test_plan.md`

Five scenarios, one per acceptance criterion, owned by Kyuuei (QA/test+debug) with Tessa routing
in conditionally afterward (`has_ui_component = true`). Scenario 5 (zero-trace / one-shot
integrity) is the scenario most relevant to verifying that the Shape A gate was built without
quietly introducing persistent state — Kyuuei should explicitly confirm the shared-secret check
holds no per-user or cross-session state when executing that scenario.

## Constraints

> Hard constraints Codex must not violate. Carried verbatim from `technical_task_packet.md` §5,
> with the Shape A access-gate constraint added per `dec-20260607-007`.

- No database, no server-side session store, no client-side persistent storage (localStorage,
  IndexedDB, cookies used for content retention) for pasted text, uploaded images, or generated
  outputs — this is Feature 5 / Acceptance Criterion 5, not a style preference.
- No logging of request or response bodies that contain user-pasted content, uploaded images, or
  generated outputs, by default. (Operational logs with no user content — "request received,
  request completed, latency Xms" — are fine and expected; content-bearing logs are not.)
- Enforce "exactly one" next action and "exactly one" Thai draft at both the prompt layer and a
  parsing/validation layer; never let a zero- or multi-output model response reach the UI
  unhandled.
- Build the Extraction Service and Generation Service behind clean, swappable interfaces — so a
  future differentiation layer can be an addition, per `mvp_scope.md`'s carried-forward risk
  note, and so the deferred provider choice (see Scope) can be slotted in without an architecture
  change. Do not build in memory or persistence "just in case."
- **The Shape A access gate is a single shared secret (invite link and/or password), not a
  per-user credential system.** It must not create a user table, per-user session state, or any
  mechanism that could be repurposed into an account system. If at any point building it seems to
  require persistent per-user state, that is a signal to stop and flag to Rika-Chan — not a
  green light to extend the mechanism quietly.
- Do not add a third output, multiple draft variants, in-product editing, scheduling/reminders,
  or any platform connector — all explicitly cut in `out_of_scope.md` §1–4.
- Minimize what crosses the system boundary to the external model APIs (prefer sending extracted
  text rather than raw images to the generation step where avoidable) — this is the literal
  location of the still-pending PDPA/privacy review (`prd.md` §7 item 3); building the boundary
  cleanly now makes that review tractable later. This task does not close that review; it must
  not foreclose it either.

## Forbidden Actions in This Task

- Do not edit files outside the scope list above without flagging
- Do not add features not listed in scope
- Do not build any account/login/user-table/per-user-credential system — Shape A is a single
  shared secret only (see Constraints); anything beyond that requires a fresh Rika-Chan approval
- Do not modify payments / database / production infra beyond the minimal beta-window hosting
  named in Scope, without Rika-Chan approval
- Do not select a paid model-API provider or commit spend without first completing the
  "Coda proposes → Rika-Chan approves" checkpoint named in Scope
- Do not merge or deploy to any permanent production destination

## Approval Gates

| Item | Gate |
|------|------|
| Paid model-API provider selection and spend ceiling — Coda must research and propose 2–3 options with cost estimates; Rika-Chan approves the specific choice before it is committed (this gate was explicitly deferred, not closed, by `dec-20260607-007` Q3 — it reopens at this checkpoint) | rika_chan |
| Any extension of the Shape A access mechanism beyond a single shared invite link/password (e.g., per-user accounts, persistent identity, role-based access) | rika_chan |
| Permanent production deployment / go-live beyond the beta-window hosting scoped here | rika_chan |
| Any discovery during the build that the architecture needs a database, session store, or persistent state beyond what is named here | rika_chan |

## Context Budget

`small` — load only: this packet, `handoffs/technical_task_packet.md`, `handoffs/test_plan.md`,
`handoffs/files_likely_affected.md`, and `handoffs/acceptance_criteria.md`. Do not load the
PRD, strategy, or business-brief documents — Aki has already translated the relevant decisions
into this packet (per Aki's Token-Efficiency Rules and the workflow's Codex Handoff Rule).

---

## Closing Note — Deltas Check Against the Other Three Artifacts

Aki reviewed `technical_task_packet.md` (ttp-20260607-001), `test_plan.md` (tp-20260607-001), and
`files_likely_affected.md` (fla-20260607-001) against Shape A's specifics, as predicted in
`approval_request_20260607_002.md` §6 ("they do not need to be rewritten, only activated"). That
prediction holds — **no edits were required to any of the three**:

- `technical_task_packet.md` already named the access-control question generically (§4, §6, §7)
  without committing to a shape; Shape A slots into that existing language without contradiction.
  Its §6 gate table and HALT framing remain historically accurate as a record of what was flagged
  and resolved (the resolution lives in this packet and in `approval_request_20260607_002.md`'s
  new resolution section, not by rewriting history in the technical packet).
- `test_plan.md` Scenario 5 (zero-trace / one-shot integrity) and Scenario 1 (no setup friction)
  already cover exactly the surfaces a Shape A gate touches (does the shared-secret check
  introduce any per-user state; does it add setup friction beyond a one-time shared entry step) —
  no new scenario was needed; Kyuuei is pointed at the right existing scenario in this packet's
  Test Plan Reference section above.
- `files_likely_affected.md` already named "Coda would create new files" generically for a
  greenfield build; this packet's Files to Create table adds the Shape A gate unit and the
  hosting/deploy config explicitly (both already implied by the technical packet's "no
  account... beyond what is needed to run a controlled manual beta (flagged in §6)" framing) —
  these are additions made in *this* packet's table, not edits to `files_likely_affected.md`
  itself, which remains accurate as the unit-level companion reference.

> Companion files: `handoffs/technical_task_packet.md` (ttp-20260607-001),
> `handoffs/test_plan.md` (tp-20260607-001), `handoffs/files_likely_affected.md` (fla-20260607-001),
> `handoffs/approval_request_20260607_002.md` (RESOLVED — see resolution section appended there)
> Gate resolution of record: `logs/decision_log.md#dec-20260607-007`
> Codex receives only this packet + the four companion files listed in Context Budget. Nothing else.
> Passes to: `coda_codex_builder.md` → then `kyuuei_qa.md` (+ `tessa_qa_ux.md` conditionally)
