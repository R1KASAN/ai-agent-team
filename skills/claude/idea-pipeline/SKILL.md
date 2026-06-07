---
name: idea-pipeline
version: "1.0"
trust_status: Core
team: claude
author: Minori Lead Conductor
created: 2026-06-06
invoked_by: /idea-pipeline
input: raw product idea text; optional --mode flag
output: sequential artifacts from product_idea_debate; final = product_opportunity_brief.md
context_budget: small
ref_workflow: workflows/product_idea_debate.md
ref_skills:
  - .claude/skills/input-gate/SKILL.md
  - .claude/skills/idea-challenge/SKILL.md
  - .claude/skills/evidence-pack/SKILL.md
  - .claude/skills/claim-verification/SKILL.md
  - .claude/skills/strategic-lens/SKILL.md
  - .claude/skills/business-viability/SKILL.md
  - .claude/skills/governance-check/SKILL.md
  - .claude/skills/kaizen-review/SKILL.md
---

# SKILL: idea-pipeline

## Purpose

Run the full `product_idea_debate` workflow in a single conversational session. The user types one command; all 9 steps execute sequentially with inline checkpoint pauses. No separate command invocations needed between steps.

This skill is an orchestration layer — it calls the logic of existing sub-skills by reference. It does not replace them.

---

## Trigger

```
/idea-pipeline [idea text]
/idea-pipeline --mode interactive [idea text]
/idea-pipeline --mode auto [idea text]
```

Triggered by: Minori Lead Conductor receiving `/idea-pipeline` command.

---

## Mode Behavior

| Mode | When to Use | Pause Behavior |
|------|------------|----------------|
| `gated` (default) | Normal use | Pause only at hard gates (kill / not_viable / POB approval) |
| `interactive` | User wants full control | Pause after every step with checkpoint menu |
| `auto` | User wants fast first pass | No pauses; hard gates still apply |

---

## Checkpoint Menu

At every pause point (based on mode), show:

```
━━━ Checkpoint: [Step Name] complete ━━━
[2-4 line summary of what this step produced]

เลือก:
  y / ต่อเลย   →  run next step immediately
  โต้แย้ง      →  Yuki-style Socratic — challenge this output before continuing
  ถามอิสระ     →  ask anything; I'll answer; then we resume
  หยุด         →  halt here; you decide what to do next
```

After `โต้แย้ง`: enter Socratic exchange. Challenge assumptions, surface contradictions, stress-test the output. When user signals done ("พอแล้ว" / "ต่อ" / "ok"), resume pipeline from the next step.

After `ถามอิสระ`: answer the user's question fully, then offer the checkpoint menu again.

After `หยุด`: confirm halt. State the last artifact produced and the next step that would have run.

---

## Hard Gates (always stop, any mode)

| Gate | Condition | Action |
|------|-----------|--------|
| Kill gate | `strategic_lens.md` verdict = `kill` | Stop before Step 6 (Bumi). State recommendation. Rika-Chan decides. |
| Viability gate | `business_analysis_brief.md` verdict = `not_viable` | Stop before Step 7 (Poom). State recommendation. Rika-Chan decides. |
| POB approval gate | `product_opportunity_brief.md` complete | Always stop. Rika-Chan must approve before PRD begins. |
| Governance block | `governance_check.md` verdict = `block` | Stop before close. Rika-Chan resolves. |

At hard gates, show only:
```
⛔ [Gate name] — [reason]
[Summary of finding]
หยุดที่นี่ก่อน รอการตัดสินใจ
```

---

## Step Sequence

Each step runs the corresponding sub-skill inline. Output is shown in the conversation; artifact is written to `handoffs/` or `context_packs/` as appropriate.

```
Step 1 — Minori: input-gate
  Input:  raw idea text
  Output: classification + missing inputs + risk flags + assumptions
  Pause:  interactive mode only (show checkpoint menu)

Step 2 — Yuki: idea-challenge
  Input:  Step 1 classification
  Output: idea_challenge_brief.md (surfaced assumptions, contradictions, reframings)
  Pause:  interactive mode + gated mode (this is a key debate point)

Step 3 — Nova-V: evidence + verification
  Input:  idea_challenge_brief.md
  Output: verified_evidence_pack.md (claims labelled + citation audit + gaps)
  Pause:  interactive mode only

Step 4 — Sora: strategic-lens
  Input:  verified_evidence_pack.md
  Output: strategic_lens.md (moat, bet, kill/proceed recommendation)
  Pause:  HARD GATE if kill; interactive pause otherwise

Step 5 — Bumi: business-viability
  Input:  strategic_lens.md + verified_evidence_pack.md
  Output: business_analysis_brief.md (WTP signal, monetization path, business risk)
  Pause:  HARD GATE if not_viable; interactive pause otherwise

Step 6 — Poom: product_opportunity_brief
  Input:  business_analysis_brief.md
  Output: product_opportunity_brief.md (recommended format, platform, MVP scope)
  Pause:  HARD GATE always (Rika-Chan approval required before PRD)

Step 7 — Rika-Chan governance gate
  Input:  product_opportunity_brief.md
  Output: governance_check.md or approval_request.md (privacy / legal / ToS risks)
  Pause:  HARD GATE if block; interactive pause otherwise

Step 8 — Kaizen token convention
  Input:  governance_check.md
  Output: kaizen_report.md (waste review, workflow improvement notes)
  Context budget: tiny
  Pause:  none (final step)
```

---

## Output Artifacts

All artifacts saved to `handoffs/` with date-stamped filenames:

| Artifact | Producer |
|----------|---------|
| `idea_challenge_brief.md` | Yuki |
| `verified_evidence_pack.md` | Nova-V |
| `strategic_lens.md` | Sora |
| `business_analysis_brief.md` | Bumi |
| `product_opportunity_brief.md` | Poom |
| `governance_check.md` | Rika-Chan governance gate |
| `kaizen_report.md` | Kaizen token convention |

---

## Rules

- Sequential only — no parallel execution
- Agent Registry Lock: delegate only to registered agents listed above
- All context budgets `small` unless escalation approved by Rika-Chan
- No shell execution, no external API calls, no credential access
- No file overwrites — if artifact already exists, create `.draft.md` version
- If missing input artifact at any step: generate it first, do not skip

---

## Not Triggered When

- User has not provided a product idea (classify first with `/idea-gate`)
- An existing `product_opportunity_brief.md` already exists for this idea cycle
- Codex build is already in progress — this skill runs before build
- User only wants idea classification without full debate (`/idea-gate` instead)
