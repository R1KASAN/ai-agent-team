---
name: codex-pr
version: "1.0"
trust_status: Core
team: codex
invoked_by: coda_codex_builder; /codex-pr
input: security_check.md with pass or conditional_pass verdict
output: pr_summary.md
ref: skills/codex/codex-pr/SKILL.md
---

Cannot start if Kyuuei security check returned a blocked verdict. Produces pr_summary.md with changed files, test evidence, security check result, and risk notes. Coda never merges. No external calls.
