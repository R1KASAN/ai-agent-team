---
name: input-gate
version: "1.0"
trust_status: Core
team: claude
invoked_by: minori_lead_conductor; /idea-gate
input: raw input from Rika-Chan
output: classified input type + missing fields list (embedded in workflow_plan.md)
ref: skills/claude/input-gate/SKILL.md
---

Classifies input against the 11 workflow targets in workflows/idea_gate.md. Flags missing information and false assumptions before any workflow starts. No agent receives a task until input is classified. No shell execution. No external calls.
