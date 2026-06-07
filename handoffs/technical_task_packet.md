---
template: technical_task_packet
produced_by: Aki System Architect
workflow: prd_to_codex_tasks
companion_to: handoffs/prd.md (prd-20260607-001), handoffs/acceptance_criteria.md (ac-20260607-001)
version: "1.0"
---

# Technical Task Packet — Feedback-to-Action (working title)
## AI Assistant: Scattered Client Feedback → Clear Next Actions

```yaml
packet_id: ttp-20260607-001
produced_by: Aki System Architect
source_prd: handoffs/prd.md (prd-20260607-001) — approved dec-20260607-006
source_mvp_scope: handoffs/mvp_scope.md (mvp-20260607-001)
source_acceptance_criteria: handoffs/acceptance_criteria.md (ac-20260607-001)
source_out_of_scope: handoffs/out_of_scope.md (oos-20260607-001)
date: "2026-06-07"
status: RESOLVED & ACTIVATED — gate cleared via dec-20260607-007 (see §6, handoffs/approval_request_20260607_002.md resolution section, and handoffs/codex_task_packet.md ctp-20260607-001). §6 below is retained verbatim as the historical record of what was flagged and why; the access-control item it named was resolved as Shape A (shared invite link/password, no accounts/user-table/persistent state).
```

---

## 1. Architecture Summary

A small, **stateless, single-request-response web tool**. One screen, one input surface (text paste
or image upload), one trigger action, two generated outputs (next action + Thai draft). No
accounts beyond what is needed to run a controlled manual beta (flagged in §6 — NOT decided here).
No database. No queue. No background jobs. No cross-request state of any kind.

This is greenfield: no existing app/src codebase exists in this repo for the product itself (the
repo contains only the agent-team scaffolding). Aki is scoping a new build from zero, which is the
cleanest possible starting position for a one-shot architecture — there is no legacy state-handling
to strip out.

The system has exactly one meaningful request lifecycle:

```
User opens tool → pastes text OR uploads image → clicks "Process"
  → [if image] vision/extraction call turns image into feedback text
  → generation call #1 produces exactly one prioritised next action
  → generation call #2 produces exactly one Thai client-update draft
  → both outputs render on screen
  → user copies what they need
  → user closes tab / refreshes / starts a new run
  → NOTHING about this run is retrievable afterward, by anyone, anywhere
```

That "nothing is retrievable afterward" line is not a nice property of this architecture — per
`mvp_scope.md` Feature 5 and `dec-20260607-004`, it **is** the architecture, and it is the thing
the >60% day-3 return-rate test depends on meaning what it should mean. Every component below is
designed to not create a place where that property could quietly leak.

## 2. Components

| Component | Responsibility | Interfaces |
|-----------|---------------|-----------|
| **Input Surface (UI)** | Single page: text-paste field, image-upload control, one "Process" trigger, output display area for the two results, copy-to-clipboard affordance on each output | Renders to browser; sends one request to Processing Orchestrator on trigger; receives the two outputs and displays them; holds state only in browser memory for the life of the tab |
| **Processing Orchestrator (server-side request handler)** | Receives one input (text or image), drives the pipeline (extract → generate next-action → generate draft), returns exactly two outputs, then discards everything it touched | Inbound: one HTTP request from Input Surface. Outbound: calls to Extraction Service (image path only) and Generation Service (both paths); returns a single JSON response; retains nothing after responding |
| **Extraction Service** (image path only) | Turns an uploaded image of a chat/comment/annotation thread into plain feedback text the Generation Service can use | Calls a vision-capable model API (external, paid — flagged in §6); receives image bytes, returns extracted text only; the image itself is never written to disk or passed further than this one call |
| **Generation Service** | Produces (a) exactly one prioritised next action and (b) exactly one Thai-language client-update draft, from the same feedback text | Calls a text-generation model API (external, paid — flagged in §6) twice (or once with a structured two-part output — an internal design choice for Coda, not dictated here); enforces "exactly one" at the prompt and parsing layer so the UI never has to guess |
| **Output Renderer (part of Input Surface)** | Displays the next action and the Thai draft, each with its own copy button | Pure client-side rendering of the Processing Orchestrator's response; no further calls |

