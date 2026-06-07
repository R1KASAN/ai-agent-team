---
workflow_plan_id: workflow_plan_20260607_003
created_by: Minori Lead Conductor [Mi]
created_at: 2026-06-07
raw_input: "ควร pivot ไป B2B ไหม"
prior_related_plan: none
status: classified — STRATEGIC GATE TRIGGERED — halted for Rika-Chan (see approval_request_20260607_001.md)
test_context: "Phase 1 proof run — Test 3 (Heavy/strategic gate), per Rika-Chan e2e verification request 2026-06-07"
---

# Workflow Plan — 20260607-003

## Raw Input (Thai)

> "ควร pivot ไป B2B ไหม"

**Translation:** "Should we pivot to B2B?"

---

## Minori Classification

| Field | Value |
|---|---|
| Job | `idea-debate` (closest mapped workflow ID — a pivot evaluation runs through the same Yu→NV→So→Bu→Po lens chain, anchored on Sora's strategic-lens step) — **but immediately flagged as a named Rika-Chan Hard Gate: "strategic pivot"** |
| Weight | `strategic` — exact match to dispatcher table: "pivot, kill/bet, multi-idea portfolio" |
| Risk Level | High — strategic pivot is a named hard gate in `CLAUDE.md` (governance backbone) |
| Completeness | Incomplete — "pivot to B2B" has no current-state baseline (what is the present model? what evidence triggered this question?) |
| Primary Route | `dynamic_workflow` → `idea-stresstest.js` (heavy/strategic-only path) **+ Rika-Chan strategic-pivot gate** |
| Execution Mode | `dynamic_workflow` |
| Recommended Workflow | `idea-stresstest.js` (the one approved JS Dynamic Workflow) |

**Weight reasoning:** "Should we pivot to B2B" is a textbook `strategic` case — it is a pivot
decision, not a single-idea validation. Per dispatcher rules, `heavy`/`strategic` are the *only*
weights allowed to use `dynamic_workflow`, and a pivot additionally trips the named **"strategic
pivot"** hard gate in `CLAUDE.md` § Rika-Chan Hard Gates. Both signals point the same direction —
no ambiguity to resolve toward a cheaper weight here; escalating from `medium` would be *wrong*,
not just expensive.

**Job-classification note:** the job table has no dedicated `pivot` row. `idea-debate` is the
nearest mapped workflow ID (Sora's strategic-lens step is exactly the pivot-evaluation mechanism),
but Minori flags this explicitly as **higher-risk than a normal idea-debate** — it is a *direction*
question about the existing business, not a *new-idea* validation. This distinction is carried into
the plan via `risk_flags` and the dedicated approval_request.

---

## Known Inputs

- Core question: whether to pivot the business model toward B2B

## Missing Inputs (Clarification Needed — per Hard Gate "ask ≤3 if high-risk")

1. **What is the current model/target** that would be pivoted *away from* (B2C? prosumer? something else)?
2. **What evidence or signal triggered this question** (e.g., weak B2C traction, inbound B2B interest, a specific cost/channel problem)?
3. **What would "B2B" mean concretely here** — which buyer, which product surface, which monetization shift?

> Per dispatcher rule for high-risk/ambiguous input: these are surfaced as open questions in the
> `approval_request.md`, not assumed away — a pivot call must not be evaluated on Minori's guesses.

## Assumptions (Labeled — Pending Owner Input)

- A1: "We" implies an existing product/direction that this studio is currently pursuing (the pivot has *something* to move away from)
- A2: The question is exploratory ("should we") not yet a decision ("we are") — still in the evaluation zone, not execution
- A3: No financial/runway crisis stated — but this cannot be assumed away; it changes urgency and must be confirmed by Rika-Chan

## Risk Flags

| Risk | Severity | Notes |
|---|---|---|
| Named hard gate: strategic pivot | **Critical** | `CLAUDE.md` lists "strategic pivot" explicitly among gates that must stop and ask the owner — cannot proceed without Rika-Chan |
| Insufficient baseline | High | No current-state description supplied; any debate run now would be evaluating a pivot against an unstated starting point |
| Sora kill-signal interaction | Medium | If the dynamic run's strategy lens returns a kill/reframe verdict, that is *itself* a separate named hard gate — compounding gates possible in one run |
| Token/context cost | Medium | `dynamic_workflow` is the highest-cost path — must not be entered without `context_budget: dynamic` approval |

---

## Workflow Plan (Orchestrator Contract — 8 fields)

```yaml
workflow_plan:
  workflow_id: idea_stresstest_strategic
  job: idea-debate              # nearest mapped ID; flagged as strategic-pivot (higher-risk subtype)
  weight: strategic
  goal: >
    Evaluate whether a pivot to a B2B model is warranted: surface the riskiest
    assumptions behind "pivot to B2B" (tech/market/risk voices), cross-check
    evidence for B2B demand/WTP vs. current direction, apply strategy + business
    lenses, and merge into ONE draft recommendation (proceed / reframe / kill /
    needs_owner_decision) for Rika-Chan's strategic-pivot gate decision.
    Output is a DRAFT input to that decision — never the decision itself.
  known_inputs:
    - Core question: pivot to B2B — yes/no
  missing_inputs:
    - Current model/baseline being pivoted from
    - Trigger evidence/signal for the question
    - Concrete definition of "B2B" in this context (buyer, surface, monetization)
  assumptions:
    - A1: An existing direction exists to pivot away from
    - A2: Still exploratory, not yet decided
    - A3: No stated financial crisis (must be confirmed, not assumed)
  risk_flags:
    - Named hard gate: strategic pivot (Critical)
    - Insufficient baseline for a fair evaluation (High)
    - Possible compounding Sora kill-signal gate (Medium)
    - Highest-cost execution path — dynamic budget required (Medium)
  agent_sequence:
    - step: 1
      agent: Minori Lead Conductor [Mi]
      input_artifact: raw_input
      output_artifact: workflow_plan_20260607_003.md (this file) + approval_request_20260607_001.md
      context_budget: small
      stop_condition: >
        Plan + classification produced; approval_request issued; Minori HALTS —
        does not launch idea-stresstest.js itself
      approval_gate: true
    - step: 2  (BLOCKED — requires Rika-Chan approval to even begin)
      agent: idea-stresstest.js (dynamic fan-out — Yuki x3 → Nova-V → Sora+Bumi → Poom merge)
      input_artifact: workflow_plan_20260607_003.md + approval_request_20260607_001.md (approved)
      output_artifact: opportunity_brief_draft (returned to launcher; still a DRAFT)
      context_budget: dynamic
      stop_condition: >
        Merged draft recommendation produced; Rika-Chan strategic-pivot gate
        decision still required before any action on the recommendation
      approval_gate: true   # BOTH the dynamic-budget gate AND the strategic-pivot gate apply
  execution_mode: dynamic_workflow
  recommended_workflow: idea-stresstest.js
  context_budget: small        # THIS plan's cost; the recommended run would need `dynamic` (separately gated)
  approval_points:
    - "BEFORE Step 2 can start at all: Rika-Chan must (a) answer/waive the 3 clarification questions, (b) approve context_budget: dynamic, AND (c) clear the named strategic-pivot hard gate"
    - "AFTER Step 2 (if run): Rika-Chan strategic-pivot decision on the merged draft — separate from, and in addition to, the dynamic-budget approval"
  stop_conditions:
    - "Strategic/pivot route detected → HALT here. Minori never launches idea-stresstest.js itself — only recommends + produces approval_request.md (per context.md and the script's own Flag-A guard, which aborts with zero fan-out if rika_dynamic_approved is not explicitly true)"
    - "Rika-Chan does not approve dynamic budget → workflow stays at this plan; no agent activated beyond Minori"
    - "Rika-Chan does not clear the strategic-pivot gate → workflow stays at this plan regardless of budget approval"
  proactive_recall: true   # weight=strategic → Minori sets this; Tsumugi surfaces prior pivot/B2B-related notes as scoped JIT context for whichever agent runs Step 2
```

---

## Minori Stop Declaration

`[Mi]` Minori has completed the Input Gatekeeper + dispatcher classification step.
**Job = `idea-debate` (strategic-pivot subtype), Weight = `strategic`, execution_mode = `dynamic_workflow`.**

**TWO hard gates triggered simultaneously:**
1. Named Rika-Chan Hard Gate — **"strategic pivot"** (`CLAUDE.md` § Rika-Chan Hard Gates)
2. `execution_mode: dynamic` → Rika `dynamic`-budget approval gate (`governance/approval_gates.md`)

Per dispatcher contract, Minori **recommends** `idea-stresstest.js` and **STOPS** — it does not, and
will not, launch the JS workflow itself. See companion artifact `approval_request_20260607_001.md`
for the formal gate request and the 3 clarification questions.

**No specialist agent has been activated. No fan-out has started.**
