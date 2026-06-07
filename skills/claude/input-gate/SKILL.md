---
name: input-gate
version: "1.0"
trust_status: Core
team: claude
invoked_by: minori_lead_conductor; /idea-gate
input: raw input from Rika-Chan
output: classified input type + missing fields list (embedded in workflow_plan.md)
---

# Input Gate Skill

Classifies input before any workflow starts. No agent receives a task until input is classified and missing fields are identified.

## Classification Targets (from workflows/idea_gate.md)

product_idea | research_question | memory_intake | prd_request | codex_task | governance_review | kaizen_request | llm_wiki_update | evidence_request | qa_review | security_request

## Protocol

1. Read the raw input.
2. Match to one classification target. If ambiguous, flag and ask Rika-Chan before proceeding.
3. Identify missing required fields for that workflow type (e.g. product_idea needs: problem statement, target user, initial hypothesis).
4. List assumptions made during classification.
5. Flag risk level: `low` / `medium` / `high` (high = strategic, financial, legal, or security).
6. Embed classification result in `workflow_plan.md`.

## Forbidden

- Do not start a workflow with an ambiguous classification — resolve it first.
- Do not skip missing-field identification.
- No shell execution. No external calls.
