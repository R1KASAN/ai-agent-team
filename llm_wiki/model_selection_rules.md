---
version: "1.0"
maintained_by: llm_wiki_reference_owner
authority: Rika-Chan
---

# Model Selection Rules

Rules for choosing the right model configuration for each context budget level. Apply in combination with `token_optimization_rules.md`.

---

## Context Budget → Model Guidance

| Budget | When to Use | Context Load |
|--------|------------|-------------|
| `tiny` | Small routing, checks, or artifact-list reviews only | Artifact paths only; no file content |
| `small` | Default for most agents | Active artifact + relevant refs only |
| `medium` | Poom (PRD), Aki (task packet) | Full artifact chain for current workflow step |
| `large` | Requires Rika-Chan approval | Multi-artifact review; justified by task complexity |
| `dynamic` | Requires Rika-Chan approval | Dynamic Workflow only; see `dynamic_workflow_policy.md` |

---

## Rules

1. Default to `small`. Justify any escalation before loading additional context.
2. Never load the full codebase for a `small` or `tiny` task.
3. If an agent is uncertain which budget to use → default to `small` and flag in `workflow_plan.md`.
4. Context budget is set by Minori in `workflow_plan.md`. No agent may change it unilaterally.
5. Exceeding an assigned budget without Minori re-approval is a waste event — log in `logs/kaizen_log.md`.

---

## Stop Rule (Jidoka)

If a task genuinely requires `large` or `dynamic` budget and it has not been approved → stop, flag the need in `workflow_plan.md`, and wait for Rika-Chan approval before proceeding.

---

> Token rules: `token_optimization_rules.md` | Approval: `governance/approval_gates.md`
