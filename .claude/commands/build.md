---
command: build
description: Build a defined task end-to-end through the Codex team — task packet → code → test → (UX if UI) → ship gate.
entry_agent: aki_system_architect
route: Ak→Co→QA→(Te if UI)→[Ri]
context_budget: small
core_flow: true
precondition: a product_brief (pb) OR an owner-defined task must already exist — `/build` does not run on a bare idea
required_input: an approved product_opportunity_brief / PRD, or an explicit owner-defined task spec
optional_input: codex_task_packet path, constraints, acceptance criteria, risk notes; never full chat history
forbidden_actions: bypassing Minori for new ideas, starting without a pb or owner task, skipping tests, deploying production, modifying auth/payment/database/infrastructure without approval, using large/dynamic context without approval, overwriting existing files without approval, inventing agents
produces: codex_task_packet (tp) → build_report → test_report (tr) → (qa_ux_report (ur) if UI) → ship_check
approval_gate: Rika-Chan ship/deploy gate before any deployment; any security/privacy/payment flag → Rika-Chan hard gate
stop_condition: tests must pass before ship-check; ship-check best verdict = ready_pending_approval; deployment is a human decision
ref: workflows/codex_build_loop.md · workflows/prd_to_codex_tasks.md
---

Build flow (Job 5, build half). Precondition enforced: a product_brief (`pb`) or an owner-defined task
must exist — `/build` never starts from a bare idea (use `/idea` or `/idea-gate` first for new ideas).

Sequence: `Ak → Co → QA → (Te if has_ui_component) → [Ri ship gate]`
- **Ak (Aki)** translates the brief/task into a `codex_task_packet` (numbered steps + acceptance criteria).
- **Co (Coda)** implements scoped, minimal code (`/codex-implement`).
- **QA (Kyuuei)** writes + runs tests, loops test→fail→debug→retest until green (`/codex-test`).
- **Te (Tessa)** — conditional, UI only — verifies UX flows + acceptance criteria after Kyuuei.
- **[Ri] Rika-Chan** — ship/deploy hard gate. Deployment is always a human decision.

## Governance
- Sequential-by-default: no parallel fanout unless six conditions + Rika-Chan approval.
- Artifact Gate: each step requires its input artifact before proceeding — no skipping.
- Security check (`/codex-security-check`, Kyuuei backend) runs before ship on any sensitive surface.
- Requirement Override: tests are never skipped to satisfy a speed request.
