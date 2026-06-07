---
command: codex-implement
description: Implement a scoped task from an approved Codex task packet.
entry_agent: coda_codex_builder
context_budget: small
required_input: approved codex_task_packet.md; files_likely_affected.md
optional_input: supporting artifact paths, constraints, risk notes, approval notes; never full chat history
forbidden_actions: bypassing Minori, skipping artifact gates, starting downstream workflows automatically, using large/dynamic context without approval, overwriting existing files without approval, deciding product strategy, editing out-of-scope files, deploying production, modifying auth/payment/database/infrastructure without approval
produces: build_report.md
approval_gate: task packet must be Rika-Chan-approved; auth/payment/db/infra items must be individually cleared
stop_condition: build_report.md produced; routes to /codex-test
ref: workflows/codex_build_loop.md
---

Coda loads only files_likely_affected.md — no broad context loading. Changes are surgical and scoped to the task packet. High-risk items flagged in approval_gates must not be implemented until cleared.
