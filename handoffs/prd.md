---
template: prd
produced_by: Poom Product Manager
workflow: product_idea_to_prd
version: "1.0"
---

# PRD — Feedback-to-Action (working title)
## AI Assistant: Scattered Client Feedback → Clear Next Actions

```yaml
prd_id: prd-20260607-001
product_name: "Feedback-to-Action (working title — naming TBD, not a Poom decision)"
produced_by: Poom Product Manager
approved_brief: handoffs/product_opportunity_brief.md (pob-20260607-001)
rika_chan_approval: "dec-20260607-005 (2026-06-07) — brief approved; PRD drafting cleared"
date: "2026-06-07"
status: draft
# Hard stop: Rika-Chan must approve this prd.md before /prd-to-codex-tasks activates Aki
```

---

## 1. Problem Statement

Thai solo digital workers managing 2–5 active clients receive feedback continuously through
informal channels (LINE, Messenger, screenshots) and lose an estimated 15–30 minutes per project
per day rereading, mentally prioritising, and drafting a professional reply. This is a daily,
career-impacting task currently handled by manual rereading or a generic ChatGPT session that
demands prompt skill and re-entry of context every time. The pain is real, frequent, and
professionally consequential — but it is not yet named by the user as a "solvable problem," which
is itself part of the product-education challenge. [carried verbatim from `pob-20260607-001` →
Problem; sourced from `handoffs/business_analysis_brief.md` → Pain Severity]

This PRD does not solve "client relationship management" or "project memory." It solves one
narrow moment: **feedback lands → user is stuck on what to do and how to reply professionally →
product removes that stall in one paste.**

## 2. Target User

**Primary persona (locked, not re-litigated):** The Thai solo digital worker — freelance designer,
developer, content creator, or social media manager — managing 2–5 active clients, receiving
feedback primarily via LINE, comfortable copy-pasting into ChatGPT but not a deep technical user,
whose professional reputation depends on the speed and quality of client communication. Works
alone or in a micro-team of 1–2.

**Explicitly not the persona for this MVP:** the small-agency owner who needs routing/assignment
across staff (Bumi's secondary archetype). That requires a different product surface (multi-seat,
task distribution) and is noted only as a future expansion path — it must not shape MVP feature
decisions. [carried verbatim from `pob-20260607-001` → Target User]

## 3. Goals and Success Metrics

