---
name: codex-debug
version: "1.0"
trust_status: Core
team: codex
invoked_by: kyuuei_test_debug; /codex-debug
input: test_report.md with failures; or explicit bug description
output: debug_report.md
ref: skills/codex/codex-debug/SKILL.md
---

Protocol: reproduce → trace → hypothesize → fix minimally. Fix must not exceed task packet scope. Scope-expanding fixes are flagged and held for Rika-Chan approval. Informed by debug-mantra principles (Reference Only — see .claude/skills/debug-mantra/SKILL.md). No external calls.
