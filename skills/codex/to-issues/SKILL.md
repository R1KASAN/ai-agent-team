---
name: to-issues
version: "1.0"
trust_status: Core
team: codex
invoked_by: aki_system_architect; coda_codex_builder
input: codex_task_packet.md or pr_summary.md
output: issue list (embedded in task packet or pr_summary.md)
---

# To Issues Skill

Converts task packet items or PR findings into a structured issue list for tracking.

## Protocol

1. Read the source artifact (task packet or PR summary).
2. For each item that requires tracking: extract title, description, severity, and owner.
3. Severity levels: `critical` / `high` / `medium` / `low`.
4. Group by type: bug, improvement, out-of-scope finding, follow-up task.
5. Embed the issue list in the calling artifact under an `issues` section.
6. Do not create issues in any external system (GitHub, Linear, Jira) without explicit Rika-Chan approval.

## Required Fields per Issue

- `id` (sequential), `title`, `description`, `severity`, `type`, `owner`, `source_artifact`

## Forbidden

- Do not push to any external issue tracker without Rika-Chan approval.
- Do not omit critical or high severity findings.
- No external calls.
