---
command: memory-intake
description: Ingest raw notes, sources, or knowledge items into the memory stack with governance metadata.
entry_agent: mira_memory_librarian
context_budget: small
required_input: raw notes, sources, screenshots, or knowledge items from Rika-Chan
optional_input: supporting artifact paths, constraints, risk notes, approval notes; never full chat history
forbidden_actions: bypassing Minori, skipping artifact gates, starting downstream workflows automatically, using large/dynamic context without approval, overwriting existing files without approval
produces: knowledge_intake_note.md → graph_update.md (if no PII block)
approval_gate: PII detected → hard stop; Rika-Chan approval required before graph/wiki write
stop_condition: any restricted-level data triggers immediate stop; no downstream handoff without approval
ref: workflows/memory_intake.md
---

Mira tags every item with privacy_level, emits the graph update, and writes the wiki note. Items
tagged restricted never flow downstream without explicit Rika-Chan approval.
