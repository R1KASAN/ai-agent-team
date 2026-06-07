---
workflow_plan_id: workflow_plan_20260605_003
created_by: Minori Lead Conductor
created_at: 2026-06-05
raw_input: "อยากสร้าง Extension ที่คัดกรองโพสต์ในฟีดของ Social Media หรือทำเป็น APP หรือ Widget ดี"
status: awaiting_rika_approval
---

# Workflow Plan — 20260605-003

## Raw Input (Translated)

> "Want to build an Extension that filters posts in Social Media feeds — or should I make it an APP or Widget instead?"

---

## Minori Classification

| Field | Value |
|---|---|
| Input Type | New product idea — platform undecided |
| Risk Level | Medium |
| Completeness | Incomplete — key decisions and constraints missing |
| Primary Route | `product_idea_debate` |

---

## Known Inputs

- Core concept: a tool that filters/curates posts in a social media feed
- Three delivery formats are in question: Browser Extension, Mobile/Desktop App, or Widget
- No target platform specified (which social network?)
- No filter logic specified (what is being filtered, and by what rule?)

---

## Missing Inputs (Clarification Needed)

1. **Target Social Platform(s)** — Twitter/X? Instagram? TikTok? Facebook? LinkedIn? All of the above?
2. **Filter Logic** — What does "filter" mean here? Hide posts by keyword? Hide ads? Curate by topic/interest? Block accounts by type?
3. **Target User** — Personal tool (for Rika-Chan only) or a product sold to other users?
4. **Monetization Intent** — Free tool, freemium, subscription SaaS, or one-time purchase?
5. **Platform Decision** — Extension vs App vs Widget is still open; debate must resolve this before PRD.

---

## Assumptions (Labeled — Proceed with Debate)

- A1: The product is meant for other users (B2C), not just personal use.
- A2: The primary target is a browser extension first (most common pattern for feed filtering).
- A3: Filter logic is keyword/topic-based or engagement-based, not ML-generated (until stated otherwise).
- A4: Initial scope targets 1–2 social platforms, not all platforms simultaneously.
- A5: No existing IP, partnerships, or technical constraints have been declared.

---

## Risk Flags

| Risk | Severity | Notes |
|---|---|---|
| Platform ToS violation | High | Twitter/X, Meta, TikTok all restrict DOM manipulation and feed scraping. Extension approach requires ToS review before any build. |
| API access restriction | Medium | Official feed APIs are heavily rate-limited or paywalled (e.g., Twitter API v2 costs $100+/mo). |
| Platform detection & ban | Medium | Extensions that modify feeds may be flagged or broken by platform updates. |
| Platform choice decision | Medium | App vs Extension vs Widget has very different tech stacks, distribution channels, and monetization models. Must be resolved before PRD. |

> Risk level is **Medium** → debate must include platform ToS and technical feasibility challenge.

---

## Workflow Plan

