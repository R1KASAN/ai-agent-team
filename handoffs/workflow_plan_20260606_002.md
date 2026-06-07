---
workflow_plan_id: workflow_plan_20260606_002
created_by: Minori Lead Conductor [Mi]
created_at: 2026-06-06
raw_input: "แอปที่ทำให้ 'สิ่งที่เราเคยเซฟแล้วดอง' (ลิงก์, โน้ต, คลิป, PDF ฯลฯ) กลับมาช่วยเราได้จริง ในจังหวะที่เรากำลังต้องใช้มัน → ลดความรู้สึกท่วม, ลด overthinking, และทำให้เริ่มลงมือได้ง่ายขึ้น"
prior_related_plan: none (distinct from workflow_plan_20260606_001 — different problem space)
status: awaiting_rika_approval
---

# Workflow Plan — 20260606-002

## Raw Input (Thai)

> "แอปที่ทำให้ 'สิ่งที่เราเคยเซฟแล้วดอง' (ลิงก์, โน้ต, คลิป, PDF ฯลฯ) กลับมาช่วยเราได้จริง
> ในจังหวะที่เรากำลังต้องใช้มัน → ลดความรู้สึกท่วม, ลด overthinking, และทำให้เริ่มลงมือได้ง่ายขึ้น"

**Translation:** An app that makes "things we saved and left to marinate" (links, notes, clips, PDFs, etc.)
come back to actually help us at the moment we need them — reduce the feeling of overwhelm,
reduce overthinking, and make it easier to start taking action.

---

## Minori Classification

| Field | Value |
|---|---|
| Input Type | New product idea — platform, resurfacing mechanism, content sources, and target user unspecified |
| Risk Level | Medium |
| Completeness | Incomplete — 5 key unknowns |
| Primary Route | `product_idea_debate` |
| Relation to prior plans | **Distinct** from 20260606-001 (social feed-filtering). Distinct problem: personal knowledge retrieval, not social media curation. |

---

## Meta-Observation (Minori flag)

This idea is structurally what **Tsumugi** already does *inside this studio* — resurface saved knowledge at the right moment. The debate should pressure-test whether this is:
- A product *for others* built on the same pattern
- A productized version of the studio's own second-brain workflow
- Something meaningfully different from existing tools (Readwise, Mem, Rewind, Obsidian)

Yuki must challenge this framing directly.

---

## Known Inputs

- Core problem: "save and forget" — users accumulate links, notes, clips, PDFs but never retrieve them when relevant
- Desired outcome: content resurfaces *at the right moment*, reducing overwhelm and enabling action
- Content types mentioned: links, notes, clips, PDFs (multi-format)
- Anti-goals stated: reduce overwhelm, reduce overthinking, lower barrier to starting action
- Platform / delivery format: **unspecified**
- Resurfacing trigger / "right moment" logic: **unspecified** (this is the core product question)
- Target content sources: **unspecified** (Pocket? Notion? Apple Notes? browser bookmarks? Readwise? email?)
- Target user: **unspecified** (knowledge workers? students? creators? solo founders?)
- Monetization model: **unspecified**

---

## Missing Inputs (Clarification Needed)

1. **What triggers "the right moment"?**
   — Does the user query it manually? Does it surface based on current task/context? Calendar-based? Daily digest? AI pattern matching?
2. **Which save sources should be integrated?**
   — Browser bookmarks, Pocket/Instapaper, Notion/Obsidian/Roam, Apple Notes, email newsletters, YouTube saves, PDF library?
3. **Target platform / delivery format**
   — Mobile app, desktop app, browser extension, web app, daily email digest, Slack/Telegram bot?
4. **Target user profile**
   — Personal tool for Rika-Chan only, or B2C product? Which user persona (knowledge worker, student, creator, solo founder)?
5. **Monetization model**
   — Free, freemium, subscription, B2B/team, or personal tool only?

---

## Assumptions (Labeled — Pending Debate)

- A1: The product is B2C (not personal tool only) — built for other "save-and-forget" sufferers.
- A2: "Right moment" is primarily AI-driven context matching, not manual search — otherwise it's just Pocket/Readwise with search.
- A3: At least 3–5 content source integrations required for MVP to be useful; single-source tools already exist.
- A4: Resurfacing is push-based (system decides when to surface) OR pull-based with smart query (user asks, system retrieves) — the choice is the core product bet.
- A5: No existing IP, code, partnerships, or legal constraints declared.

---

## Risk Flags

| Risk | Severity | Notes |
|---|---|---|
| Crowded market | High | Readwise Reader, Mem.ai, Rewind.ai, Capacities, Obsidian + plugins, Notion AI, Apple Intelligence all claim this space. Differentiation is the key debate. |
| "Right moment" detection is technically hard | High | Push-based resurfacing requires knowing what the user is doing *right now* — context inference is hard without OS-level access or deep integrations. |
| Integration complexity | Medium | Multi-source ingestion (bookmarks + notes + PDFs + clips) is high surface area. OAuth, parsing, rate limits, format normalization. |
| Data privacy & trust | Medium | Reading user's entire saved content library requires strong trust. Privacy-first positioning may be mandatory. PDPA/GDPR applies if EU/TH users targeted. |
| "Overwhelming the overwhelmed" trap | Medium | A poorly tuned resurfacing system adds *more* noise to overwhelmed users — the opposite of the stated goal. UX quality is load-bearing. |
| Personal tool vs. product confusion | Low-Medium | If this is "Tsumugi for others," the internal studio workflow must be carefully decoupled from the product — they have different constraints. |

