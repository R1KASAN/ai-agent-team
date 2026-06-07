---
template: workflow_plan
produced_by: Minori Lead Conductor
trigger: /idea-gate
version: "1.0"
date: "2026-06-05"
status: AWAITING_RIKA_CHAN_APPROVAL_TO_PROCEED
---

# Workflow Plan

```yaml
handoff_id: "wp-20260605-001"
triggered_by: "/idea-gate"
created_by: Minori Lead Conductor
date: "2026-06-05"
status: AWAITING_RIKA_CHAN_APPROVAL_TO_PROCEED

workflow_id: idea_gate
classified_workflow_name: product_idea_debate
# Input "I have an idea." is classified as product_idea_debate
# Reason: user has a product/project idea to challenge and validate

goal: >
  Classify the raw input "I have an idea." and produce a workflow plan
  before any agent receives delegation. No workflow proceeds without
  Rika-Chan approval of this plan.

known_inputs:
  - "Raw input: 'I have an idea.' — no further detail provided"

missing_inputs:
  - "What is the idea? (description of the product, service, or project)"
  - "Target user or market"
  - "Problem the idea solves"
  - "Any existing research, interviews, or context"
  - "Geographic or channel focus"

assumptions:
  - label: A1
    text: >
      Input implies a product or project idea that needs challenge and validation
      before any further workflow step.
    risk: low
  - label: A2
    text: >
      No prior artifacts exist for this idea — this is a fresh workflow start.
    risk: low

risk_flags:
  - "Input is too vague to determine product direction — Minori must ask for more detail before delegating to Yuki"
  - "No WTP signal, target user, or problem statement provided — missing inputs are high-risk if not resolved before product_idea_debate"

agent_sequence:
  - step: 1
    agent: Minori Lead Conductor
    input_artifact: "raw input: 'I have an idea.'"
    output_artifact: "handoffs/workflow_plan_20260605_001.md"
    context_budget: small
    stop_condition: "workflow plan produced → AWAITING_RIKA_CHAN_APPROVAL_TO_PROCEED"
    approval_gate: true

  - step: 2
    agent: Yuki Idea Challenger
    input_artifact: "handoffs/workflow_plan_20260605_001.md + clarified idea from Rika-Chan"
    output_artifact: "handoffs/idea_challenge_brief.md"
    context_budget: small
    stop_condition: "idea_challenge_brief.md produced → handoff to Nova"
    approval_gate: false
    note: "NOT STARTED — awaiting Rika-Chan approval and idea clarification"

  - step: 3
    agent: Nova Evidence Scout
    input_artifact: "handoffs/idea_challenge_brief.md"
    output_artifact: "handoffs/evidence_pack.md"
    context_budget: small
    stop_condition: "evidence_pack.md produced → handoff to Vera"
    approval_gate: false
    note: "NOT STARTED"

  - step: 4
    agent: Vera Critical Verifier
    input_artifact: "handoffs/evidence_pack.md"
    output_artifact: "handoffs/verification_report.md"
    context_budget: small
    stop_condition: "verification_report.md produced → handoff to Sora"
    approval_gate: false
    note: "NOT STARTED"

  - step: 5
    agent: Sora Strategy Sensei
    input_artifact: "handoffs/verification_report.md"
    output_artifact: "handoffs/strategic_lens.md"
    context_budget: small
    stop_condition: "strategic_lens.md produced → handoff to Bumi"
    approval_gate: false
    note: "NOT STARTED"

  - step: 6
    agent: Bumi Business Analyst
    input_artifact: "handoffs/strategic_lens.md"
    output_artifact: "handoffs/business_analysis_brief.md"
    context_budget: small
    stop_condition: "business_analysis_brief.md produced → handoff to Poom"
    approval_gate: false
    note: "NOT STARTED"

  - step: 7
    agent: Poom Product Manager
    input_artifact: "handoffs/business_analysis_brief.md"
    output_artifact: "handoffs/product_opportunity_brief.md"
    context_budget: medium
    stop_condition: "product_opportunity_brief.md produced → HARD STOP; PRD does not start without Rika-Chan approval"
    approval_gate: true
    note: "NOT STARTED"

  - step: 8
    agent: Gina Governance Guardian
    input_artifact: "handoffs/product_opportunity_brief.md"
    output_artifact: "handoffs/governance_check.md"
    context_budget: small
    stop_condition: "governance_check.md produced → handoff to Kai"
    approval_gate: false
    note: "NOT STARTED"

  - step: 9
    agent: Kai Kaizen Coach
    input_artifact: "artifact path list only"
    output_artifact: "handoffs/kaizen_report.md"
    context_budget: tiny
    stop_condition: "kaizen_report.md produced → cycle complete"
    approval_gate: false
    note: "NOT STARTED"

artifact_sequence:
  - "handoffs/workflow_plan_20260605_001.md"     # Step 1 — EXISTS
  - "handoffs/idea_challenge_brief.md"           # Step 2 — pending
  - "handoffs/evidence_pack.md"                  # Step 3 — pending
  - "handoffs/verification_report.md"            # Step 4 — pending
  - "handoffs/strategic_lens.md"                 # Step 5 — pending
  - "handoffs/business_analysis_brief.md"        # Step 6 — pending
  - "handoffs/product_opportunity_brief.md"      # Step 7 — pending (approval gate)
  - "handoffs/governance_check.md"               # Step 8 — pending
  - "handoffs/kaizen_report.md"                  # Step 9 — pending

workflow_type: sequential_handoff

context_budget: small
# Steps 1–6 and 8–9: small
# Step 7 (Poom): medium — full artifact chain required

approval_points:
  - "Step 1 exit → Rika-Chan approves this workflow plan before product_idea_debate starts"
  - "Step 7 exit → Rika-Chan approves product_opportunity_brief.md before PRD is written"
  - "Step 8 conditional → Gina issues approval_request.md if privacy or legal flags found"

stop_conditions:
  - "Step 1 (this plan): AWAITING_RIKA_CHAN_APPROVAL_TO_PROCEED — no agent proceeds until approved"
  - "Step 7 (Poom hard stop): product_opportunity_brief.md produced; PRD not started"
  - "Any step: Jidoka stop if input artifact is absent or incomplete"
  - "Any step: Mira hard stop if sensitive data enters evidence without privacy_level tag"
  - "Step 8: Gina blocked verdict halts workflow; approval_request.md issued to Rika-Chan"

minori_note: >
  Input 'I have an idea.' is too vague to delegate to Yuki immediately.
  Before Step 2 can start, Rika-Chan must (1) approve this plan and
  (2) provide the actual idea description so Yuki has a real input artifact.
```

---

> Status: **AWAITING_RIKA_CHAN_APPROVAL_TO_PROCEED**
> Next action: Rika-Chan reviews this plan, approves, and provides the idea description before Step 2 (Yuki) starts.
> Archive this file to `handoffs/archive/` when the workflow cycle is complete.
