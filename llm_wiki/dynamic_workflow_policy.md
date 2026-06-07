---
version: "1.0"
maintained_by: llm_wiki_reference_owner
authority: Rika-Chan
---

# Dynamic Workflow Policy

Extends `token_optimization_rules.md` with full policy on when Dynamic Workflows are permitted.

---

## Definition

A Dynamic Workflow runs multiple agents in parallel (fanout) or uses an adaptive step sequence determined at runtime. It is the highest-cost workflow type and is **not the default**.

---

## Approved Use Cases

Dynamic Workflows may only be considered for:

1. Cross-checked research requiring independent agent perspectives
2. Adversarial evaluation (one agent challenges another's output)
3. Codebase audit across multiple subsystems simultaneously
4. Large-scale migration requiring parallel track validation
5. Security audit (when fully designed and activated — see `.claude/workflows/security-audit.md`)
6. Multi-lens diff review (when fully designed and activated — see `.claude/workflows/diff-review.md`)

All other use cases default to sequential.

---

## Six Required Conditions for Parallel Fanout

All six must be met before any parallel fanout is permitted:

1. Tasks are genuinely independent — no shared state or ordering dependency.
2. Each parallel agent has a clearly bounded, non-overlapping scope.
3. Context budget is approved at `dynamic` level by Rika-Chan.
4. Total token cost has been estimated and accepted.
5. A merge/synthesis step is defined to reconcile parallel outputs.
6. Rika-Chan has explicitly approved this specific fanout.

Failing any one condition → revert to sequential.

---

## Stub-Only Workflows

`security-audit` and `diff-review` are currently `status: stub_only`. They must not be run until:

- The workflow is fully designed in `workflows/`
- Rika-Chan approves the design
- Status is updated to `active` in both `.claude/workflows/` and `workflows/`

---

## Governance

Dynamic Workflows require `context_budget: dynamic` approval (an explicit Rika-Chan gate). This is listed in `governance/approval_gates.md`.

---

> Token rules: `token_optimization_rules.md` | Stubs: `.claude/workflows/security-audit.md`, `.claude/workflows/diff-review.md`
