---
name: write-a-skill
version: "1.0"
trust_status: Core
team: claude
invoked_by: lexi_llm_wiki_keeper; Rika-Chan direct request
input: skill description, team assignment (claude/codex), intended invoker, trust level request
output: SKILL.md stub (status: proposed) in skills/<team>/<skill-name>/
---

# Write a Skill Skill

Produces a new SKILL.md stub in the correct directory. All new skills start as `status: proposed`.

## Protocol

1. Confirm team assignment: `claude` or `codex`.
2. Confirm the skill name (kebab-case).
3. Draft SKILL.md with all required frontmatter fields: `name`, `version`, `trust_status: proposed`, `team`, `invoked_by`, `input`, `output`.
4. Write protocol steps (what the skill does, step by step).
5. Write forbidden actions.
6. Place file at `skills/<team>/<skill-name>/SKILL.md`.
7. Do not place in `.claude/skills/` — that requires a separate runtime reference file.

## Trust Gate

New skill must pass `llm_wiki/skill_trust_gate.md` (10 criteria) before status advances beyond `proposed`. Rika-Chan approval required.

## Forbidden

- Do not set `trust_status` above `proposed` without trust gate evaluation.
- Do not install or clone external skill sources.
- No shell execution. No external calls.
