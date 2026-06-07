---
template: test_plan
produced_by: Aki System Architect
workflow: prd_to_codex_tasks
companion_to: handoffs/technical_task_packet.md (ttp-20260607-001), handoffs/acceptance_criteria.md (ac-20260607-001)
version: "1.0"
---

# Test Plan — Feedback-to-Action (working title)
## AI Assistant: Scattered Client Feedback → Clear Next Actions

```yaml
test_plan_id: tp-20260607-001
produced_by: Aki System Architect
source_acceptance_criteria: handoffs/acceptance_criteria.md (ac-20260607-001)
source_technical_packet: handoffs/technical_task_packet.md (ttp-20260607-001)
date: "2026-06-07"
owner_for_execution: "Kyuuei (QA/test+debug); Tessa conditionally for UI/UX inspection (has_ui_component = true)"
status: written — not gated; contains no build authorization; ACTIVE and ready for Kyuuei now that codex_task_packet.md (ctp-20260607-001) exists and the gate in technical_task_packet.md §6 cleared via dec-20260607-007
```

---

## Purpose

One test scenario per MVP feature, each traced directly to its `acceptance_criteria.md` entry —
no new criteria invented here, no scope added. This document tells Kyuuei (and conditionally
Tessa, since `has_ui_component = true`) exactly what "done" looks like in testable terms, and
gives Coda a target to build toward. It does not authorize any build step; it is handed to Coda
alongside `codex_task_packet.md` only once that packet exists (see halt note in
`technical_task_packet.md` §6).

---

## Test Scenario 1 — Paste-first text input
**Traces to:** Acceptance Criterion 1 (`acceptance_criteria.md`)

| Field | Detail |
|---|---|
| Setup | Prepare 5+ sample feedback strings of varying length/informality (short LINE-style one-liners through longer multi-point comments). No login, no account, no connector config performed beforehand. |
| Steps | 1. Open the tool fresh (new browser session/incognito). 2. Paste sample #1 into the input field. 3. Trigger processing. 4. Repeat for all 5+ samples, each in a fresh load of the tool. |
| Expected result | For every sample: (a) the field accepts the paste directly, (b) processing starts from one explicit user action (no hidden multi-step flow), (c) no login/setup/onboarding screen appears at any point before the first output renders. |
| Pass condition | All 5+ samples process to completion with zero setup friction observed. |
| Fail condition | Any sample is blocked by a connector/login/config step before processing starts. |
| Notes for Kyuuei | This is the cheapest test to automate first — it gates everything downstream. If this fails, do not proceed to Scenarios 3–4 (they depend on a working input path). |

## Test Scenario 2 — Screenshot / image upload input
**Traces to:** Acceptance Criterion 2 (`acceptance_criteria.md`)

