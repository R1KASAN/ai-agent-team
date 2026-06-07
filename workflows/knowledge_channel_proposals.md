---
workflow_id: knowledge_channel_proposals
type: proposed
status: proposed
canonical_front_door: /idea-gate
version: "1.0"
---

# Proposed Knowledge Channel

These commands are proposed optional shortcuts. They do not replace `/idea-gate [anything]`.
Activation requires separate Rika-Chan approval and runtime command files.

## `/ask` — Read-Only Tsumugi Q&A

Owner: Tsumugi Second Brain

Behavior:
- Read `knowledge/README.md` first.
- Read only selected relevant notes.
- Use Obsidian graph/backlinks only as fallback.
- Cite note path and heading when possible.
- Never write to `knowledge/`, logs, or graph files.

Files needed before activation:
- `.claude/commands/ask.md`
- `workflows/knowledge_ask.md`

## `/maintain` — Mira Knowledge Maintenance

Owner: Mira Memory Librarian

Behavior:
- Merge, split, index, or update governed knowledge notes.
- List existing paths before edit.
- Use No-Overwrite Rule for existing files.
- Emit graph updates when note relationships change.

Files needed before activation:
- `.claude/commands/maintain.md`
- `workflows/knowledge_maintain.md`

## `/check` — Nova-V Contradiction / Source Check

Owner: Nova-V Evidence Verifier

Behavior:
- Read selected `knowledge/` notes and source rules.
- Check contradictions, outdated claims, weak citations, and unsupported claims.
- NotebookLM-py remains Nova-V-only and gated per command.
- No `knowledge/` writes; hand verified updates to Mira.

Files needed before activation:
- `.claude/commands/check.md`
- `workflows/knowledge_check.md`

## `/outputs` — Knowledge-Derived Artifacts

Owner: Minori-routed specialist

Behavior:
- Generate briefs, plans, summaries, or task packets from selected knowledge notes.
- Do not upgrade wiki/source claims to facts without Nova-V verification.
- Draft artifacts only unless a workflow explicitly approves downstream use.

Files needed before activation:
- `.claude/commands/outputs.md`
- `workflows/knowledge_outputs.md`

## Governance

- `/idea-gate [anything]` remains the canonical front door.
- All proposed commands are optional shortcuts.
- Any write path requires Rika-Chan approval and No-Overwrite handling.
- Tsumugi remains read-only.
- Mira remains the only normal writer to `knowledge/`.
