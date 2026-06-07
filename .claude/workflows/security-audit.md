---
workflow: security-audit
status: stub_only
type: dynamic
activation_requires: Rika-Chan approval
ref: workflows/security_audit.md
---

# Security Audit — STUB ONLY

**This workflow is not active and must not be run.**

Status `stub_only` means: no agent may invoke this workflow, no step may be executed, and no output artifact will be produced until Rika-Chan explicitly approves activation.

## Intended Scope (not yet designed)

- Full codebase or feature-level security audit
- Multi-lens: Kyuuei security backend check + Rika-Chan governance gate + optional external review
- Produces: security_audit_report.md

## Activation Requirements

- [ ] Workflow fully designed in `workflows/security_audit.md`
- [ ] Rika-Chan reviews and approves design
- [ ] Status updated from `stub_only` to `active` in both this file and `workflows/security_audit.md`

> Do not remove or modify this stub without Rika-Chan approval.
