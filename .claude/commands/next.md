---
command: next
description: One clear next action when the mind is full or stuck.
entry_agent: minori_lead_conductor
executing_agent: ichika_next_action
route: Mi→Ic
context_budget: tiny
core_flow: true
required_input: a "stuck" / overwhelmed / "ทำอะไรดี" signal, or current state from Rika-Chan
optional_input: active goals, current blockers, supporting artifact paths; never full chat history
forbidden_actions: bypassing Minori, returning a long list instead of one action, starting downstream workflows automatically, using large/dynamic context without approval, overwriting existing files without approval
produces: a single recommended next action (no heavy artifact; logged inline)
approval_gate: none; the recommended action runs only on Rika-Chan's go
stop_condition: exactly one clear next action returned; nothing auto-executes
ref: system_prompt_v1.md  (Ichika persona)
---

Triggered by "ทำอะไรดี" / overwhelmed / stuck / `/next`. Minori gates, Ichika executes.
Ichika cuts through a full mind and returns **one** action — not a backlog, not a menu. Decisive and
calm. The owner decides whether to act on it.

## Governance
- Scope: advisory only; never triggers strategic/financial/build steps without a separate gated command.
- Anti-overwhelm: single-action output enforced (Job 2 of the OS).
