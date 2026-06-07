---
command: recall
description: Resurface saved knowledge from the memory graph at the right moment — anti-overwhelm.
entry_agent: minori_lead_conductor
executing_agent: tsumugi_second_brain
route: Mi→Ts
context_budget: small
core_flow: true
required_input: a topic, question, or current-context cue from Rika-Chan
optional_input: time hint ("3 weeks ago"), tag/domain filter, supporting artifact paths; never full chat history
forbidden_actions: bypassing Minori, flooding or forcing resurfaced items, exposing restricted/PII memory without approval, starting downstream workflows automatically, using large/dynamic context without approval, overwriting existing files without approval
produces: resurface_pack.md  (output code: rp)
approval_gate: any item tagged restricted/PII → hard stop; Rika-Chan approval required before surfacing
stop_condition: relevant items surfaced softly with WHY-RELEVANT-NOW framing; no flood, no force
ref: system_prompt_v1.md  (Tsumugi persona)
---

Triggered by "เคยเซฟ..." / "มีอะไรเกี่ยวกับ..." / `/recall`. Minori gates, Tsumugi executes.
Tsumugi resurfaces from the **knowledge graph Mira builds** (not flat tag search), connecting the
current topic to past saves: "you saved something about this — want me to pull it?" Gentle, never pushy.

## Governance
- Privacy: memory items tagged `restricted` never surface without explicit Rika-Chan approval.
- Memory layer: reads the graph (Graphify/Obsidian) as backend infra — see CLAUDE.md Memory Layer.
- Anti-overwhelm: surface relevant threads only; no flood (Job 1 of the OS).
