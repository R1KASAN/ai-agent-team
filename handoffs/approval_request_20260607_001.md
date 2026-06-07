---
approval_request_id: approval_request_20260607_001
created_by: Minori Lead Conductor [Mi]
created_at: 2026-06-07
related_plan: workflow_plan_20260607_003.md
raw_input: "ควร pivot ไป B2B ไหม"
status: RESOLVED — WAIVED AS TEST SCAFFOLD (see decision dec-20260607-003)
test_context: "Phase 1 proof run — Test 3 (Heavy/strategic gate), per Rika-Chan e2e verification request 2026-06-07"
resolved_at: 2026-06-07
resolved_by: Rika-Chan (owner)
---

# Approval Request — 20260607-001

`[Mi]` Minori halts here. Per `governance/approval_gates.md`, this artifact states: which gate(s)
are triggered, why, the proposed action, risk level, and what happens if denied.

---

## 1. Which gate(s) are triggered

Two gates fire simultaneously on this single input:

1. **Named Rika-Chan Hard Gate — "strategic pivot"** (`CLAUDE.md` § Rika-Chan Hard Gates — listed
   explicitly alongside legal/privacy, security, payment/deploy, client data, Sora kill-signal,
   Bumi not-viable, POB-before-PRD, notebooklm-py activation).
2. **`execution_mode: dynamic` budget gate** (`governance/approval_gates.md`) — the dispatcher
   classified this input as `weight: strategic`, the only tier (with `heavy`) permitted to use
   `dynamic_workflow`, and the route matches the one approved Dynamic use case
   (`idea-stresstest.js` — adversarial evaluation / cross-checked strategic evidence).

## 2. Why triggered

The raw input — "ควร pivot ไป B2B ไหม" ("Should we pivot to B2B?") — is a direction question about
the *existing* business, not a new-idea validation. That is the literal definition of the
`strategic` weight tier ("pivot, kill/bet, multi-idea portfolio") and of the named "strategic
pivot" hard gate. Running any evaluation of this — even a draft one — without first clearing both
gates would mean Minori (or a downstream agent) made a strategic call the Operating Contract
reserves for the owner.

## 3. Proposed action (what Minori recommends, and will NOT do unilaterally)

If — and only if — Rika-Chan clears **both** gates below, the recommended next step is to launch
the one approved JS Dynamic Workflow, `idea-stresstest.js`, with:

```
{ idea: "<Rika-Chan's refined pivot framing, informed by the answers to Q1-Q3 below>",
  weight: "strategic",
  rika_dynamic_approved: true,
  notebooklm_approved: <Rika-Chan's call, per-command, Nova-V-only> }
```

This produces a **DRAFT** merged opportunity-brief-style recommendation
(`proceed | reframe | kill | needs_owner_decision`) — it is explicitly an input to Rika-Chan's
strategic-pivot decision, never the decision itself, and it still passes the normal POB approval
gate before any further action (per the script's own header comment and `next_gate` return field).

**Minori will not launch this script itself under any circumstance** — the script's own Flag-A
guard aborts with zero fan-out, zero notebooklm-py reachability, and no brief produced unless
`args.rika_dynamic_approved === true` is passed explicitly by a human-launched run.

## 4. Open questions for Rika-Chan (≤3, per "high-risk → ask" dispatcher rule)

Answering these — or explicitly waiving them — sharpens any subsequent run and is a precondition
for a fair evaluation, not a delay tactic:

1. **What is the current model/target** that this would pivot *away from*?
2. **What evidence or signal triggered this question** — e.g. weak traction, inbound B2B interest,
   a specific cost/channel problem, or a hunch worth stress-testing?
3. **What would "B2B" concretely mean here** — which buyer, which product surface, which
   monetization shift?

## 5. Risk level

**High.** This is a named hard-gate category (strategic pivot) compounded with the highest-cost
execution path (`dynamic_workflow`). A wrong or premature framing here could misdirect significant
follow-on work (evidence verification, lens application, brief drafting) before the owner has even
confirmed the question is well-posed.

## 6. What happens if denied / not yet approved

- The workflow **stays at `workflow_plan_20260607_003.md`**. No specialist agent activates, no
  fan-out starts, no `notebooklm-py` call becomes reachable, and no draft brief is produced.
- This is the *safe default* — not a failure state. The dispatcher's job is precisely to stop here
  and let the owner decide whether a strategic-pivot evaluation is even warranted right now.
- If Rika-Chan instead wants a **lighter-weight exploration first** (e.g. a `/recall` on prior
  B2B-related notes, or a `/next` for "what's the smallest next step to test this hunch"), Minori
  can re-route to either of those cheaper paths on request — no gate required for either.

---

## Minori Stop Declaration

`[Mi]` Minori halted here per the dispatcher's hard-gate contract, awaiting Rika-Chan's decision
on: (a) the 3 open questions (answer or waive), (b) `context_budget: dynamic` approval, and
(c) the named strategic-pivot gate itself.

## Resolution (2026-06-07)

**Rika-Chan (owner) resolved this gate by waiver**, confirming explicitly that this request is a
**deliberate proof-test scaffold** (per its own `test_context` field — "Phase 1 proof run — Test 3"),
not a live strategic question about a real product. The owner's ruling:

- The 3 open questions in §4 are **waived as test scaffold, not a real pivot** — answering them
  for real would spend genuine strategic-decision effort on a synthetic scenario.
- `context_budget: dynamic` is **granted for this proof run only** (Test 4 /
  `idea-stresstest.js`), not as a standing approval.
- The named strategic-pivot gate is **closed** for this request — no real B2B pivot is being
  evaluated; only the gate *mechanics* are being exercised.

Recorded as `dec-20260607-003` in `logs/decision_log.md`, mirrored to
`knowledge/reference/decision_ledger.md` by Mira. This unblocks Workstream B
(`idea-stresstest.js` / Test 4 workaround attempt) — the one-time `dynamic` grant above is the
`rika_dynamic_approved: true` value Test 4 will pass through the inline-launcher pattern.
