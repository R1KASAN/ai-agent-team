---
workflow_id: idea_gate
slash_command: /idea-gate
entry_agent: Minori Lead Conductor
context_budget: small
output_artifact: workflow_plan.md
version: "2.0"
changelog: "v2.0 — universal size-aware dispatcher: adds job + weight classification and execution_mode routing; dynamic route halts for Rika approval."
ref: context.md · llm_wiki/dynamic_workflow_policy.md · .claude/workflows/idea-stresstest.js
---

# Workflow: idea_gate (v2 — universal dispatcher)

## Purpose

Prevent wrong input from causing wrong (or wrongly-sized) workflow execution. Every workflow begins
here. v2 adds **size awareness**: pick the cheapest execution_mode that fits, and reserve the
expensive Dynamic Workflow for heavy/strategic work behind a Rika gate.

## Flow

```
Rika-Chan input (anything)
→ Minori: classify JOB (recall/next/scout/memory/research/idea-debate/build/governance)
→ Minori: classify WEIGHT (tiny/small/medium/heavy/strategic)
→ Minori: pick execution_mode (single_agent | sequential_handoff | dynamic_workflow)
→ Minori: produce workflow_plan.md (8-field Orchestrator Contract + weight + execution_mode + runtime_tracking)
→ if route proceeds beyond pure classification → write/update logs/runtime_status.md (Level 1 Runtime)
→ if execution_mode = dynamic_workflow OR route is high-risk → approval_request.md + STOP for Rika
→ else → route to first agent
```

---

## Job Classification

Exactly one of: `recall · next · scout · memory · research · idea-debate · build · governance`
(see job table in `.claude/commands/idea-gate.md`). These map to the existing workflow IDs:
`product_idea_debate · evidence_crosscheck · product_idea_to_prd · prd_to_codex_tasks ·
codex_build_loop · qa_review · governance_check · memory_intake`.

## Weight Classification

Exactly one of: `tiny · small · medium · heavy · strategic`.

| Weight | execution_mode | Notes |
|--------|----------------|-------|
| tiny | single_agent | one agent, knowledge/ read only |
| small | single_agent / sequential_handoff | Mira writes + graph_update on save |
| medium | sequential_handoff | current `/idea` pipeline; notebooklm-py only if a deep source exists |
| heavy | dynamic_workflow | `idea-stresstest.js`; Rika dynamic gate |
| strategic | dynamic_workflow | + extra Rika gates (kill/pivot/portfolio) |

**Lower-weight tie-break:** when two weights are plausible, choose the cheaper; escalation requires a
written reason in `assumptions` / `risk_flags`.

---

## Orchestrator Contract (extended)

```yaml
workflow_plan:
  workflow_id: ""
  job: ""             # recall | next | scout | memory | research | idea-debate | build | governance
  weight: ""          # tiny | small | medium | heavy | strategic
  goal: ""
  known_inputs: []
  missing_inputs: []
  assumptions: []
  risk_flags: []
  runtime_tracking:
    runtime_mode: level_1_status_only
    run_id: ""
    status_log: logs/runtime_status.md
    agent_run_log_dir: logs/agent_runs/
    current_status: planned
    current_agent: Minori Lead Conductor
    latest_artifact: ""
    next_step: ""
  agent_sequence:
    - step: 1
      agent: ""
      input_artifact: ""
      output_artifact: ""
      context_budget: small
      stop_condition: ""
      approval_gate: false
  execution_mode: ""  # single_agent | sequential_handoff | dynamic_workflow
  recommended_workflow: ""  # e.g. idea-stresstest.js (only when execution_mode = dynamic_workflow)
  context_budget: small     # dynamic ONLY with Rika approval
  approval_points: []
  stop_conditions: []
  proactive_recall: false   # true → Minori calls Tsumugi before heavy handoffs (JIT context)
  gate_scope_preclarification_required: false
  expected_gates: []        # use none_detected + reason when the scan finds no predictable gates
  gate_decisions:
    - gate: ""              # e.g. auth system, paid API, database, hosting, production deploy
      risk_domain: ""       # strategic | financial | privacy | security | infra | legal
      pre_decide_or_defer: ""  # Pre-Decide | Defer
      owner_decision: ""    # required before Aki when Pre-Decide
      deferred_to: ""       # required when Defer; name owner/checkpoint
      stop_condition: ""    # what blocks Aki/Coda if unresolved
```

---

## Level 1 Runtime Status

For any `/idea-gate` route beyond pure classification, Minori must record `runtime_tracking` in
`workflow_plan.md` and add or update a compact row in `logs/runtime_status.md`.

- `runtime_mode` is always `level_1_status_only`.
- Status values: `planned`, `running`, `awaiting_approval`, `blocked`, `complete`, `aborted`.
- `task_queue` is represented by `next_step`; this is a marker, not a scheduler.
- `artifact_return` is represented by `latest_artifact`; record paths only, not artifact bodies.
- Level 1 Runtime must not spawn agents, launch dynamic workflows, or enable parallel/fanout.

## Gate Scope Pre-Clarification

Before any Aki-bound or build-bearing route, Minori must add an **Expected Gates + Pre-Decide vs
Defer** section to `workflow_plan.md`.

- Scan for predictable gates: auth, payments, database, infrastructure, hosting, production deploy,
  paid API/tool usage, privacy, security, legal, and client/user-facing messages.
- If a gate is likely, ask Rika-Chan whether to **Pre-Decide** it before Aki or **Defer** it to a
  named checkpoint, usually `Coda proposes options + Rika-Chan approves before
  implementation/spend/deploy`.
- If no predictable gates are found, record `expected_gates: none_detected` with a short reason.
- If gates are detected but not clarified, Aki must not start.

This is mandatory, not advisory, for any workflow that can enter Aki.

---

## Stop Conditions

- `execution_mode: dynamic_workflow` → produce `approval_request.md`, set `context_budget: dynamic`,
  **halt for Rika-Chan**. Never launch the JS workflow from here.
- Required input artifact missing → generate first.
- Route high-risk (strategic/financial/legal/privacy/security) and not approved → request approval.
- Aki-bound route has unresolved Gate Scope Pre-Clarification → stop before Aki.
- Input conflicts with operating rules → explain adjusted workflow.
- Context budget would need `large`/`dynamic` without approval → stop.

## Output

`handoffs/workflow_plan_YYYYMMDD_NNN.md` (NNN increments per day). No downstream workflow auto-starts.

## Proactive recall (JIT, Phase 1)

When `weight ∈ {heavy, strategic}`, Minori sets `proactive_recall: true` and calls **Tsumugi** to
surface matching `knowledge/` + Obsidian-graph notes as **scoped** context for the relevant step
only — never load the full vault. This is the compounding-memory hook.
