---
template: workflow_plan
produced_by: Minori Lead Conductor
trigger: /idea-gate
version: "1.0"
---

# Workflow Plan

```yaml
handoff_id: ""
triggered_by: "/idea-gate"
created_by: Minori Lead Conductor
date: ""
status: AWAITING_RIKA_CHAN_APPROVAL_TO_PROCEED
context_budget: small

workflow_id: ""
# one of: idea_gate | product_idea_debate | evidence_crosscheck |
#         product_idea_to_prd | prd_to_codex_tasks | codex_build_loop |
#         qa_review | governance_check | memory_intake |
#         llm_wiki_update | kaizen_review

goal: ""

known_inputs: []
missing_inputs: []

assumptions:
  - label: A1
    text: ""
    risk: ""              # low / medium / high

risk_flags: []

runtime_tracking:
  runtime_mode: level_1_status_only
  run_id: ""
  status_log: logs/runtime_status.md
  agent_run_log_dir: logs/agent_runs/
  current_status: planned      # planned | running | awaiting_approval | blocked | complete | aborted
  current_agent: Minori Lead Conductor
  latest_artifact: ""
  next_step: ""

gate_scope_preclarification_required: false
expected_gates: []
# For Aki-bound/build-bearing routes, Minori must include Expected Gates + Pre-Decide vs Defer.
# If none are detected, use:
# expected_gates:
#   - gate: none_detected
#     reason: ""
gate_decisions:
  - gate: ""                 # auth | payments | database | infra | hosting | paid_api | deploy | privacy | security | legal
    risk_domain: ""          # strategic | financial | privacy | security | infra | legal
    pre_decide_or_defer: ""  # Pre-Decide | Defer
    owner_decision: ""       # required before Aki when Pre-Decide
    deferred_to: ""          # required when Defer
    stop_condition: ""       # what blocks Aki/Coda if unresolved

agent_sequence:
  - step: 1
    agent: ""
    input_artifact: ""
    output_artifact: ""
    context_budget: small
    stop_condition: ""
    approval_gate: false

has_ui_component: false
# if true → route Tessa (UX/UI inspector) after Kyuuei (QA) and before the Rika-Chan ship gate.
# Tessa is a conditional active agent; skipping requires a labeled reason here.

workflow_type: ""
# one of: skill | single_agent | sequential_handoff | agent_team | dynamic_workflow

context_budget: small
# escalate to medium/large/dynamic only with Rika-Chan approval

approval_points: []
stop_conditions: []
```

---

## Level 1 Runtime Tracking

`runtime_tracking` is a status-only layer. It records workflow visibility in
`logs/runtime_status.md` and must not spawn agents, schedule parallel work, or change routing.

When `/idea-gate` proceeds beyond pure classification, Minori records `run_id`, `current_status`,
`current_agent`, `latest_artifact`, and `next_step`. If no downstream handoff starts, keep the
status at `planned` or `awaiting_approval` and stop.

> Save to: `handoffs/workflow_plan_YYYYMMDD_NNN.md`
> Archive completed plans to: `handoffs/archive/`
