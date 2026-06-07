---
template: workflow_plan
produced_by: Minori Lead Conductor
trigger: /idea-gate
version: "1.0"
date: "2026-06-05"
status: AWAITING_RIKA_CHAN_APPROVAL_TO_PROCEED
---

# Workflow Plan — wp-20260605-002

```yaml
handoff_id: "wp-20260605-002"
triggered_by: "/idea-gate"
created_by: Minori Lead Conductor
date: "2026-06-05"
status: AWAITING_RIKA_CHAN_APPROVAL_TO_PROCEED

workflow_id: product_idea_debate
classified_workflow_name: product_idea_debate
# Classification reason:
#   Input is a concrete product idea with target user, problem, workaround,
#   platform, expected output, market, and known risks — sufficient to
#   begin challenge, assumption mapping, and evidence validation.

goal: >
  Challenge and validate the idea of an AI assistant that turns scattered
  client feedback (LINE, Messenger, screenshots, notes, calls) into one
  prioritized next action and a client update draft — targeted at Thai
  freelancers and solo digital workers.
  Produce a validated product_opportunity_brief.md ready for Rika-Chan
  approval before any PRD or build work begins.

known_inputs:
  - "Idea: AI assistant that turns scattered client feedback into clear next actions"
  - "Target user: Thai freelancers / solo digital workers"
  - "Problem: Feedback is scattered across LINE, screenshots, notes, and calls"
  - "Current workaround: Manually reread messages and make task lists"
  - "Platform/channel: LINE, Messenger, Google Drive, Notion"
  - "Expected output: One prioritized next action + client update draft"
  - "Market/context: Freelancers increasingly use AI but still manage work manually"
  - "Known constraints or risks: Privacy, platform API limits, willingness to pay"

missing_inputs:
  - "Primary freelancer segment: designer / developer / content creator / other?"
  - "Core pain: time lost parsing feedback, or risk of missing something important?"
  - "Monetization hypothesis: subscription, freemium, per-use, or unknown?"
  - "Input method preference: manual paste / upload, or automated ingestion (if technically feasible)?"
  - "Geographic scope: Thailand only, SE Asia, or global?"
  - "Willingness-to-pay proxy: any prior tool spend or interview data?"

assumptions:
  - label: A1
    text: >
      LINE is the dominant channel for client feedback among Thai freelancers;
      Messenger and other channels are secondary.
    risk: low

  - label: A2
    text: >
      LINE has no open API for reading personal or group chat history —
      input will require manual copy-paste or screenshot upload.
    risk: high
    note: "Confirmed from wp-001 research; needs Nova to verify officially"

  - label: A3
    text: >
      Pain is frequent and severe enough that freelancers would pay a
      dedicated subscription rather than use ChatGPT with a custom prompt.
    risk: high

  - label: A4
    text: >
      AI can reliably extract ONE unambiguous next action from informal,
      emoji-heavy, multilingual (Thai + English) feedback.
    risk: high

  - label: A5
    text: >
      "One prioritized next action + client update draft" is the output
      format that freelancers actually want — not a full task list or summary.
    risk: medium

  - label: A6
    text: >
      Client messages uploaded to a third-party AI tool do not create
      unacceptable privacy or legal risk for the freelancer or their clients.
    risk: high

risk_flags:
  - "LINE API / input method: no open API for reading chats — manual input is likely the only path; this shifts the value proposition significantly"
  - "Privacy: client messages contain sensitive business information; Gina must review before any feature is built that stores or processes them"
  - "WTP vs ChatGPT substitute: Thai freelancers already use ChatGPT; differentiation must be proven before pricing is set"
  - "AI accuracy: informal Thai + English code-switching feedback is a hard NLP problem; accuracy risk affects core product promise"
  - "Platform ToS: integrating with LINE, Messenger, Google Drive, or Notion may have ToS or API constraints beyond LINE alone"

agent_sequence:
  - step: 1
    agent: Minori Lead Conductor
    input_artifact: "raw idea (8-field form from Rika-Chan)"
    output_artifact: "handoffs/workflow_plan_20260605_002.md"
    context_budget: small
    stop_condition: "workflow plan produced → AWAITING_RIKA_CHAN_APPROVAL_TO_PROCEED"
    approval_gate: true

  - step: 2
    agent: Yuki Idea Challenger
    input_artifact: "handoffs/workflow_plan_20260605_002.md"
    output_artifact: "handoffs/idea_challenge_brief.md"
    context_budget: small
    stop_condition: "idea_challenge_brief.md + evidence_questions_for_nova.md + top_riskiest_assumptions.md produced"
    approval_gate: false
    note: "NOT STARTED — awaiting Rika-Chan approval of this plan"

  - step: 3
    agent: Nova Evidence Scout
    input_artifact: "handoffs/idea_challenge_brief.md + handoffs/evidence_questions_for_nova.md"
    output_artifact: "handoffs/source_candidate_list.md + handoffs/evidence_pack.md"
    context_budget: small
    stop_condition: "evidence_pack.md produced → handoff to Vera"
    approval_gate: false
    note: >
      Nova must stop and request approval if source batch >10 or
      domain touches privacy / legal / platform ToS.
      NOT STARTED.

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
    stop_condition: >
      product_opportunity_brief.md produced →
      HARD STOP; PRD does not start without Rika-Chan approval
    approval_gate: true
    note: "NOT STARTED"

  - step: 8
    agent: Gina Governance Guardian
    input_artifact: "handoffs/product_opportunity_brief.md"
    output_artifact: "handoffs/governance_check.md"
    context_budget: small
    stop_condition: >
      governance_check.md produced (or approval_request.md if
      privacy / LINE API / platform ToS flags require it) → handoff to Kai
    approval_gate: false
    note: "NOT STARTED — expected to flag privacy and platform API risks"

  - step: 9
    agent: Kai Kaizen Coach
    input_artifact: "artifact path list only"
    output_artifact: "handoffs/kaizen_report.md"
    context_budget: tiny
    stop_condition: "kaizen_report.md produced → cycle complete"
    approval_gate: false
    note: "NOT STARTED"

artifact_sequence:
  - "handoffs/workflow_plan_20260605_002.md"     # Step 1 — EXISTS ✅
  - "handoffs/idea_challenge_brief.md"           # Step 2 — pending
  - "handoffs/evidence_questions_for_nova.md"    # Step 2 — pending
  - "handoffs/top_riskiest_assumptions.md"       # Step 2 — pending
  - "handoffs/source_candidate_list.md"          # Step 3 — pending
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
# Step 7 (Poom): medium — full artifact chain required for opportunity brief

approval_points:
  - "Step 1 exit → Rika-Chan approves this workflow plan before product_idea_debate starts"
  - "Step 7 exit → Rika-Chan approves product_opportunity_brief.md before PRD is written"
  - "Step 8 conditional → Gina issues approval_request.md if privacy, LINE API, or platform ToS flags require it"
  - "Nova conditional → approval required if source batch >10 or high-stakes domain detected"

stop_conditions:
  - "Step 1 (this plan): AWAITING_RIKA_CHAN_APPROVAL_TO_PROCEED — no agent proceeds until approved"
  - "Step 7 (Poom hard stop): product_opportunity_brief.md produced; PRD not started without Rika-Chan approval"
  - "Any step: Jidoka stop if required input artifact is absent or incomplete"
  - "Any step: Mira/Gina hard stop if client message content enters evidence with restricted privacy_level"
  - "Nova step 3: stop if source batch >10 or domain is privacy/legal/security/platform ToS"
  - "Step 8: Gina blocked verdict halts workflow; approval_request.md issued to Rika-Chan"
```

---

> Status: **AWAITING_RIKA_CHAN_APPROVAL_TO_PROCEED**
> Next action: Rika-Chan reviews and approves this plan to begin Step 2 (Yuki Idea Challenger).
> First agent to run after approval: **Yuki Idea Challenger**
> Archive this file to `handoffs/archive/` when the workflow cycle is complete.
