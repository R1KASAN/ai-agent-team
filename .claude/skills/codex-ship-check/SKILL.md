---
name: codex-ship-check
version: "1.0"
trust_status: Core
team: codex
invoked_by: kyuuei_test_debug; /codex-ship-check
input: pr_summary.md
output: ship_check.md
ref: skills/codex/codex-ship-check/SKILL.md
---

Runs pre-ship checklist: build, tests, lint, UX, security. Best possible verdict is ready_pending_approval. Kyuuei never deploys. Deployment is always a Rika-Chan decision. No external calls.
