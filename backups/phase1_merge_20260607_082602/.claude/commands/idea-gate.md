---
command: idea-gate
description: Classify any input and produce a workflow plan before any workflow starts.
entry_agent: minori_lead_conductor
context_budget: small
required_input: raw idea, topic, question, or task from Rika-Chan
optional_input: supporting artifact paths, constraints, risk notes, approval notes; never full chat history
forbidden_actions: bypassing Minori, skipping artifact gates, starting downstream workflows automatically, using large/dynamic context without approval, overwriting existing files without approval
produces: handoffs/workflow_plan_YYYYMMDD_NNN.md
approval_gate: none for classification; required if selected workflow is strategic, financial, or legal
stop_condition: workflow_plan.md produced; no product workflow starts automatically
ref: workflows/idea_gate.md
---

First command for any new input. Minori classifies input, maps missing data and assumptions, assigns agents and context budget, and stops. No downstream workflow runs without Rika-Chan's signal.
