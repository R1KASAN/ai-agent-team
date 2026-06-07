---
template: product_opportunity_brief
produced_by: Poom Product Manager
workflow: product_idea_debate
version: "1.0"
---

# Product Opportunity Brief

```yaml
brief_id: pob-20260607-001
produced_by: Poom Product Manager
source_artifacts:
  - business_analysis_brief: handoffs/business_analysis_brief.md
  - strategic_lens: handoffs/strategic_lens.md
  - decision_log: dec-20260607-004 (strategic fork resolved → ONE-SHOT TOOL)
date: "2026-06-07"
status: AWAITING_RIKA_CHAN_APPROVAL
# Hard stop: Rika-Chan must approve before PRD begins
```

## Problem

Thai solo digital workers juggling 2–5 active clients receive feedback continuously through informal channels (LINE, Messenger, screenshots) and lose ~15–30 minutes per project per day rereading, mentally prioritising, and drafting a professional reply — a task that is daily, career-impacting, and currently solved only by manual rereading or a generic ChatGPT session that requires prompt skill and re-entering context each time.

## Target User

**Primary:** The Thai solo digital worker (freelance designer, developer, content creator, or social media manager) managing 2–5 active clients, receiving feedback primarily via LINE, comfortable copy-pasting into ChatGPT but not a deep technical user, whose professional reputation depends on the quality and speed of client communication.

(Secondary archetype — small agency owners needing routing/assignment — is explicitly out of scope for this MVP; it requires a different product surface and is noted only as a future expansion path.)

## Pain Severity

`high` — Bumi's analysis rates frequency as daily/high-confidence and emotional cost as medium-high (client communication errors damage professional reputation); time-cost (~15–30 min/day) is ASSUMPTION-level and still needs Nova verification, but the directional severity is consistent across both Bumi's and Sora's analyses. [ref: `handoffs/business_analysis_brief.md` → Pain Severity table]

## Proposed Solution

A **one-shot, paste-first AI tool**: the user pastes raw client feedback (text and/or a screenshot of a chat/comment) and instantly receives two structured outputs — (1) one prioritised next action, and (2) a ready-to-send professional client-update draft in Thai. No account-spanning memory, no project history, no persistent data layer — each session is self-contained ("paste in, structured output out, done"). This directly operationalises Rika-Chan's `dec-20260607-004` choice of one-shot over memory-layer architecture: it trades long-term moat for build speed, lower switching cost, and a fast WTP read. Platform-agnostic and paste-first per Sora's "streaming, not DVD-trap" framing — LINE is the marketing hook for Thai acquisition, not a technical dependency.

## Key Assumptions

| Label | Assumption | Risk |
|-------|-----------|------|
| A1 | A one-shot tool can produce an output felt as meaningfully faster/better than a 30-second ChatGPT prompt — i.e., it passes Bumi's "ChatGPT substitute test" without a memory layer | high |
| A2 | Thai users will paste real client feedback (incl. screenshots) into a third-party tool without a privacy/trust blocker, even with no persistent data layer | high |
| A3 | Thai informal-text NLP accuracy reaches ~80–85% on real feedback samples using off-the-shelf models (no fine-tuning investment at MVP stage) | high |
| A4 | Users will return for repeat one-shot sessions often enough (>60% return by day 3, per Bumi's gate) to justify a paid tier, despite the tool having no compounding/memory value | medium |
| A5 | $5–8/month is a viable price point for a Thai freelancer audience that already spends on ChatGPT Plus, Canva, etc. | medium |

## Business Model Hypothesis

Freemium one-shot tool — limited free sessions/day, ~$6–8/month for unlimited use — validated only after Phase 1 manual-beta WTP signal; no pricing commitment at this stage. [ref: `handoffs/business_analysis_brief.md` → Business Model Options / Recommended starting model]

## MVP Hypothesis

The smallest version that tests the riskiest assumption (A1 — "does a one-shot tool beat ChatGPT clearly enough to be worth using again, with no memory to fall back on?"): a paste-first web tool accepting text and/or screenshot input, returning exactly two outputs — one prioritised next action and one Thai-language professional client-update draft — with zero persistent storage of project/client context between sessions. Per Sora's MVP cut list: no LINE API integration, no multi-platform connectors, no voice/audio input, no task-checklist third output, no scheduling/reminders.

## Success Metric

**Primary (30/60/90-day):** Day-3 manual-beta return rate among 10–20 seeded users — Bumi's stated gate is **>60% return after day 3** using the tool on real client feedback. This is the single metric that tells us whether a one-shot (no-memory) design is "enough" before any pricing or build-scale decision is made. Secondary signal to watch in parallel: qualitative answer to the "what does this do in 10 seconds that ChatGPT can't do in 30" question — if beta users cannot answer it unprompted, A1 is failing regardless of return-rate numbers.

## Open Risks

- **[Tracked, accepted by owner] Low moat / easy substitution by ChatGPT custom GPTs or Gemini Gems** — directly inherited from the one-shot architecture choice in `dec-20260607-004`. Rika-Chan accepted this as a tracked risk, not a blocker, in exchange for build speed and faster WTP validation. This is the single largest open risk carried into PRD and should shape how aggressively we move once WTP is confirmed (i.e., a fast follow-on differentiation plan, not a slow one).
- **Thai informal-text NLP accuracy** — unresolved; needs a prototype test against real feedback samples before MVP is considered "done" (Bumi flags ~80–85% accuracy as the bar).
- **Privacy/PDPA exposure from client message/screenshot upload** — unresolved; needs legal review before any beta with real client data, even with no persistent storage (data is still processed/transmitted).
- **WTP is currently unsourced (ASSUMPTION-level)** — the entire $5–8/month range comes from comparable-spend reasoning, not direct user research; Phase 1 manual beta is the validation step and must happen before any pricing or scaling decision.
- **No compounding value to retain users past initial novelty** — because the architecture is intentionally one-shot, there is no built-in mechanism (memory, history, accumulating project context) to keep users returning once the "wow" of first use fades; return-rate must be earned through output quality alone.

## Recommendation

`proceed_to_prd`

**Reasoning:** The problem is real, daily, and professionally consequential (Bumi: high-confidence pain), the strategic fork that previously blocked sizing/pricing is now resolved by the owner (`dec-20260607-004` — one-shot), and Sora's MVP cut/keep lists already give a disciplined, buildable scope that fits a one-shot architecture cleanly (paste-first text + screenshot → one next action + one client draft). The riskiest assumption (A1: "does one-shot beat ChatGPT enough to matter") is cheap to test with the proposed MVP and Bumi's existing Phase-1 gate (>60% day-3 return on 10–20 beta users) — there is no need to reframe or stop; the right move is to scope a lean MVP that tests A1 directly and treats the low-moat risk as a tracked, owner-accepted tradeoff rather than a reason to pause. PRD should explicitly carry forward the "low moat / fast-follow differentiation" risk so Aki and Coda scope the build in a way that doesn't foreclose a future differentiation layer, even though memory is out of scope now.

---

> **APPROVAL GATE — Do not proceed to PRD without Rika-Chan sign-off.**
> Passes to: `poom_product_manager.md` (PRD phase) after approval
