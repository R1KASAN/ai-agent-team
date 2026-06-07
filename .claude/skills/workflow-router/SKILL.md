---
name: workflow-router
version: "1.0"
trust_status: Core
team: claude
invoked_by: minori_lead_conductor; /idea-gate
input: classified input from idea_gate; workflow_plan.md
output: agent assignment and next-step instruction (embedded in workflow_plan.md)
ref: skills/claude/workflow-router/SKILL.md
---

Maps classified input to the correct workflow from workflows/workflow_index.md. Assigns entry agent,
context budget, and stop conditions. Sequential routing only — parallel fanout requires all 6
conditions and Rika-Chan approval.

For Aki-bound/build-bearing routes, require **Gate Scope Pre-Clarification** in `workflow_plan.md`:
Expected Gates + Pre-Decide vs Defer. Each predictable gate must be pre-decided by Rika-Chan before
Aki or deferred to a named checkpoint such as `Coda proposes options + Rika-Chan approves before
implementation/spend/deploy`. If gates are detected but not clarified, Aki must not start.

No shell execution. No external calls.
