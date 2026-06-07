---
version: "1.0"
maintained_by: llm_wiki_reference_owner
---

# Token and Context Optimization Rules

## 12 Core Rules

1. Use the smallest useful workflow (skill > single agent > sequential > parallel).
2. Prefer skill over agent when task is repeated and procedural.
3. Prefer single agent over team when task is small.
4. Prefer sequential handoff over parallel work.
5. Prefer artifact references over pasted long context.
6. Prefer context pack over full transcript.
7. Prefer source references over copying whole documents.
8. Prefer `knowledge/` index, Graphify/Obsidian backlinks, and approved Nova-V source notes over raw source dumps.
9. Compact before handoff.
10. Export checkpoint before phase changes.
11. Start a new session when context becomes bloated.
12. Reset agent when hallucinating, looping, overusing context, or refusing to compact.

---

## Context Budget Enum

| Budget | Scope | Approval Required |
|--------|-------|------------------|
| `tiny` | One short artifact only | No |
| `small` | 1–3 compact artifacts (default) | No |
| `medium` | Selected artifacts + selected source notes | No |
| `large` | Broad context load | Yes — Rika-Chan |
| `dynamic` | Approved Dynamic Workflow only | Yes — Rika-Chan |

**Default budget: `small`**

If an agent needs `large` or `dynamic`, it must explain why and request approval via Minori.

---

## Do Not Pass

Never include these in agent context without explicit justification and approval:

1. Full chat history
2. Entire repository
3. Entire Obsidian vault
4. All research sources
5. Unrelated old discussions
6. Raw transcript (unless explicitly required)
7. Unsummarized web search results as final evidence
8. Full SKILL.md files for skills not currently in use
9. Agent cards for agents not in the current workflow step

---

## Per-Agent Context Content (what each agent receives)

Each agent receives only:

- Goal for this step
- Current phase
- Relevant decisions (not all decisions)
- Relevant assumptions (not all assumptions)
- Relevant risks (not all risks)
- Relevant sources (not all sources)
- Required output artifact
- Approval gates for this step
- Context budget

---

## Dynamic Workflow Policy

### Use Dynamic Workflow Only For

- Cross-checked research across multiple sources
- Adversarial product idea evaluation
- Codebase-wide audit
- Large migration
- Security audit
- Diff review across independent lenses
- Repeated workflow that should become a readable and rerunnable script
- Large multi-agent evaluation where results must converge

### Do Not Use Dynamic Workflow For

- Small product questions
- Simple coding tasks
- One-file changes
- Simple PRD drafting
- Routine implementation
- Anything that can be handled by one skill or one agent

### Every Dynamic Workflow Must Define

- workflow goal
- input artifacts
- agent count
- context budget
- approval points
- output artifacts
- stop conditions
- compaction step
- update targets: `project_state`, `decision_log`, `assumption_log`, `risk_log`, `source_log`, `kaizen_log`

---

## Parallel Fanout Conditions

Parallel fanout is forbidden unless **all six** conditions are true:

1. Task branches are independent
2. Scope is explicit
3. Input artifacts are ready
4. Output artifacts are separate
5. Token cost is justified
6. Rika-Chan approves

---

## Kaizen Anti-Patterns (Kai monitors for these)

- Unnecessary agents in a workflow that a single agent could handle
- Repeated context across steps instead of artifact references
- Bloated outputs that summarize the same content multiple times
- Unused or over-loaded sources in context packs
- Overlong sessions that should have been checkpointed
- Parallel fanout used for tasks that are not independent
- Redundant skill loading when the skill is not triggered

> Kaizen log: `logs/kaizen_log.md` (Phase 2)