| Goal | Metric | Target |
|------|--------|--------|
| Validate that a one-shot (no-memory) tool clears the "ChatGPT substitute test" (assumption A1) | Day-3 manual-beta return rate, 10–20 seeded users, using real client feedback | **>60% return after day 3** (Bumi's Phase-1 gate; carried verbatim from `pob-20260607-001` → Success Metric) |
| Confirm users can articulate the felt difference vs. ChatGPT (qualitative companion to the return-rate number — A1 fails if this is silent even when return-rate looks acceptable) | Unprompted answer to "what does this do in 10 seconds that ChatGPT can't do in 30 seconds?" collected in beta debrief | Majority of retained beta users can answer without prompting |
| Confirm Thai informal-text NLP is usable at MVP quality (open risk, not yet resolved) | Output-quality spot check against real (anonymised/consented) feedback samples before beta launch | ~80–85% perceived-accuracy bar per Bumi; tracked as an open risk below, not a guaranteed pre-condition |

No pricing target appears here — pricing is explicitly out of scope for this PRD (see §6 and Poom's
Forbidden Actions). The success metrics above exist to produce the WTP signal that a future pricing
decision will depend on, not to set that price.

## 4. MVP Scope

> Minimal feature set that tests the riskiest assumption (A1). Numbered for traceability into
> acceptance criteria (§5) and the companion `mvp_scope.md`.

1. **Paste-first text input** — a single input surface where the user pastes raw client feedback
   as plain text (copied from LINE, Messenger, email, anywhere). No platform connector, no login
   to a third-party messaging account.
2. **Screenshot / image upload input** — the user can instead (or additionally) upload an image
   of a chat/comment/feedback screen; the product extracts the feedback content from the image.
3. **One prioritised next action (output #1)** — a single, clearly-stated action the user should
   take first, generated from the pasted/uploaded feedback. Not a list, not a checklist — exactly
   one item, to reduce decision fatigue (per Sora's "keep" rationale).
4. **One Thai-language client-update draft (output #2)** — a ready-to-send, professionally-toned
   message in Thai that the user can copy and paste back to the client with minimal or no editing.
5. **Self-contained, one-shot session** — each run is independent: no project history, no
   client-spanning memory, no persistent storage of the pasted content or generated outputs
   between sessions. This is the locked architectural decision from `dec-20260607-004` and is
   the spine of the entire MVP — every other feature decision in this list exists to test it
   honestly, with nothing else propping up retention.

Total: **5 numbered MVP items.** Anything not on this list is out of scope by default (§6 and
`out_of_scope.md`).

## 5. Acceptance Criteria

> One entry per MVP feature (§4). Testable and unambiguous. Full detail in companion
> `acceptance_criteria.md`; summarised here for traceability.

| Feature # | Criterion | Test Method |
|-----------|----------|------------|
| 1 | User can paste plain text into a single input field and trigger processing without any setup, login, or connector configuration | Manual walkthrough: paste real (sample) feedback text → confirm processing starts with no blocking step |
| 2 | User can upload a screenshot/image and the product extracts feedback content from it well enough to produce a coherent next action and draft | Manual walkthrough with 5–10 representative screenshot samples (chat bubbles, comment threads, design-review marks); confirm extracted content is usable, not garbled |
| 3 | For a given input, the product returns exactly one prioritised next action — not zero, not a list | Run 10+ varied sample inputs; confirm output count is always exactly one, and the action is specific enough to act on (not generic filler like "respond to client") |
| 4 | For the same input, the product returns exactly one Thai-language client-update draft that reads as professionally toned and could plausibly be sent with light or no editing | Run the same 10+ sample inputs; native-Thai-speaker (Rika-Chan or beta user) review confirms tone is professional and message is sendable |
| 5 | After a session ends (or a new session starts), no prior pasted content, generated output, or client-identifying data persists anywhere the product can retrieve it | Technical check: run two sequential unrelated sessions; confirm session 2 has zero access to session 1's content; confirm no persistent storage layer exists for project/client context |

## 6. Out of Scope

> Explicit. Everything not listed in §4 is assumed out of scope. Full list with rationale in
> companion `out_of_scope.md`. Summary:

- LINE official API integration / any platform-native connector (Messenger, Drive, Notion, etc.)
- Voice/audio input
- Task-checklist as a third output (the original idea had three outputs; cut to two for MVP focus)
- Automated scheduling or reminder features
- Any persistent memory, project history, or client-spanning context (this is the locked
  architectural choice, not a deferred feature — re-litigating it requires a new Rika-Chan decision,
  not a PRD edit)
- Multi-seat / team / agency routing and assignment surfaces (secondary archetype — different
  product, different PRD)
- Pricing, billing, payment integration, account/auth system (flagged separately — see §7 and the
  workflow's Approval Gates: "any auth/payments/database/infra items in PRD → flagged for
  Rika-Chan before Aki runs." None of these appear in MVP scope; if Aki's technical translation
  requires any of them to exist even minimally — e.g., a beta-access gate — that requirement must
  return to Rika-Chan before being treated as in-scope.)

## 7. Open Questions

> Questions that must be resolved before or during build. Carried forward from the approved brief's
> Open Risks — Poom does not resolve these; they are flagged for the right owner.

1. **[HIGH PRIORITY — carry into scoping for Aki/Coda] Low moat / fast-follow differentiation
   risk.** The one-shot architecture (locked by `dec-20260607-004`, accepted as a tracked risk by
   Rika-Chan) means this product can be substituted by a ChatGPT custom GPT or Gemini Gem with
   relatively little effort. This PRD does not solve that — it cannot, without reopening the
   architecture decision. But Aki and Coda must scope and build in a way that **does not foreclose**
   a future differentiation layer (e.g., output quality, Thai-tone calibration, UX speed) even
   though memory is explicitly out of scope now. This is the single largest open risk carried
   forward and should directly shape how aggressively the team moves once WTP is confirmed — a
   fast-follow differentiation plan should be ready to act on, not started from zero, the moment
   the >60% gate is cleared.
2. **Thai informal-text NLP accuracy is unresolved.** Bumi flags ~80–85% accuracy on real feedback
   samples as the bar; this has not been prototype-tested. Needs validation before the product is
   considered "MVP done," not just before scaling. Owner: Coda/Kyuuei during build, with Rika-Chan
   visibility if the bar is missed.
3. **Privacy/PDPA exposure from client message and screenshot upload is unresolved.** Even with
   zero persistent storage, data is still processed and transmitted (e.g., to whatever model/API
   performs the extraction and generation). This requires legal/governance review **before any
   beta with real client data** — flagged for the governance review step in this workflow
   (`governance_check.md`) and ultimately Rika-Chan, not assumed clear by this PRD.
4. **WTP remains unsourced (ASSUMPTION-level).** The $5–8/month range is comparable-spend
   reasoning, not user research. This PRD intentionally sets no price (Poom is forbidden from
   setting pricing); the Phase-1 manual beta described in §3 is the validation step, and any
   pricing or scaling decision must wait for that signal plus Rika-Chan approval.
5. **What counts as a "real feedback sample" for testing?** Before beta, the team needs a small,
   consented, anonymised corpus of representative Thai client-feedback text and screenshots to
   validate features 2–5 against. Sourcing this corpus is an open logistics question — likely
   Rika-Chan's network or the Thai freelancer communities Bumi names for Phase 2 distribution —
   and should be resolved early so it doesn't block Coda's testing cycle.

## 8. Approval Required Before Build

- [ ] Rika-Chan approves this `prd.md` (and companions `mvp_scope.md`, `acceptance_criteria.md`,
      `out_of_scope.md`)
- [ ] Sora strategic review confirms alignment (per `workflows/product_idea_to_prd.md` step 3)
- [ ] Bumi business review confirms alignment (step 4)
- [ ] Governance review (`governance_check.md`) clears privacy/PDPA and any other flags (step 5)
- [ ] No auth / payments / database / infra items are present in MVP scope as drafted — confirmed
      in §6; any future addition requires separate Rika-Chan approval before Aki treats it as
      in-scope

---

> Passes to: `aki_system_architect.md` — **NOT YET. HARD STOP per `agents/claude_team/poom_product_manager.md` Approval Gates and `CLAUDE.md` named gate "Product Opportunity Brief before PRD" (the PRD itself carries an equivalent build-gate per `workflows/product_idea_to_prd.md` step 5 exit).**
> Companion files: `mvp_scope.md`, `acceptance_criteria.md`, `out_of_scope.md`
> Status: draft — awaiting Rika-Chan approval before `/prd-to-codex-tasks` activates Aki
