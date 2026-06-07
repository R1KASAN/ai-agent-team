---
name: to-issues
version: "1.0"
trust_status: Core
team: codex
invoked_by: aki_system_architect; coda_codex_builder
input: codex_task_packet.md or pr_summary.md
output: issue list (embedded in task packet or pr_summary.md)
ref: skills/codex/to-issues/SKILL.md
---

Converts task packet items or PR findings into a structured issue list with title, description, and severity. Does not create issues in any external system without explicit Rika-Chan approval. No external calls.
