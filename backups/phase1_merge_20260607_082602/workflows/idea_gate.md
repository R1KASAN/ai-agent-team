---
workflow_id: idea_gate
slash_command: /idea-gate
entry_agent: Minori Lead Conductor
context_budget: small
output_artifact: workflow_plan.md
version: "1.0"
---

# Workflow: idea_gate

## Purpose

Prevent wrong input from causing wrong workflow execution. Every workflow must begin here.

## Flow

```
Rika-Chan input
→ Minori: classify input
→ Minori: check completeness and risk
→ Minori: produce Workflow Plan
→ Rika-Chan review (if high-risk or incomplete)
→ Route to selected workflow
```

---

## Input Classification

Minori must classify every request into exactly one of:

| Workflow ID | Use When |
|-------------|---------|
| `idea_gate` | New input; needs classification |
| `product_idea_debate` | Rika-Chan has a product/project idea to challenge |
| `evidence_crosscheck` | Research question needs verified sources |
| `product_idea_to_prd` | Approved Product Opportunity Brief → PRD |
| `prd_to_codex_tasks` | Approved PRD → Codex task packet |
| `codex_build_loop` | Codex task packet ready for implementation |
| `qa_review` | Build complete; needs UX/product-flow review |
| `governance_check` | Decision needs privacy/legal/security review |
| `memory_intake` | Raw knowledge needs to be structured |
| `llm_wiki_update` | Workflow lesson should become a rule or skill |
| `kaizen_review` | Session needs token/context waste review |

---

## Completeness Check

**Low risk + incomplete input:** Minori may proceed with clearly labeled assumptions.

**High risk + incomplete input:** Minori must ask at most 3 clarification questions or request Rika-Chan approval before proceeding.

**Input conflicts with operating rules:** Minori must follow operating rules and explain the safe adjusted workflow.

---

## Orchestrator Contract

Before delegating, Minori must define all fields below in `workflow_plan.md`:

```yaml
workflow_plan:
  workflow_id: ""
  goal: ""
  known_inputs: []
  missing_inputs: []
  assumptions: []
  risk_flags: []
  agent_sequence:
    - step: 1
      agent: ""
      input_artifact: ""
      output_artifact: ""
      context_budget: small
      stop_condition: ""
      approval_gate: false
  workflow_type: ""   # skill | single_agent | sequential_handoff | agent_team | dynamic_workflow
  context_budget: small
  approval_points: []
  stop_conditions: []
```

---

## Stop Conditions

- Stop if required input artifact is missing → generate artifact first
- Stop if risk level is high and Rika-Chan has not approved → request approval
- Stop if input conflicts with operating rules → explain adjusted workflow
- Stop if context budget would require `large` or `dynamic` without approval

---

## Output

`workflow_plan_YYYYMMDD_NNN.md` — saved to `handoffs/` only
NNN increments per day (001 = first plan of that day, 002 = second, etc.)

---

## What This Workflow Tests (First Run)

On first use, this workflow validates:

- Input classification logic
- Workflow Plan generation
- Artifact sequence
- Context budget assignment
- Approval gate identification
- Stop condition recognition