Note on the "exactly one" discipline (Features 3 and 4, `acceptance_criteria.md`): this must be
enforced at **two** layers — the prompt/instruction layer (ask the model for exactly one) and the
parsing/validation layer (reject or retry if the model returns zero, multiple, or a list-shaped
response). Relying on prompting alone is a known failure mode with LLMs and would put Feature 3/4
acceptance criteria at risk. This is named here as a **constraint** (§5), not left to chance.

## 3. Data Flow

```
[Browser: paste text  ───┐
          OR             ├──> Processing Orchestrator (1 request)
          upload image ──┘            │
                                       ├─[image only]→ Extraction Service ──(model API call)──> feedback text
                                       │
                                       ├──→ Generation Service ──(model API call #1)──> ONE next action
                                       │
                                       └──→ Generation Service ──(model API call #2)──> ONE Thai draft
                                       │
                                       ▼
                            single JSON response { next_action, thai_draft }
                                       │
                                       ▼
                         [Browser renders both; user copies; tab closes]
                                       │
                                       ▼
                    *** END OF LIFECYCLE — nothing persists past this point ***
```

Two external calls leave the system boundary on every run that includes an image, and at least two
on every run (the two generation calls). **This is the one place client-identifying data leaves
the product's direct control** — flagged as the PDPA/privacy carry-forward risk in `prd.md` §7
item 3 and restated as a cross-cutting note in `acceptance_criteria.md` (Feature 5 section). Aki
does not resolve this; it is named here so Coda builds the call boundary in a way that makes the
governance review (already scheduled per the workflow) tractable — e.g., no logging of request/
response bodies at this boundary by default (see Constraints §5).

No step in this flow writes to any form of persistent storage. There is no database to design,
migrate, or query. This is a direct technical consequence of `mvp_scope.md` Feature 5 — not an
implementation detail Aki is choosing freely; it is the locked architecture being honored.

## 4. Technical Risks