> Risk level: **Medium** overall. Market differentiation and the "right moment" mechanism are the two highest-priority debate targets.

---

## Workflow Plan

```yaml
workflow_plan:
  workflow_id: product_idea_debate
  goal: >
    Challenge the "save-and-forget resurface" app idea across:
    (1) differentiation from Readwise / Mem / Rewind / Obsidian ecosystem,
    (2) "right moment" mechanism (push vs pull; context inference),
    (3) integration scope vs. MVP viability,
    (4) target user and willingness-to-pay,
    (5) data privacy model.
    Produce a validated Product Opportunity Brief or a kill with reasoning.
  known_inputs:
    - Core problem: save-and-forget content that never gets used
    - Desired outcome: context-aware resurfacing at the right moment
    - Content types: links, notes, clips, PDFs
    - Anti-goals: reduce overwhelm, reduce overthinking
  missing_inputs:
    - Resurfacing trigger / "right moment" mechanism
    - Content source integrations required
    - Target platform / delivery format
    - Target user profile
    - Monetization model
  assumptions:
    - A1: B2C product intent
    - A2: AI-driven context matching is the core differentiator
    - A3: Multi-source ingestion required for MVP
    - A4: Push-based OR smart-pull — debate must resolve which
    - A5: No declared technical or legal constraints
  risk_flags:
    - Crowded market / differentiation (High)
    - "Right moment" detection complexity (High)
    - Integration surface area (Medium)
    - Data privacy / trust (Medium)
    - Overwhelming-the-overwhelmed UX trap (Medium)
  agent_sequence:
    - step: 1
      agent: Minori Lead Conductor [Mi]
      input_artifact: raw_input
      output_artifact: workflow_plan_20260606_002.md (this file)
      context_budget: small
      stop_condition: Plan delivered; awaiting Rika-Chan approval
      approval_gate: true

    - step: 2
      agent: Yuki Idea Challenger [Yu]
      input_artifact: workflow_plan_20260606_002.md
      output_artifact: idea_challenge_brief_20260606_002.md
      context_budget: small
      stop_condition: >
        Riskiest assumptions mapped; "right moment" mechanism challenged;
        Readwise/Mem/Rewind competitive gap pressure-tested;
        push vs pull bet debated; privacy model probed
      approval_gate: false

    - step: 3
      agent: Nova-V Evidence Verifier [NV]
      input_artifact: idea_challenge_brief_20260606_002.md
      output_artifact: evidence_pack_20260606_002.md
      context_budget: small
      stop_condition: >
        Market size, competitor landscape (Readwise/Mem/Rewind/Capacities),
        "spaced repetition + context retrieval" research, WTP signal evidence
        produced and verified (internal loop ≤2)
      approval_gate: false

    - step: 4
      agent: Sora Strategy Sensei [So]
      input_artifact: evidence_pack_20260606_002.md
      output_artifact: strategic_lens_20260606_002.md
      context_budget: small
      stop_condition: >
        Competitive moat, 3–5 year bet, kill/proceed recommendation made;
        platform strategy and differentiation angle defined
      approval_gate: false

    - step: 5
      agent: Bumi Business Analyst [Bu]
      input_artifact: strategic_lens_20260606_002.md
      output_artifact: business_analysis_brief_20260606_002.md
      context_budget: small
      stop_condition: >
        WTP signal assessed; TAM estimated; unit economics and pricing
        model ranked; business viability verdict produced
      approval_gate: false

    - step: 6
      agent: Poom Product Manager [Po]
      input_artifact: business_analysis_brief_20260606_002.md
      output_artifact: product_opportunity_brief_20260606_002.md
      context_budget: small
      stop_condition: >
        Product Opportunity Brief complete — recommended platform, resurfacing
        mechanism, integration scope, and MVP definition
      approval_gate: true   # Rika-Chan must approve before PRD begins

  workflow_type: sequential_handoff
  context_budget: small
  approval_points:
    - After Step 1 (this plan) — Rika-Chan approves before Yuki runs
    - After Step 6 — Rika-Chan approves product_opportunity_brief before PRD begins
  stop_conditions:
    - strategic_lens recommends kill → halt at Step 4; Rika-Chan decides before Bumi runs
    - business_analysis verdict is not_viable → halt at Step 5; Rika-Chan decides before Poom runs
    - Yuki identifies idea as not distinguishable from Readwise/Mem → escalate to Rika-Chan before Step 3
    - Rika-Chan does not approve any gate → workflow halts at that step
```

---

## Clarification Questions for Rika-Chan (Optional — Max 3)

Answering these sharpens the debate. Not required — Yuki can debate with assumptions A1–A5.

1. **What triggers "the right moment" in your vision?**
   (e.g., you're working on a task and it auto-suggests related saves; daily morning digest; you type a question and it retrieves; or "let Yuki challenge my intuition")

2. **Which save sources matter most to you personally?**
   (e.g., browser bookmarks, Pocket, Notion, Apple Notes, YouTube, PDF folder, email newsletters)

3. **Is this a product for others, or first a tool for yourself that you'd later productize?**

> Unanswered → Yuki treats these as open assumptions and challenges them directly.

---

## Minori Stop Declaration

`[Mi]` Minori has completed the Input Gatekeeper step.
No specialist agent has been activated.
Workflow is **paused** pending Rika-Chan approval.

**Next action:** Rika-Chan approves this plan (with or without answering clarification questions) → Step 2 activates Yuki Idea Challenger via `/product-idea-debate`.
