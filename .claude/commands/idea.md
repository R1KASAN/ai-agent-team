---
command: idea
description: Full product pipeline — validate idea → debate → evidence → strategy → business → opportunity brief → build → ship.
entry_agent: minori_lead_conductor
route: Mi→Yu→NV→So→Bu→Po→[Ri]→Ak→Co→QA→(Te if UI)→[Ri]
context_budget: small
core_flow: true
required_input: a product/project idea or concept from Rika-Chan
optional_input: constraints, target user notes, supporting artifact paths, prior briefs; never full chat history
forbidden_actions: bypassing Minori, parallel fanout without approval, skipping the POB approval gate, skipping validation to satisfy speed, inventing agents, using large/dynamic context without approval, overwriting existing files without approval
produces: workflow_plan → idea_challenge_brief → verified_evidence_pack → strategic_lens → business_analysis_brief → product_opportunity_brief → [Ri gate] → codex_task_packet → build_report → test_report → (qa_ux_report if UI) → [Ri ship gate]
approval_gate: Rika-Chan must approve product_opportunity_brief before any PRD/build; plus all strategic/legal/privacy/payment/deploy gates
stop_condition: Sora kill-signal → stop · Bumi not_viable → stop · POB requires approval before build · ship requires Rika-Chan gate
ref: workflows/product_idea_debate.md · .claude/commands/idea-pipeline.md
---

Full end-to-end pipeline (Job 5 of the OS). Minori gates first, then sequential handoff:
`Mi → Yu → NV → So → Bu → Po → [Ri APPROVAL] → Ak → Co → QA → (Te if has_ui_component) → [Ri SHIP]`.

Nova-V (NV) runs the merged evidence+verify step (loop ≤2). Tessa (Te) is conditional — routed only
when the build has a UI component, after Kyuuei. For the think-only debate portion in one
conversational session with checkpoint menus, use `/idea-pipeline` instead.

## Hard Gates (always stop regardless of pace)
- `strategic_lens` verdict = `kill` → halt before Bumi; Rika-Chan decides.
- `business_analysis_brief` verdict = `not_viable` → halt before Poom; Rika-Chan decides.
- `product_opportunity_brief` complete → Rika-Chan must approve before Aki begins (PRD/build).
- Build → ship → Rika-Chan ship/deploy gate.

## Governance
- Sequential-by-default: no parallel fanout unless all six conditions + Rika-Chan approval.
- Agent Registry Lock: no invented agents; archived agents are backend functions only.
- Requirement Override: rules win over speed requests — validation is never skipped.
