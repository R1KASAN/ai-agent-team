---
workflow_plan_id: workflow_plan_20260607_002
created_by: Minori Lead Conductor [Mi]
created_at: 2026-06-07
raw_input: "เคยเซฟอะไรเรื่อง pricing ไหม"
prior_related_plan: none
status: classified — single_agent (cheap path, no approval gate)
test_context: "Phase 1 proof run — Test 2 (Cheap recall path), per Rika-Chan e2e verification request 2026-06-07"
---

# Workflow Plan — 20260607-002

## Raw Input (Thai)

> "เคยเซฟอะไรเรื่อง pricing ไหม"

**Translation:** "Did I ever save anything about pricing?"

---

## Minori Classification

| Field | Value |
|---|---|
| Job | `recall` — exact trigger-signal match: "เคยเซฟ..." |
| Weight | `tiny` — one-line recall question, single lookup, no debate/build/strategy involved |
| Risk Level | None |
| Completeness | Complete — query is self-contained ("pricing" is the search scope) |
| Primary Route | Tsumugi Second Brain [Ts] |
| Execution Mode | `single_agent` |
| Recommended Workflow | n/a (`dynamic_workflow` reserved for `heavy`/`strategic` only) |

**Weight reasoning:** This is the textbook `tiny` case from the dispatcher table — "one-line
recall." It needs exactly one agent (Tsumugi) doing one scoped lookup against `knowledge/` +
Obsidian-graph fallback (not a full-vault dump). No sequencing, no evidence pipeline, no gate.
This is the cheapest possible honest classification — proof that the dispatcher does not over-route
small asks into the full `/idea` pipeline (the token-waste problem Phase 1 exists to fix).

---

## Workflow Plan (Orchestrator Contract — 8 fields)

```yaml
workflow_plan:
  workflow_id: recall
  job: recall
  weight: tiny
  goal: >
    Search knowledge/ (and Obsidian-graph fallback) for any saved notes, links, research,
    or decisions tagged or related to "pricing"; surface matches with [[backlinks]] and
    one-line context. Scoped lookup only — no full-vault load.
  known_inputs:
    - Search scope: "pricing"
  missing_inputs: []
  assumptions:
    - A1: "pricing" refers to product/business pricing research the owner may have saved
      (not, e.g., a literal grocery receipt) — low-risk assumption, surfaced inline if wrong
  risk_flags: []
  agent_sequence:
    - step: 1
      agent: Tsumugi Second Brain [Ts]
      input_artifact: raw_input ("pricing")
      output_artifact: resurface_pack (rp) — inline reply, no new file required for a tiny lookup
      context_budget: tiny
      stop_condition: >
        Matches surfaced (or "nothing saved on pricing yet" reported honestly) with
        [[backlinks]] to source notes; reply delivered directly to Rika-Chan
      approval_gate: false
  execution_mode: single_agent
  recommended_workflow: ""
  context_budget: tiny
  approval_points: []
  stop_conditions:
    - Tsumugi reports result (found or not-found) → done; no further routing
  proactive_recall: false   # this command IS the recall — no separate JIT pre-fetch needed
```

---

## Minori Stop Declaration

`[Mi]` Minori has completed the Input Gatekeeper + dispatcher classification step.
**Job = `recall`, Weight = `tiny`, execution_mode = `single_agent`.**

This is the cheapest possible route: one agent (Tsumugi), one scoped lookup, `context_budget: tiny`,
**no approval gate** (recall carries no strategic/financial/legal/privacy/security/dynamic signal).
Hand-off to Tsumugi is the entire workflow — no `workflow_plan` overhead beyond this classification
record, demonstrating the dispatcher's cheap-path economy versus routing every input through the
full `/idea` pipeline.
