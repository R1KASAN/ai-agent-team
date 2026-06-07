---
workflow_plan_id: workflow_plan_20260607_001
created_by: Minori Lead Conductor [Mi]
created_at: 2026-06-07
raw_input: "อยากทำแอพนับแคลอรี่"
prior_related_plan: none
status: classified — sequential_handoff (no approval gate required to start)
test_context: "Phase 1 proof run — Test 1 (Dispatcher classify test), per Rika-Chan e2e verification request 2026-06-07"
---

# Workflow Plan — 20260607-001

## Raw Input (Thai)

> "อยากทำแอพนับแคลอรี่"

**Translation:** "I want to make a calorie-counting app."

---

## Minori Classification

| Field | Value |
|---|---|
| Job | `idea-debate` — a product/project idea to validate |
| Weight | `medium` — ONE clear idea, no evidence-cross-check or adversarial-debate signal yet |
| Risk Level | Low–Medium (consumer health/wellness app — no legal/payment/strategic flag at intake) |
| Completeness | Incomplete — single-line idea, target user / platform / differentiation unspecified |
| Primary Route | `product_idea_debate` (the `/idea` pipeline: Yu→NV→So→Bu→Po) |
| Execution Mode | `sequential_handoff` |
| Recommended Workflow | n/a (sequential — `dynamic_workflow` not applicable at this weight) |

**Weight reasoning:** "Calorie counting app" is a single, well-scoped idea statement — it does not
itself signal a need for cross-checked evidence + adversarial debate (`heavy`) or a pivot/kill/
portfolio decision (`strategic`). Per the lower-weight tie-break rule, `medium` (cheapest mode that
honestly fits) is selected over `heavy`. Escalation to `heavy` would need a written reason (e.g.
owner flags this as a multi-market bet) — none present.

---

## Known Inputs

- Core idea: a calorie-counting application
- Format: mobile app implied by "แอพ" (app)

## Missing Inputs (Clarification Needed)

1. Target platform (iOS / Android / cross-platform / web)?
2. Target user (general consumers, athletes, people with medical needs, personal tool only)?
3. Differentiation vs. MyFitnessPal / Lose It! / Cronometer / Yazio (crowded category)?

## Assumptions (Labeled — Pending Debate)

- A1: B2C consumer health app intent (not a personal-only tool)
- A2: Mobile-first delivery
- A3: No declared medical/regulatory positioning (would raise risk to High if claimed as a medical device)

## Risk Flags

| Risk | Severity | Notes |
|---|---|---|
| Crowded category | High | MyFitnessPal, Lose It!, Cronometer, Yazio dominate; differentiation is the key debate target |
| Health-data privacy | Medium | Diet/health logs are sensitive personal data — privacy model must be probed early in debate |
| Scope creep into medical claims | Low (flag only) | If framed as medical/diagnostic, route would escalate to `governance` job + Rika privacy/legal gate |

---

## Workflow Plan (Orchestrator Contract — 8 fields)

```yaml
workflow_plan:
  workflow_id: product_idea_debate
  job: idea-debate
  weight: medium
  goal: >
    Validate the "calorie-counting app" idea: differentiation vs. the crowded
    MyFitnessPal/Lose It!/Cronometer/Yazio category, target user and WTP signal,
    health-data privacy model, and platform choice. Produce a Product Opportunity
    Brief or a kill with reasoning.
  known_inputs:
    - Core idea: calorie-counting app
    - Format: mobile app (implied)
  missing_inputs:
    - Target platform
    - Target user / persona
    - Differentiation angle vs. incumbents
  assumptions:
    - A1: B2C consumer health app
    - A2: Mobile-first
    - A3: No medical/regulatory claim declared
  risk_flags:
    - Crowded category (High)
    - Health-data privacy (Medium)
    - Medical-claim scope creep (Low — flag only, would re-route to governance if confirmed)
  agent_sequence:
    - step: 1
      agent: Minori Lead Conductor [Mi]
      input_artifact: raw_input
      output_artifact: workflow_plan_20260607_001.md (this file)
      context_budget: small
      stop_condition: Plan + classification produced; no downstream agent activated
      approval_gate: false
    - step: 2
      agent: Yuki Idea Challenger [Yu]
      input_artifact: workflow_plan_20260607_001.md
      output_artifact: idea_challenge_brief_20260607_001.md
      context_budget: small
      stop_condition: >
        Riskiest assumptions mapped; differentiation vs. MyFitnessPal/Cronometer
        challenged; health-data privacy model probed
      approval_gate: false
    - step: 3
      agent: Nova-V Evidence Verifier [NV]
      input_artifact: idea_challenge_brief_20260607_001.md
      output_artifact: evidence_pack_20260607_001.md
      context_budget: small
      stop_condition: Market/competitor evidence verified (internal loop ≤2)
      approval_gate: false
    - step: 4
      agent: Sora Strategy Sensei [So]
      input_artifact: evidence_pack_20260607_001.md
      output_artifact: strategic_lens_20260607_001.md
      context_budget: small
      stop_condition: Moat + 3-5yr bet + kill/proceed verdict produced
      approval_gate: false
    - step: 5
      agent: Bumi Business Analyst [Bu]
      input_artifact: strategic_lens_20260607_001.md
      output_artifact: business_analysis_brief_20260607_001.md
      context_budget: small
      stop_condition: WTP + viability verdict produced
      approval_gate: false
    - step: 6
      agent: Poom Product Manager [Po]
      input_artifact: business_analysis_brief_20260607_001.md
      output_artifact: product_opportunity_brief_20260607_001.md
      context_budget: small
      stop_condition: Product Opportunity Brief complete
      approval_gate: true   # Rika-Chan POB gate before any PRD/build
  execution_mode: sequential_handoff
  recommended_workflow: ""
  context_budget: small
  approval_points:
    - After Step 6 — Rika-Chan approves product_opportunity_brief before PRD begins
  stop_conditions:
    - strategic_lens recommends kill → halt before Bumi runs; Rika-Chan decides
    - business_analysis verdict is not_viable → halt before Poom runs; Rika-Chan decides
    - Idea reframes as a medical/diagnostic claim → re-route to `governance` job + Rika privacy/legal gate
  proactive_recall: false   # weight=medium; recall reserved for heavy/strategic
```

---

## Minori Stop Declaration

`[Mi]` Minori has completed the Input Gatekeeper + dispatcher classification step.
**Job = `idea-debate`, Weight = `medium`, execution_mode = `sequential_handoff`.**
No specialist agent has been activated. Workflow is **paused** — this is a classification-only
proof run (Phase 1 Test 1); no downstream pipeline is started automatically per dispatcher contract.

**If this were a live request:** next action would be Rika-Chan reviewing this classification (no
approval gate required to *start* a `medium`/`sequential_handoff` route — gate applies at Step 6,
the Product Opportunity Brief).