| Risk | Severity | Mitigation |
|------|---------|-----------|
| **"Exactly one" output discipline fails at the model layer** (model returns zero, multiple, or list-shaped output for next-action or draft) — directly threatens Acceptance Criteria 3 and 4 (`acceptance_criteria.md`), which require *exactly* one of each, every time | high | Enforce at prompt layer AND parsing/validation layer (see Constraint in §5); add a retry-once-then-fail-visibly path so the UI never silently shows zero or many; Kyuuei's test plan (`test_plan.md`) must specifically probe this with the 10+ varied-input runs the AC already specifies |
| **Image extraction quality is inconsistent across screenshot types** (chat bubbles vs. threaded comments vs. design-review annotation marks) — directly threatens Acceptance Criterion 2's "8 of 10 samples" bar | medium | Use a vision-capable model with demonstrated OCR/scene-text competence; build the Extraction Service as a swappable component (clean interface boundary) so the model behind it can change without touching the orchestrator or UI — this also serves the carried-forward "design seams for a future differentiation layer" note in `mvp_scope.md` |
| **Thai informal-text NLP / tone quality is unvalidated** (named open risk #2 in `prd.md` §7 — Bumi's ~80–85% bar is untested) — threatens Acceptance Criterion 4 | high | Cannot be mitigated by architecture alone; requires the real-sample corpus (open risk #5 in `prd.md` §7) before beta. Aki scopes the generation call to be model-and-prompt-swappable (clean interface) specifically so Coda/Kyuuei can iterate on prompt/model choice during the validation cycle without an architecture change. This is named as a build-blocking quality gate for "MVP done," not just a scaling concern, per `prd.md` §7 item 2 |
| **External model-API calls are the system's only data-egress point and the PDPA/privacy carry-forward risk's literal location** (`prd.md` §7 item 3) | high | Architectural mitigation only: minimize what crosses the boundary (send extracted text, not raw images, to the generation step where avoidable; never log request/response bodies containing user content by default — see Constraints). The *substantive* privacy/legal clearance is explicitly NOT an architecture decision — it sits with the governance review step (`governance_check.md`) and Rika-Chan, named here only so Coda builds a boundary that does not foreclose a clean review |
| **Hosted-tool access for a 10–20 user manual beta has no named mechanism in the PRD** — surfaces a real technical question that brushes the auth/infra boundary the PRD pre-flagged (`prd.md` §6, `out_of_scope.md` §7) | high | **This is the approval-gate trigger for this packet.** Not silently resolved either way — see §6 and `handoffs/approval_request_20260607_002.md`. Aki halts the Codex-packet step here per `workflows/prd_to_codex_tasks.md` Step 2 stop condition |
| **Low moat / fast-follow substitution risk** (named open risk #1 in `prd.md` §7 — accepted as tracked, not blocking) | medium (tracked, not a build blocker) | Architectural response only: keep Extraction Service and Generation Service behind clean, swappable interfaces (named in §2 and §5) so a future differentiation layer (better Thai-tone calibration, faster perceived latency, sharper prompts/output) is an addition to these seams, not a rewrite — directly satisfying `mvp_scope.md`'s "Carried-Forward Risk Note for Aki and Coda" |
| **Stateless design accidentally grows hidden state** (e.g., a well-intentioned cache, a debug log, a session cookie added "just to make the UI smoother") would silently violate Feature 5 and invalidate the entire >60% signal | high | Name explicitly as a forbidden pattern (Constraints §5 and the Codex packet's forbidden-actions list, once that packet is cleared to be written); Kyuuei's test plan includes the two-sequential-sessions zero-trace check directly from Acceptance Criterion 5 |

## 5. Constraints

> Hard constraints Codex must not violate. Carried into `codex_task_packet.md` (ctp-20260607-001)
> verbatim, now that the gate in §6 has cleared (dec-20260607-007), with one addition layered in:
> the Shape A shared-access-gate constraint (single shared secret, not a per-user credential
> system) — see `codex_task_packet.md` Constraints section.

- No database, no server-side session store, no client-side persistent storage (localStorage,
  IndexedDB, cookies used for content retention) for pasted text, uploaded images, or generated
  outputs — this is Feature 5 / Acceptance Criterion 5, not a style preference.
- No logging of request or response bodies that contain user-pasted content, uploaded images, or
  generated outputs, by default. (Operational logs that contain no user content — e.g., "request
  received, request completed, latency Xms" — are fine and expected; content-bearing logs are not.)
- Enforce "exactly one" next action and "exactly one" Thai draft at both the prompt layer and a
  parsing/validation layer; never let a zero- or multi-output model response reach the UI unhandled.
- Build the Extraction Service and Generation Service behind clean, swappable interfaces — not
  because memory is being added (it is not), but so a future differentiation layer can be an
  addition, per `mvp_scope.md`'s carried-forward risk note. Do not build in memory or persistence
  "just in case."
- Do not add a third output, multiple draft variants, in-product editing, scheduling/reminders, or
  any platform connector — all explicitly cut in `out_of_scope.md` §1–4.
- Do not add any account/auth/billing/database/infra component without a separate Rika-Chan
  approval — see §6. This packet does not authorize any of those; it only documents that the
  question exists.

## 6. Approval Required Before Build — RESOLVED (dec-20260607-007)

> **Historical record, retained verbatim below.** Per `workflows/prd_to_codex_tasks.md` Step 2
> ("Any task touching auth / payments / database / infra → Aki must stop and produce
> `approval_request.md` before writing Codex task packet") and Aki's own spec
> (`agents/codex_team/aki_system_architect.md` Approval Gates), this technical translation
> surfaced three items that brushed the named boundary. Aki halted the workflow at this point and
> produced `handoffs/approval_request_20260607_002.md`.
>
> **Resolution:** Rika-Chan ruled on all three items in `dec-20260607-007`
> (`logs/decision_log.md`): (1) beta access = **Shape A** — single shared invite link/password,
> no accounts/user-table/persistent state, ruled NOT a full "auth system," stays inside the
> locked one-shot architecture (`dec-20260607-004`); (2) paid model-API provider/spend ceiling
> **deferred** to a "Coda proposes → Rika-Chan approves" in-build checkpoint (gate stays open,
> reopens at that step); (3) hosting is authorized at the minimal beta-window scale implied by
> Shape A. The halt is lifted; `codex_task_packet.md` (ctp-20260607-001) is written and active.
> The table below is preserved as-is to document what was flagged and why — it is not stale
> analysis, it is the record the resolution above responds to.

| Item | Type | Gate | Where it surfaced |
|------|------|------|-------------------|
| **Beta-access control for a hosted tool used by 10–20 seeded manual-beta users handling client-identifying feedback content** — does the MVP need ANY minimal access gate (shared invite link, allowlist, lightweight password), and if so, what is the minimal technically-honest version that does not become a de facto account/persistence system? | auth (minimal) / infra (hosting + who-can-reach-it) | rika_chan | Surfaced while scoping §1–3: a hosted one-shot tool that nobody can reach is untestable; a hosted one-shot tool anybody can reach raises the exact PDPA/client-data exposure risk `prd.md` §7 item 3 already names as unresolved. The PRD itself (`prd.md` §6, `out_of_scope.md` §7) explicitly anticipated this exact surfacing and named the return-to-Rika-Chan rule rather than pre-deciding it |
| **Paid external model-API usage** (vision/extraction call + two generation calls per run) | financial/commercial (paid API) | rika_chan | Named in `governance/approval_gates.md` "Financial and Commercial → Paid API or paid tool usage." Every run of this product calls at least one, likely two-to-three, paid model APIs. This is a direct, unavoidable technical consequence of the approved MVP scope (Features 1–4 cannot function without a generation/extraction model), but the spend commitment itself is a named Rika-Chan gate, not an Aki decision |
| **Where/how the tool is hosted for the beta** (any hosting choice is an infra decision) | infra | rika_chan | A "stateless one-shot web tool" still has to run somewhere reachable by 10–20 real users. Naming *that it must be hosted* is a direct, unavoidable consequence of the MVP scope; *which* hosting and how it's provisioned is squarely the named "Infrastructure changes" gate in `governance/approval_gates.md` |

> **Full detail, options, risk framing, and the 3 questions for Rika-Chan are in the companion
> `handoffs/approval_request_20260607_002.md`. Aki does not propose a specific answer to "should
> this product have an access gate" — per the explicit instruction that Aki must flag rather than
> silently decide either way.**

## 7. Files Likely Affected

> Listed in full in `handoffs/files_likely_affected.md`. Summary: this is a greenfield build — no
> existing product files in this repo to modify. The list names the **new** files/directories Coda
> would create once (and only once) the gate in §6 clears and `codex_task_packet.md` is written.

- New project scaffold (single small web app — exact framework choice deferred to Coda within the
  constraints above; not an Aki decision to make)
- New: input-surface UI files (paste field, upload control, output display)
- New: server-side request-handler / orchestrator file(s)
- New: extraction-service and generation-service interface + implementation files
- New: environment/config file for model-API credentials (NOTE: credential handling itself is a
  sub-question of the §6 gate — naming the file's existence is not the same as authorizing how
  secrets are stored/deployed)

---

> Companion files: `handoffs/test_plan.md` (tp-20260607-001 — test scenarios aligned to acceptance
> criteria), `handoffs/files_likely_affected.md` (fla-20260607-001),
> `handoffs/approval_request_20260607_002.md` (RESOLVED — see resolution section appended there
> and `dec-20260607-007` in `logs/decision_log.md`), `handoffs/codex_task_packet.md`
> (ctp-20260607-001 — written and active)
> Status: RESOLVED & ACTIVATED. Workflow proceeds past Step 2 of `workflows/prd_to_codex_tasks.md`.
