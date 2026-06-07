---
name: handoff
version: "1.0"
trust_status: Core
team: claude
invoked_by: all agents at step completion
input: completed output artifact path, next agent name, context budget, stop conditions
output: handoff.md
template: templates/handoff.md
---

# Handoff Skill

Produces a structured `handoff.md` that carries exactly the information the next agent needs — no more.

## Protocol

1. Confirm the current step's output artifact exists and is complete.
2. Identify the next agent from `workflow_plan.md`.
3. Set context budget to the value assigned in the plan (default: `small`).
4. List any approval gates or stop conditions that apply to the next step.
5. Write `handoff.md` using `templates/handoff.md`.

## Required Fields in Output

- `from_agent`, `to_agent`
- `output_artifact` (path)
- `context_budget`
- `stop_conditions`
- `approval_gate` (if applicable)

## Forbidden

- Do not pass full artifact content — pass path only.
- Do not change the assigned context budget without Minori approval.
- No shell execution. No external calls.
