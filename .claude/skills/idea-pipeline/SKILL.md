---
name: idea-pipeline
version: "1.0"
trust_status: Core
team: claude
invoked_by: minori_lead_conductor; /idea-pipeline
input: raw product idea + optional mode flag (auto | gated | interactive)
output: all product_idea_debate artifacts in sequence; final = product_opportunity_brief.md
mode_default: gated
ref: skills/claude/idea-pipeline/SKILL.md
---

Orchestrates the full product_idea_debate chain (Steps 1–9) in a single conversational session. Runs each sub-skill sequentially; pauses at checkpoints based on mode. At every checkpoint, user may continue, enter Yuki-style debate, ask a free-form question, or stop. Hard gates (kill / not_viable / POB approval) always require explicit stop or approval — mode setting does not override them. No shell execution. No external calls.
