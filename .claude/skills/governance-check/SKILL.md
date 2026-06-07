---
name: governance-check
version: "1.0"
trust_status: Core
team: claude
invoked_by: gina_governance_guardian; /governance-check
input: any artifact requiring governance review
output: governance_check.md or approval_request.md
ref: skills/claude/governance-check/SKILL.md
---

Applies governance/data_governance_checklist.md and privacy_rules.md to an artifact. Blocked verdict halts the workflow. Approval_request.md is produced on any PII, legal, or security flag. No shell execution. No external calls.
