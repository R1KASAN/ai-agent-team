---
workflow_plan_id: workflow_plan_20260606_001
created_by: Minori Lead Conductor
created_at: 2026-06-06
raw_input: "Feed-filtering tool for social media to reduce information overload and help users focus only on important posts."
prior_related_plan: workflow_plan_20260605_003.md
status: awaiting_rika_approval
---

# Workflow Plan — 20260606-001

## Raw Input

> "Feed-filtering tool for social media to reduce information overload and help users focus only on important posts."

---

## Continuity Note

This is a re-entry of the same core idea submitted on 2026-06-05 in Thai (plan `workflow_plan_20260605_003.md`). The English restatement clarifies intent — *information overload reduction / focus on important posts* — but does not resolve the missing inputs from the prior plan. Both plans are valid and may be merged or superseded by Rika-Chan's direction.

---

## Minori Classification

| Field | Value |
|---|---|
| Input Type | New product idea — delivery format, platform, logic, and user all unspecified |
| Risk Level | Medium |
| Completeness | Incomplete — 5 key decisions and constraints missing |
| Primary Route | `product_idea_debate` |

---

## Known Inputs

- Core concept: a tool that filters / surfaces important posts in a social media feed
- Problem statement: information overload; user wants to see only what matters
- No target platform specified (which social network?)
- No filter logic specified (what makes a post "important"?)
- No delivery format specified (extension, app, widget, in-feed algorithm?)
- No target user specified (personal tool vs. B2C product)
- No monetization model specified

---

## Missing Inputs (Clarification Needed)

1. **Target Social Platform(s)** — Twitter/X? Instagram? TikTok? Facebook? LinkedIn? All?
2. **Filter Logic / "Important" Definition** — engagement-based? keyword/topic? interest graph? ML-scored? time-sensitive? user-defined rules?
3. **Delivery Format** — browser extension, mobile app, web app, widget, or API layer?
4. **Target User** — personal tool for Rika-Chan only, or a B2C/B2B product?
5. **Monetization Model** — free, freemium, subscription SaaS, one-time purchase, or no monetization?

---

## Assumptions (Labeled — Pending Debate)

- A1: The product is B2C (built for other users, not personal use only).
- A2: Browser extension is the most likely primary delivery format — easiest distribution for feed manipulation.
- A3: "Important" means some combination of engagement signals + user-defined keywords/topics, not full ML.
- A4: Initial scope targets 1–2 social platforms, not all simultaneously.
- A5: No existing IP, partnerships, prior code, or legal constraints have been declared.

---

## Risk Flags

| Risk | Severity | Notes |
|---|---|---|
| Platform ToS violation | High | Twitter/X, Meta, TikTok all restrict DOM manipulation and feed scraping. Any extension or app that modifies feed rendering needs ToS review before build. |
| API access restrictions | Medium | Official feed APIs are heavily rate-limited or paywalled (Twitter API v2 basic tier $100+/mo; Meta deprecated many feed APIs). |
| Platform detection / breakage | Medium | Extensions that modify feeds may be broken by platform UI updates or actively flagged by platform anti-bot systems. |
| "Importance" definition complexity | Medium | Without a clear signal for "important," the filter logic is the product — and it may be highly subjective or require ML infrastructure beyond MVP scope. |
| Delivery format unresolved | Medium | Extension vs. App vs. API layer have radically different tech stacks, distribution costs, and ToS risk profiles. Must be resolved before PRD. |

> Risk level: **Medium** overall. Platform ToS is the single highest-severity blocker and must be challenged early in debate.

---

## Workflow Plan

