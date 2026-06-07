---
name: governance-check
version: "1.0"
trust_status: Core
team: claude
invoked_by: rika_chan_decision_gate; /governance-check
input: any artifact requiring governance review
output: governance_check.md or approval_request.md
template: templates/governance_check.md
---

# Governance Check Skill

Applies the full governance checklist to an artifact. A blocked verdict halts the workflow.

## Protocol

1. Run `governance/data_governance_checklist.md` — all 6 sections.
2. Run `governance/privacy_rules.md` — check privacy_level of every data item.
3. Run `governance/security_guardrails.md` — check for secrets, auth, payment, input validation, data exposure.
4. Assign verdict: `pass` / `conditional_pass` / `blocked`.
5. If `blocked`: write `approval_request.md` with issue description, affected artifact, and proposed remediation. Stop.
6. If `pass` or `conditional_pass`: write `governance_check.md` and apply Kaizen as a token convention at session close.

## Verdict Definitions

- `pass` — no issues found
- `conditional_pass` — minor issues noted; workflow may continue with caveats documented
- `blocked` — hard stop; Rika-Chan must review before workflow resumes

## Forbidden

- Do not continue a blocked workflow.
- Do not suppress PII findings.
- No shell execution. No external calls.
