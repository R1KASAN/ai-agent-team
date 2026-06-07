---
workflow_id: llm_wiki_update
slash_command: /llm-wiki-update
entry_agent: Minori (gate)
context_budget: small
version: "1.1"
---

# Workflow: llm_wiki_update

## Purpose

Convert repeated workflow lessons or Rika-Chan instructions into reusable rules or skill candidates in the LLM Wiki. Keeps the operating knowledge base current without bloating it. `llm_wiki/` is now a passive reference store (the standalone Lexi agent is archived); updates are owner/Rika-Chan-driven.

## Prerequisites

- A specific workflow lesson note, or
- Rika-Chan instruction to update a rule
- Target `llm_wiki/` file identified

## Flow

```
Workflow lesson or Rika-Chan instruction
→ Minori: workflow_plan.md                    [context_budget: tiny]
→ Draft llm_wiki_update.md                    [context_budget: small]
         + skill_candidate_note.md (if applicable)
         *** status: proposed — not applied until approved ***
→ Rika-Chan / Minori: review and approve update
→ Apply approved update to target llm_wiki/ file
```

## Agent Sequence

| Step | Owner | Input | Output | Stop Condition |
|------|-------|-------|--------|---------------|
| 1 | Minori | lesson or instruction | `workflow_plan.md` | Plan complete; confirms update is non-redundant |
| 2 | Owner draft | lesson + target wiki file | `llm_wiki_update.md` + `skill_candidate_note.md` | Proposed changes documented |
| 3 | Rika-Chan / Minori | approved `llm_wiki_update.md` | Updated `llm_wiki/` file | Changes applied |

## Approval Gates

- **Step 2 → 3:** All LLM Wiki updates are `proposed` until Rika-Chan or Minori confirms → then `approved` → then `applied`
- Skill candidates → require Skill Trust Gate scoring + Rika-Chan approval before promoting to Trial or Core
- No update applied without a cited source artifact

## Stop Conditions

- Proposed update is redundant with existing rules → stop; no update needed
- Source artifact is insufficient to justify a rule change → stop; flag to Minori
- Skill candidate requires third-party install → stop; Skill Trust Gate must run first

## LLM Wiki Update Rule

Every update must:
- Cite a source artifact (workflow lesson or Rika-Chan instruction)
- Target a specific file in `llm_wiki/`
- Use `status: proposed` until approved
- Not delete existing rules without explicit approval

## Output Artifacts

`llm_wiki_update.md` · `skill_candidate_note.md` (if applicable) · updated `llm_wiki/` file (after approval)

## Workflow Type

`sequential_handoff`
