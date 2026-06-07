---
command: idea-pipeline
description: Orchestrate the full product idea debate pipeline (challenge → evidence → strategy → business → product opportunity brief) in one gated session.
skill: idea-pipeline
entry_agent: minori_lead_conductor
context_budget: small
mode_default: gated
version: "1.1"
ref: workflows/product_idea_debate.md
---

# Command: /idea-pipeline

Run the full product idea evaluation pipeline in one conversational session.

## Usage

```
/idea-pipeline [idea text]
/idea-pipeline --mode interactive [idea text]
/idea-pipeline --mode auto [idea text]
```

## Mode Options

| Mode | Behavior |
|------|---------|
| `gated` (default) | Pause only at hard gates: kill / not_viable / POB approval |
| `interactive` | Pause after every step with full checkpoint menu |
| `auto` | Run all steps without pausing; hard gates still apply |

## Checkpoint Menu (shown at each pause)

```
> เลือก:
  [y / ต่อเลย]  → run next step immediately
  [โต้แย้ง]     → Yuki-style Socratic challenge on this output
  [ถามอิสระ]    → free-form question; Claude answers; then resume
  [หยุด]        → halt; decide next action manually
```

## Hard Gates (always stop regardless of mode)

- `strategic_lens.md` verdict = `kill` → halt before Bumi
- `business_analysis_brief.md` verdict = `not_viable` → halt before Poom
- `product_opportunity_brief.md` complete → Rika-Chan must approve before PRD begins

## Agent Sequence

Minori → Yuki → Nova-V → Sora → Bumi → Poom[GATE]

Nova-V handles evidence discovery and verification in one loop (≤2). Gina and Kai are archived as
active agents; governance is enforced by Rika-Chan hard gates + `governance/` docs, and kaizen is a
shared token convention rather than a chain step.

## Rules

- Sequential only — no parallel fanout
- Agent Registry Lock applies — no invented agents
- All context budgets default to `small`; `large` or `dynamic` requires Rika-Chan approval
- Artifacts written to `handoffs/` only
