---
name: idea-challenge
version: "1.0"
trust_status: Core
team: claude
invoked_by: yuki_idea_challenger; /product-idea-debate
input: raw idea or product concept from Rika-Chan
output: idea_challenge_brief.md
template: templates/idea_challenge_brief.md
---

# Idea Challenge Skill

Applies Socratic questioning to surface hidden assumptions, contradictions, and reframings before any evidence is gathered.

## Protocol

1. Restate the idea in one sentence to confirm understanding.
2. Ask: Who exactly has this problem? How do they solve it today?
3. Ask: What must be true for this idea to work? List each assumption.
4. Apply assumption-mapping skill to classify each assumption.
5. Identify the single riskiest assumption.
6. Propose 2–3 reframings of the idea.
7. Write `idea_challenge_brief.md`.

## Required Fields in Output

- `idea_restatement`, `assumptions` (classified list), `riskiest_assumption`, `open_questions`, `reframings`

## Forbidden

- Do not validate the idea — challenge it.
- Do not start evidence gathering — that is Nova's role.
- No shell execution. No external calls.
