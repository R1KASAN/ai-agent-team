---
command: kaizen-review
description: Review artifact list for token waste, redundancy, and workflow simplification opportunities.
entry_agent: minori_lead_conductor
context_budget: tiny
required_input: artifact list from the current workflow cycle (not full artifact content)
optional_input: supporting artifact paths, constraints, risk notes, approval notes; never full chat history
forbidden_actions: bypassing Minori, skipping artifact gates, starting downstream workflows automatically, using large/dynamic context without approval, overwriting existing files without approval
produces: kaizen_report.md
approval_gate: none; improvements proposed, not auto-applied
stop_condition: kaizen_report.md produced; no changes applied without Rika-Chan review
ref: workflows/kaizen_review.md
---

The kaizen pass reviews the artifact list only — never full content. Context budget is tiny.
Findings go into kaizen_report.md as proposals; Minori or Rika-Chan decides which to apply.
