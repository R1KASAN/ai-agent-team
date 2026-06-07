---
template: acceptance_criteria
produced_by: Poom Product Manager
workflow: product_idea_to_prd
companion_to: handoffs/prd.md (prd-20260607-001)
version: "1.0"
---

# Acceptance Criteria — Feedback-to-Action (working title)
## AI Assistant: Scattered Client Feedback → Clear Next Actions

```yaml
ac_id: ac-20260607-001
produced_by: Poom Product Manager
companion_to: handoffs/prd.md (prd-20260607-001), handoffs/mvp_scope.md (mvp-20260607-001)
date: "2026-06-07"
status: draft
rule: "One entry per MVP feature. Testable and unambiguous. Numbered to match prd.md §4 / mvp_scope.md."
```

---

## Feature 1 — Paste-first text input

| Field | Detail |
|---|---|
| Criterion | A user can paste raw feedback text (any length, any source) into a single visible input field and trigger processing without logging in, configuring a connector, or completing any setup step. |
| Test Method | Manual walkthrough using 5+ sample feedback strings of varying length and informality (from short LINE-style messages to longer multi-point comments). Confirm: (a) the field accepts paste directly, (b) processing starts from a single explicit user action, (c) no blocking screen (login/setup/onboarding wall) appears before the first output. |
| Pass condition | All 5+ samples process to completion with no setup friction observed. |
| Fail condition | Any sample requires a connector, login, or configuration step before processing can start. |

## Feature 2 — Screenshot / image upload input

| Field | Detail |
|---|---|
| Criterion | A user can upload an image of a chat thread, comment section, or design-review annotation, and the product extracts feedback content from it well enough to feed a coherent next action and client draft (Features 3 and 4). |
| Test Method | Manual walkthrough with 5–10 representative screenshot samples covering: chat bubbles (LINE/Messenger style), threaded comments, and design-review markup/annotations. For each, confirm extracted content is legible and substantively matches what a human reader would take from the image (not garbled, not hallucinated, not empty). |
| Pass condition | At least 8 of 10 samples produce extraction good enough that downstream outputs (Features 3, 4) are coherent and traceable to the actual image content. |
| Fail condition | Extraction is frequently garbled, empty, or produces downstream outputs disconnected from the image's actual content. |

## Feature 3 — One prioritised next action (output #1)

| Field | Detail |
|---|---|
| Criterion | For any given input (text or image), the product returns exactly one prioritised next action — never zero, never a list — and that action is specific enough to act on immediately (not generic filler such as "respond to the client" or "review the feedback"). |
| Test Method | Run 10+ varied sample inputs (mixing text and image, mixing single-point and multi-point feedback). For each run, confirm: (a) output count is exactly one, (b) a native-Thai-speaker or domain-fluent reviewer (Rika-Chan or a beta user) judges the action as specific and immediately actionable, not generic. |
| Pass condition | All 10+ runs return exactly one action; reviewer judges at least 8 of 10 as specific/actionable rather than generic. |
| Fail condition | Any run returns zero or multiple actions as the primary output, or the majority of actions are generic enough to apply to any feedback regardless of content. |

## Feature 4 — One Thai-language client-update draft (output #2)

| Field | Detail |
|---|---|
| Criterion | For the same input that produced the next action, the product also returns exactly one ready-to-send message in professionally-toned Thai that a reviewer judges could plausibly be sent to a client with light or no editing. |
| Test Method | Run the same 10+ sample inputs used for Feature 3. A native-Thai-speaker reviewer (Rika-Chan or a recruited beta user) rates each draft on: (a) professional tone appropriate to a freelancer-client relationship, (b) grammatical/natural Thai (not machine-translation-stilted), (c) "would I send this with little or no editing?" |
| Pass condition | At least 8 of 10 drafts are rated as professionally toned, natural, and sendable with light-or-no editing by the reviewer. |
| Fail condition | The majority of drafts read as stilted, generic, mistoned, or require substantial rewriting before they could be sent. |

## Feature 5 — Self-contained, one-shot session (zero persistent memory)

| Field | Detail |
|---|---|
| Criterion | After any session completes (or when a new session starts), no content from a prior session — pasted text, uploaded image, generated next action, generated draft, or any derived client-identifying data — is stored, retrievable, or accessible anywhere within the product. |
| Test Method | Technical verification: (a) run Session A with a distinctive sample input; (b) close/end Session A; (c) run Session B with a different input; (d) confirm Session B has zero access to Session A's content through any product surface (UI, history, cache, account-level state); (e) inspect the technical design (with Aki/Coda) to confirm no persistent storage layer for project/client context exists — this is an architecture check, not just a UI check. |
| Pass condition | Session B shows zero retrievable trace of Session A's content through any surface; architecture review confirms no persistent storage layer for session content exists. |
| Fail condition | Any trace of a prior session's content is retrievable from a new session through any surface, OR a persistent storage layer for project/client context exists even if not yet user-facing. |

---

## Cross-Cutting Note: Privacy/PDPA Check Is Not an Acceptance Criterion Here — But Is a Gate

Feature 5's "zero persistent storage" criterion does **not** by itself clear the privacy/PDPA risk
flagged in `pob-20260607-001` Open Risks and restated in `prd.md` §7 — even with no storage, data
is processed and transmitted (e.g., to whichever model/API performs extraction and generation).
That review belongs to the governance step (`governance_check.md`) in `workflows/product_idea_to_prd.md`
and ultimately to Rika-Chan, not to this acceptance-criteria document. It is named here only so
Aki/Coda do not mistake "Feature 5 passes" for "privacy is cleared" — they are different gates.

---

> Companion to: `prd.md` (prd-20260607-001) · `mvp_scope.md` · `out_of_scope.md`
> Status: draft — gated with `prd.md` under the same Rika-Chan approval before Aki is activated