| Field | Detail |
|---|---|
| Setup | Assemble 5–10 representative screenshot samples spanning: (a) chat-bubble style (LINE/Messenger), (b) threaded comments, (c) design-review markup/annotations. Use anonymised/consented samples only — real client data requires the governance clearance named in `prd.md` §7 item 3, which is independent of this test plan. |
| Steps | 1. Upload each sample image individually (fresh load each time). 2. Trigger processing. 3. Inspect the extracted feedback content (directly, or via its effect on Scenario 3/4 outputs if extraction isn't separately surfaced in the UI). |
| Expected result | Extracted content is legible and substantively matches what a human reader would take from the image — not garbled, not empty, not hallucinated — well enough that the downstream next-action and draft are coherent and traceable to the image's actual content. |
| Pass condition | At least 8 of 10 samples produce extraction good enough that Scenario 3 and 4 outputs are coherent and traceable to the image. |
| Fail condition | Extraction is frequently garbled/empty, or downstream outputs are disconnected from the image's actual content. |
| Notes for Kyuuei | This is the highest-technical-risk scenario per `technical_task_packet.md` §4 ("image extraction quality is inconsistent across screenshot types" — medium severity). Track pass rate per screenshot *type* (bubble/thread/annotation), not just an aggregate — a failure concentrated in one type is a different finding than a uniform 75%. |

## Test Scenario 3 — Exactly one prioritised next action
**Traces to:** Acceptance Criterion 3 (`acceptance_criteria.md`)

| Field | Detail |
|---|---|
| Setup | 10+ varied sample inputs, mixing text-paste and image-upload sources, mixing single-point and multi-point feedback content. Recruit a native-Thai-speaker or domain-fluent reviewer (Rika-Chan or a beta user) for the specificity judgment. |
| Steps | 1. Run each of the 10+ inputs through the tool (fresh session each time). 2. Record the next-action output verbatim for each run. 3. Have the reviewer rate each output as "specific/actionable" or "generic filler" (e.g., "respond to the client" = generic; "tell the client the homepage mockup needs the CTA button moved above the fold before Friday's review" = specific). |
| Expected result | (a) Output count is exactly one on every single run — never zero, never a list. (b) Reviewer judges the action as specific/actionable, not generic, in at least 8 of 10 runs. |
| Pass condition | All 10+ runs return exactly one action; ≥8/10 rated specific/actionable. |
| Fail condition | Any run returns zero or multiple actions as the primary output, OR the majority read as generic filler. |
| Notes for Kyuuei | This is the **highest-severity technical risk named in `technical_task_packet.md` §4** ("exactly one" output discipline failing at the model layer). Specifically test the boundary cases: extremely short input ("ลองดูใหม่อีกที"), extremely long multi-point input, and ambiguous input with no clear single priority — these are the conditions most likely to make a model emit zero, multiple, or list-shaped output. If the build has a retry-once-then-fail-visibly path (named as a mitigation in the technical packet), test that the visible failure is honest (clearly says "couldn't generate a single recommendation" rather than silently showing something malformed). |

## Test Scenario 4 — Exactly one Thai-language client-update draft
**Traces to:** Acceptance Criterion 4 (`acceptance_criteria.md`)

| Field | Detail |
|---|---|
| Setup | Use the **same** 10+ sample inputs as Scenario 3 (so the next-action and draft can be evaluated as a pair from one run). Native-Thai-speaker reviewer required — this cannot be machine-evaluated for tone. |
| Steps | 1. For each of the 10+ runs, record the Thai-draft output verbatim. 2. Reviewer rates each on: (a) professional tone appropriate to a freelancer-client relationship, (b) grammatical/natural Thai (not stilted machine-translation feel), (c) "would I send this with little or no editing?" |
| Expected result | At least 8 of 10 drafts rated professionally toned, natural, and sendable with light-or-no editing. |
| Pass condition | ≥8/10 meet all three reviewer criteria. |
| Fail condition | Majority read as stilted, generic, mistoned, or need substantial rewriting before sending. |
| Notes for Kyuuei | This directly tests the **named open risk #2 from `prd.md` §7** ("Thai informal-text NLP accuracy is unresolved... ~80–85% bar... needs validation before the product is considered MVP done"). Flag results to Rika-Chan regardless of pass/fail — this is a visibility requirement from the PRD, not just a pass/fail gate. If the bar is missed, that is a build-blocking finding, not a "ship and improve later" finding, per `prd.md` §7 item 2's explicit framing. |

## Test Scenario 5 — Zero persistent memory / one-shot session integrity
**Traces to:** Acceptance Criterion 5 (`acceptance_criteria.md`)

| Field | Detail |
|---|---|
| Setup | Two sequential, unrelated test sessions (Session A, Session B) using clearly distinguishable sample inputs (e.g., Session A mentions a fictional "Project Sunflower," Session B mentions a fictional "Project Anchor" — distinctive enough that any leakage is unmistakable). |
| Steps | **Functional check:** 1. Run Session A to completion with its distinctive input. 2. Fully end Session A (close tab, clear nothing manually — test the product's own boundary, not a manually-cleared one). 3. Start Session B fresh with its distinctive input. 4. Inspect every surface Session B can reach — UI, any "history" affordance, browser storage inspector, network tab — for any trace of Session A's content (the words "Sunflower," its next-action, or its draft). **Architecture check:** 5. With Aki/Coda, walk through the actual technical design (per `technical_task_packet.md` §3 data flow) confirming no persistent storage layer for project/client context exists anywhere in the stack — this is a design-review step, not just a black-box UI probe. |
| Expected result | Session B shows zero retrievable trace of Session A's content through any surface; the architecture walkthrough confirms no persistent storage layer for session/project/client content exists (consistent with `technical_task_packet.md` §3's "nothing persists past this point" data-flow boundary). |
| Pass condition | Both the functional probe and the architecture review come back clean. |
| Fail condition | Any trace of Session A is retrievable from Session B through any surface, OR a persistent storage layer for project/client context exists even if not yet user-facing. |
| Notes for Kyuuei | This is the test that protects the entire premise of the >60% day-3 return-rate metric (`prd.md` §3) — if a hidden persistence layer exists, the retention signal would be measuring something other than what `dec-20260607-004` intended to test, and the whole MVP bet would be compromised silently. Treat any finding here as an immediate stop-and-report to Rika-Chan, not a routine bug ticket. Also explicitly check the items named as forbidden patterns in `technical_task_packet.md` §5 (caches, debug logs with content, session cookies used for content retention) — these are the most likely accidental-reintroduction vectors. |

---

## Cross-Cutting Test Notes

- **Sequencing:** Run Scenario 1 first (it gates input). Run Scenario 2 in parallel-but-independent
  fashion (different input path). Run Scenarios 3 and 4 together per input run (they share the same
  10+ sample set by design — see each scenario's Setup). Run Scenario 5 last and independently —
  it is an integrity check on the whole system, not a feature test.
- **Reviewer dependency:** Scenarios 3 and 4 require a native-Thai-speaker / domain-fluent human
  reviewer — they cannot be fully automated. Plan reviewer time accordingly; this is a real
  scheduling constraint for Kyuuei, not a detail to discover mid-cycle.
- **Sample corpus dependency:** Scenarios 2, 3, and 4 depend on the "real feedback sample" corpus
  named as open question #5 in `prd.md` §7 ("sourcing this corpus is an open logistics question").
  If that corpus is not ready, Kyuuei should use synthetic-but-realistic samples for a first pass
  and flag the corpus gap to Rika-Chan — do not silently substitute synthetic samples for the
  beta-readiness judgment, only for the build-cycle smoke test.
- **has_ui_component = true → Tessa routes in** after Kyuuei, per `CLAUDE.md` roster note on
  Tessa's conditional routing. Tessa's QA/UX inspection should focus on Scenario 1's "no setup
  friction" claim and the Output Renderer's copy-to-clipboard affordance (named in
  `technical_task_packet.md` §2) — these are UX-quality questions Kyuuei's functional pass/fail
  framing won't fully surface.
- **What this test plan does not cover:** PDPA/privacy clearance (belongs to `governance_check.md`
  and Rika-Chan, named explicitly as a separate gate in `acceptance_criteria.md`'s cross-cutting
  note) and the beta-access-control question (belongs to the halt artifact
  `handoffs/approval_request_20260607_002.md`). Do not treat a clean run of this test plan as
  clearing either of those.

---

> Companion to: `handoffs/technical_task_packet.md` (ttp-20260607-001) · `handoffs/acceptance_criteria.md` (ac-20260607-001)
> Referenced by: `handoffs/codex_task_packet.md` (ctp-20260607-001 — written and active; see its
> "Test Plan Reference" section)
> Status: written and ACTIVE; execution owner is Kyuuei (+ Tessa conditionally). No content edits
> were needed for Shape A — Scenario 5 (zero-trace/one-shot integrity) and Scenario 1 (no setup
> friction) already cover the surfaces the shared-access gate touches; Kyuuei is pointed there
> directly by `codex_task_packet.md`.
