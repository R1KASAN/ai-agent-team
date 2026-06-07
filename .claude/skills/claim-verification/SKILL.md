---
name: claim-verification
version: "1.0"
trust_status: Core
team: claude
invoked_by: nova_v
input: verified_evidence_pack.md
output: verified_evidence_pack.md
ref: skills/claude/claim-verification/SKILL.md
---

Labels every claim: FACT / ASSUMPTION / OPINION / UNSUPPORTED / CONTRADICTION / HALLUCINATION_RISK inside Nova-V's verified evidence pack. No claim passes downstream unlabelled. No shell execution. No external calls.
