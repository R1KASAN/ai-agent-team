---
name: codex-implement
version: "1.0"
trust_status: Core
team: codex
invoked_by: coda_codex_builder; /codex-implement
input: codex_task_packet.md; files_likely_affected.md
output: build_report.md
ref: skills/codex/codex-implement/SKILL.md
---

Loads only files_likely_affected.md from the task packet. Makes surgical, scoped changes. High-risk items (auth, payment, db, infra) must be individually approved before implementation. No shell execution beyond the declared task scope. No external calls.
