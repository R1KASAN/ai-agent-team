---
name: handoff
version: "1.0"
trust_status: Core
team: claude
invoked_by: all agents at step completion
input: completed output artifact, next agent name, context budget
output: handoff.md
ref: skills/claude/handoff/SKILL.md
---

Produces a structured handoff.md that carries the output artifact path, next agent, context budget, and stop conditions to the next step. No shell execution. No external calls.
