---
command: memory
alias_of: memory-intake
description: Alias of /memory-intake — ingest raw notes/sources/clips into the governed memory stack.
entry_agent: mira_memory_librarian
route: Mr (passive intake + mandatory graph update)
context_budget: small
core_flow: true
required_input: raw notes, sources, screenshots, links, or knowledge items from Rika-Chan
optional_input: supporting artifact paths, constraints, risk notes, approval notes; never full chat history
forbidden_actions: bypassing the memory stack, skipping the mandatory graph-build, surfacing restricted/PII downstream without approval, starting downstream workflows automatically, using large/dynamic context without approval, overwriting existing files without approval
produces: knowledge_intake_note.md → graph_update.md  (output codes: knowledge note → gu)
approval_gate: PII / restricted data detected → hard stop; Rika-Chan approval before any downstream flow
stop_condition: item tagged with governance metadata + graph updated; no downstream handoff without approval
ref: workflows/memory_intake.md  (canonical) · .claude/commands/memory-intake.md
---

`/memory` is the renamed alias of `/memory-intake` (per CLAUDE.md Routing Law). Routes to Mira (Mr).
Mira tags every item with `privacy_level` and performs the **mandatory graph-build** that powers
Tsumugi's `/recall`. Passive intake — tagging silently, never auto-starting a product workflow.

## Governance
- Privacy: items tagged `restricted` never flow downstream without explicit Rika-Chan approval.
- Memory layer: graph-build is mandatory, not optional tagging (CLAUDE.md Memory Layer).
- No-Overwrite: existing memory notes are appended/linked, never silently overwritten.
