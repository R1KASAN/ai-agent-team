---
name: grill-me
version: "1.0"
trust_status: Core
team: claude
invoked_by: yuki_idea_challenger; sora_strategy_sensei
input: any product claim, assumption, or strategy position
output: challenge questions (embedded in active artifact)
---

# Grill Me Skill

Generates focused adversarial questions to stress-test a claim before it advances.

## Protocol

1. Identify the claim or position being tested.
2. Generate 5–7 challenge questions across these angles:
   - **Counter-evidence** — what would disprove this?
   - **Scope creep** — is this claim broader than the evidence supports?
   - **Alternative explanation** — what else could explain this?
   - **Stakeholder challenge** — who would disagree and why?
   - **Time horizon** — is this true now but not in 2 years?
3. Mark the 1–2 questions that, if unanswerable, should block the workflow.

## Forbidden

- Do not answer the questions — generate them for the agent to address.
- Do not reduce the question count below 5 to save tokens.
- No shell execution. No external calls.