```yaml
workflow_plan:
  workflow_id: product_idea_debate
  goal: >
    Challenge the social media feed-filtering idea across platform choice,
    filter logic definition ("important"), delivery format, target user,
    and monetization model. Surface ToS and API feasibility risks early.
    Produce a validated Product Opportunity Brief or a rejection with reasoning.
  known_inputs:
    - Core concept: feed-filtering tool for social media
    - Problem: information overload; focus on important posts
  missing_inputs:
    - Target social platform(s)
    - Filter logic / definition of "important"
    - Delivery format (extension / app / widget / API)
    - Target user (personal vs. B2C)
    - Monetization model
  assumptions:
    - A1: B2C product intent
    - A2: Browser extension as primary format hypothesis
    - A3: Engagement + keyword-based importance signal
    - A4: 1-2 platform initial scope
    - A5: No declared technical or legal constraints
  risk_flags:
    - Platform ToS violation (High)
    - API access restrictions (Medium)
    - Platform detection / breakage risk (Medium)
    - "Importance" definition complexity (Medium)
    - Delivery format unresolved (Medium)
  agent_sequence:
    - step: 1
      agent: Minori Lead Conductor
      input_artifact: raw_input
      output_artifact: workflow_plan_20260606_001.md (this file)
      context_budget: small
      stop_condition: Plan delivered; awaiting Rika-Chan approval
      approval_gate: true

    - step: 2
      agent: Yuki Idea Challenger
      input_artifact: workflow_plan_20260606_001.md
      output_artifact: idea_challenge_brief.md
      context_budget: small
      stop_condition: Riskiest assumptions mapped; ToS risk and "importance" definition challenged; platform choice pressure-tested
      approval_gate: false

    - step: 3
      agent: Nova Evidence Scout
      input_artifact: idea_challenge_brief.md
      output_artifact: evidence_pack.md
      context_budget: small
      stop_condition: Source plan or evidence pack produced for top-priority questions (market size, competitor landscape, ToS precedent, API availability)
      approval_gate: false

    - step: 4
      agent: Vera Critical Verifier
      input_artifact: evidence_pack.md
      output_artifact: verification_report.md
      context_budget: small
      stop_condition: Evidence claims classified as fact / assumption / opinion; confidence scored
      approval_gate: false

    - step: 5
      agent: Sora Strategy Sensei
      input_artifact: verification_report.md
      output_artifact: strategic_lens.md
      context_budget: small
      stop_condition: Competitive moat and strategic bet identified; kill/proceed recommendation made
      approval_gate: false

    - step: 6
      agent: Bumi Business Analyst
      input_artifact: strategic_lens.md
      output_artifact: business_analysis_brief.md
      context_budget: small
      stop_condition: Willingness-to-pay signal assessed; business risk scored; monetization path ranked
      approval_gate: false

    - step: 7
      agent: Poom Product Manager
      input_artifact: business_analysis_brief.md
      output_artifact: product_opportunity_brief.md
      context_budget: small
      stop_condition: Product Opportunity Brief complete with recommended format, platform, and MVP scope
      approval_gate: true   # Rika-Chan must approve before PRD begins

    - step: 8
      agent: Gina Governance Guardian
      input_artifact: product_opportunity_brief.md
      output_artifact: governance_check.md
      context_budget: small
      stop_condition: Privacy / legal / ToS risks flagged or cleared; PDPA/GDPR implications noted
      approval_gate: false

    - step: 9
      agent: Kai Kaizen Coach
      input_artifact: governance_check.md
      output_artifact: kaizen_report.md
      context_budget: tiny
      stop_condition: Waste review complete; workflow improvement notes captured
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
    - Platform ToS review reveals Extension approach is unviable for all target platforms → pivot or kill
    - Rika-Chan does not approve any gate → workflow halts at that step
```

---

## Clarification Questions for Rika-Chan (Optional — Max 3)

Answering these before approving Step 2 will sharpen the debate. They are not required — the debate can proceed with A1–A5 assumptions if no answers are given.

1. **Which social platform(s) do you most want to target?**
   (e.g., Twitter/X, Instagram, TikTok, Facebook, LinkedIn — or "figure it out in debate")

2. **What does "important" mean to you?**
   (e.g., posts from specific people, posts with high engagement, posts matching my interests, posts NOT from brands/ads, time-sensitive news — or "challenge my definition in debate")

3. **Is this for your personal use only, or a product for other users?**

> These are optional. Unanswered questions become debate inputs for Yuki.

---

## Relation to Prior Plan

`workflow_plan_20260605_003.md` covers the same idea (Thai input, 2026-06-05). Both plans are structurally identical. Rika-Chan may:
- **Supersede** 20260605-003 with this plan (English restatement is the active version)
- **Merge** by answering clarification questions once for both
- **Keep both** and run separate debate cycles

---

## Minori Stop Declaration

Minori has completed the Input Gatekeeper step.
No specialist agent has been activated.
Workflow is **paused** pending Rika-Chan approval.

**Next action:** Rika-Chan approves this plan (with or without answering clarification questions) → Step 2 activates Yuki Idea Challenger via `/product-idea-debate`.
