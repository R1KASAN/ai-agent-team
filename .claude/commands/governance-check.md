---
command: governance-check
description: Run a governance, privacy, legal, and source-quality review on any artifact.
entry_agent: minori_lead_conductor → rika_chan_decision_gate
context_budget: small
required_input: any artifact requiring governance review
optional_input: supporting artifact paths, constraints, risk notes, approval notes; never full chat history
forbidden_actions: bypassing Minori, skipping artifact gates, starting downstream workflows automatically, using large/dynamic context without approval, overwriting existing files without approval
produces: governance_check.md or approval_request.md
approval_gate: approval_request.md automatically triggers Rika-Chan review before workflow continues
stop_condition: blocked verdict halts the current workflow entirely
ref: workflows/governance_check.md
---

Can be run standalone or embedded in any workflow. A blocked verdict stops everything. Governance is
enforced by Rika-Chan hard gates and the `governance/` docs; `approval_request.md` describes the
issue and the workflow resumes only after Rika-Chan clears it.