```yaml
workflow_plan:
  workflow_id: product_idea_debate
  goal: >
    Challenge the social media feed-filtering idea across platform choice (Extension vs App vs Widget),
    target platform feasibility (ToS, API access), filter logic, and business model.
    Produce a validated Product Opportunity Brief or a rejection with reasoning.
  known_inputs:
    - Core concept: feed filtering tool for social media
    - Three delivery formats in question: Extension / App / Widget
  missing_inputs:
    - Target social platform(s)
    - Filter logic definition
    - Target user profile (personal vs B2C)
    - Monetization model
    - Platform/format final decision
  assumptions:
    - A1: B2C product intent
    - A2: Browser extension as primary format hypothesis
    - A3: Keyword/topic-based filtering logic
    - A4: 1-2 platform initial scope
    - A5: No declared technical constraints
  risk_flags:
    - Platform ToS violation (High)
    - API access restrictions (Medium)
    - Platform detection/breakage risk (Medium)
    - Platform format decision unresolved (Medium)
  agent_sequence:
    - step: 1
      agent: Minori Lead Conductor
      input_artifact: workflow_plan_20260605_003.md
      output_artifact: workflow_plan_20260605_003.md (this file)
      context_budget: small
      stop_condition: Plan delivered; awaiting Rika-Chan approval
      approval_gate: true

    - step: 2
      agent: Yuki Idea Challenger
      input_artifact: workflow_plan_20260605_003.md
      output_artifact: idea_challenge_brief.md
      context_budget: small
      stop_condition: Riskiest assumptions mapped; platform choice challenged; ToS risk surfaced
      approval_gate: false

    - step: 3
      agent: Nova Evidence Scout
      input_artifact: idea_challenge_brief.md
      output_artifact: evidence_pack.md
      context_budget: small
      stop_condition: Source plan or evidence pack produced for top-priority questions
      approval_gate: false

    - step: 4
      agent: Vera Critical Verifier
      input_artifact: evidence_pack.md
      output_artifact: verification_report.md
      context_budget: small
      stop_condition: Claims classified as fact / assumption / opinion
      approval_gate: false

    - step: 5
      agent: Sora Strategy Sensei
      input_artifact: verification_report.md
      output_artifact: strategic_lens.md
      context_budget: small
      stop_condition: Moat and bet identified; kill/proceed recommendation made
      approval_gate: false

    - step: 6
      agent: Bumi Business Analyst
      input_artifact: strategic_lens.md
      output_artifact: business_analysis_brief.md
      context_budget: small
      stop_condition: WTP signal and business risk assessed
      approval_gate: false

    - step: 7
      agent: Poom Product Manager
      input_artifact: business_analysis_brief.md
      output_artifact: product_opportunity_brief.md
      context_budget: small
      stop_condition: Product Opportunity Brief complete
      approval_gate: true   # Rika-Chan must approve before PRD begins

    - step: 8
      agent: Gina Governance Guardian
      input_artifact: product_opportunity_brief.md
      output_artifact: governance_check.md
      context_budget: small
      stop_condition: Privacy / legal / ToS risks flagged or cleared
      approval_gate: false

    - step: 9
      agent: Kai Kaizen Coach
      input_artifact: governance_check.md
      output_artifact: kaizen_report.md
      context_budget: tiny
      stop_condition: Waste review complete
      approval_gate: false

  workflow_type: sequential_handoff
  context_budget: small
  approval_points:
    - After Step 1 (this plan) — Rika-Chan approves before /product-idea-debate starts
    - After Step 7 — Rika-Chan approves product_opportunity_brief.md before PRD begins
  stop_conditions:
    - strategic_lens.md recommends kill → halt at Step 5; Rika-Chan decides before Bumi runs
    - business_analysis_brief.md verdict is not_viable → halt at Step 6; Rika-Chan decides before Poom runs
    - governance_check.md verdict is block → halt at Step 8; Rika-Chan resolves before workflow closes
    - Platform ToS review reveals Extension approach is unviable → pivot or kill
    - Rika-Chan does not approve any gate → workflow halts at that step
```

---

## Clarification Questions for Rika-Chan (Max 3)

Before approving Step 2, Rika-Chan may optionally answer these to sharpen the debate:

1. **Which social platform(s) do you most want to target?** (e.g., Twitter/X, Instagram, TikTok, all of them)
2. **What does "filter" mean to you?** (e.g., hide ads, filter by keyword, curate by topic, limit doom-scrolling time, block certain account types)
3. **Is this for your own use, or a product for other users?**

> These are optional — the debate can proceed with A1–A5 assumptions if no answers are given.

---

## Minori Stop Declaration

Minori has completed the Input Gatekeeper step.
No specialist agent has been activated.
Workflow is **paused** pending Rika-Chan approval.

**Next action:** Rika-Chan approves this plan (with or without answering clarification questions) → Step 2 activates Yuki Idea Challenger via `/product-idea-debate`.
