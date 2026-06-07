---
name: llm-wiki-update
version: "1.0"
trust_status: Core
team: claude
invoked_by: lexi_llm_wiki_keeper; /llm-wiki-update
input: proposed rule change, new pattern, skill candidate note, or correction
output: llm_wiki_update.md (status: proposed)
template: templates/handoff.md (adapted)
---

# LLM Wiki Update Skill

Produces a proposed update to `llm_wiki/`. No file in `llm_wiki/` is modified by this skill.

## Protocol

1. Identify the target file in `llm_wiki/` (e.g. `skill_trust_gate.md`, `token_optimization_rules.md`).
2. Draft the proposed change: new rule, correction, or skill candidate note.
3. Write rationale — why is this change needed? What evidence supports it?
4. Set `status: proposed`.
5. Write `llm_wiki_update.md`.
6. Do not touch any file in `llm_wiki/` — Rika-Chan applies approved changes.

## Required Fields in Output

- `target_file`, `change_type` (add / update / correct / deprecate), `proposed_content`, `rationale`, `status: proposed`

## Forbidden

- Do not modify any `llm_wiki/` file directly.
- Do not set status to anything other than `proposed`.
- No shell execution. No external calls.
