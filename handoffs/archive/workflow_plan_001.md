---
template: workflow_plan
produced_by: Minori Lead Conductor
trigger: /idea-gate
version: "1.0"
---

# Workflow Plan

```yaml
handoff_id: "wp-001"
triggered_by: "/idea-gate"
created_by: Minori Lead Conductor
date: "2026-06-05"
status: AWAITING_RIKA_CHAN_APPROVAL

workflow_id: product_idea_debate
# classification: product_idea → product_idea_debate workflow

goal: >
  Evaluate the idea of an AI assistant that helps freelancers turn messy
  client feedback (LINE chats, screenshots, notes, scattered files) into
  one clear next action, a client update message, and a task checklist.
  Produce a validated product_opportunity_brief.md ready for Rika-Chan
  approval before any PRD work begins.

known_inputs:
  - "Problem: freelancers receive fragmented client feedback across multiple
    channels (LINE chats, screenshots, notes, files)"
  - "Desired outputs: one next action + client update message + task checklist"
  - "Solution direction: AI assistant"
  - "Channel signal: LINE mentioned — likely Thai or SE Asian market context"

missing_inputs:
  - "Target freelancer segment: designer / developer / consultant / creative?"
  - "Primary pain: time lost parsing feedback, or miscommunication with clients?"
  - "Current workaround: manual copy-paste, Notion, another tool?"
  - "Geographic focus: Thailand only, SE Asia, or global?"
  - "Monetization hypothesis: subscription, freemium, per-use?"
  - "Willingness-to-pay signal: any existing proxy product or interview data?"

assumptions:
  - label: A1
    text: "Freelancers using LINE for client communication is the primary workflow
          (strong in Thailand; less dominant globally)"
    risk: medium
  - label: A2
    text: "The pain is frequent and severe enough that freelancers would pay
          for a dedicated tool rather than adapting an existing one"
    risk: high
  - label: A3
    text: "AI can reliably extract actionable structure from noisy chat and
          image input with acceptable accuracy"
    risk: high
  - label: A4
    text: "'One clear next action' is a valuable simplification, not
          an oversimplification that frustrates complex projects"
    risk: medium
  - label: A5
    text: "The output format (next action + update message + checklist)
          matches how freelancers actually communicate with clients"
    risk: medium

risk_flags:
  - "LINE API: data extraction from LINE chats may require special API access
    or user-initiated export; ToS implications unknown — flag for Gina"
  - "Privacy: client messages likely contain sensitive business information;
    Mira must apply privacy_level before any content enters evidence"
  - "Market size: Thai freelancer + LINE overlap is a niche — WTP signal
    and addressable market need validation before PRD"
  - "OCR/multimodal accuracy: screenshot parsing accuracy is a technical risk
    that affects core product promise"

agent_sequence:
  - step: 1
    agent: Minori Lead Conductor
    input_artifact: "raw idea (this document)"
    output_artifact: "workflow_plan_001.md"
    context_budget: small
    stop_condition: "workflow_plan_001.md produced → AWAITING_RIKA_CHAN_APPROVAL"
    approval_gate: true

  - step: 2
    agent: Yuki Idea Challenger
    input_artifact: "workflow_plan_001.md"
    output_artifact: "idea_challenge_brief.md"
    context_budget: small
    stop_condition: "idea_challenge_brief.md produced → handoff to Nova"
    approval_gate: false

  - step: 3
    agent: Nova Evidence Scout
    input_artifact: "idea_challenge_brief.md"
    output_artifact: "evidence_pack.md"
    context_budget: small
    stop_condition: "evidence_pack.md produced → handoff to Vera"
    approval_gate: false

  - step: 4
    agent: Vera Critical Verifier
    input_artifact: "evidence_pack.md"
    output_artifact: "verification_report.md"
    context_budget: small
    stop_condition: "verification_report.md produced → handoff to Sora"
    approval_gate: false

  - step: 5
    agent: Sora Strategy Sensei
    input_artifact: "verification_report.md"
    output_artifact: "strategic_lens.md"
    context_budget: small
    stop_condition: "strategic_lens.md produced → handoff to Bumi"
    approval_gate: false

  - step: 6
    agent: Bumi Business Analyst
    input_artifact: "strategic_lens.md"
    output_artifact: "business_analysis_brief.md"
    context_budget: small
    stop_condition: "business_analysis_brief.md produced (must include WTP signal)
                    → handoff to Poom"
    approval_gate: false

  - step: 7
    agent: Poom Product Manager
    input_artifact: "business_analysis_brief.md"
    output_artifact: "product_opportunity_brief.md"
    context_budget: medium
    stop_condition: "product_opportunity_brief.md produced → HARD STOP;
                    PRD work does not begin without Rika-Chan approval"
    approval_gate: true

  - step: 8
    agent: Gina Governance Guardian
    input_artifact: "product_opportunity_brief.md"
    output_artifact: "governance_check.md"
    context_budget: small
    stop_condition: "governance_check.md produced (or approval_request.md if
                    LINE API / privacy flags require it) → handoff to Kai"
    approval_gate: false

  - step: 9
    agent: Kai Kaizen Coach
    input_artifact: "artifact list (paths only)"
    output_artifact: "kaizen_report.md"
    context_budget: tiny
    stop_condition: "kaizen_report.md produced → cycle complete"
    approval_gate: false

workflow_type: sequential_handoff

context_budget: small
# Steps 1–6 and 8–9: small
# Step 7 (Poom): medium — full artifact chain required for opportunity brief

approval_points:
  - "Step 1 exit → Rika-Chan approves workflow_plan_001.md before product_idea_debate starts"
  - "Step 7 exit → Rika-Chan approves product_opportunity_brief.md before PRD is written"
  - "Step 8 conditional → Gina issues approval_request.md if LINE API or privacy flags are found"

stop_conditions:
  - "This plan (Step 1): AWAITING_RIKA_CHAN_APPROVAL — no agent proceeds until approved"
  - "Step 7 (Poom hard stop): product_opportunity_brief.md produced; PRD not started"
  - "Any step: Jidoka stop if input artifact is absent or incomplete"
  - "Any step: Mira hard stop if client message content enters evidence with restricted privacy_level"
  - "Step 8: Gina blocked verdict halts workflow; approval_request.md issued to Rika-Chan"
```

---

> Status: **AWAITING_RIKA_CHAN_APPROVAL**
> Next action: Rika-Chan reviews this plan and signals approval to begin Step 2 (Yuki).
> Archive this file to `handoffs/archive/` when the workflow cycle is complete.
