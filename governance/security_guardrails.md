---
version: "1.0"
maintained_by: Gina Governance Guardian + Seco Codex Security Checker
authority: Rika-Chan
---

# Security Guardrails

These guardrails apply to all agents, all workflows, and all artifacts. Non-negotiable.

---

## 1. Secrets and Credentials

- No agent may request, store, log, or pass credentials, API keys, tokens, or secrets in any artifact.
- If a secret is found in any artifact or file → hard stop; flag in `logs/risk_log.md`; escalate to Rika-Chan.
- `.env` files, credential files, and key stores must never be included in context packs, handoffs, or evidence packs.
- Skills must be rejected if they request credential access (`skill_trust_gate.md` criterion 4).

---

## 2. Auth, Payment, Database, and Infrastructure

Any change to the following requires Rika-Chan approval before Codex implements:

- Authentication systems (login, session, token, OAuth, SSO)
- Payment systems (Stripe, payment gateway, billing logic)
- Database schema or migrations
- Infrastructure (cloud config, containers, servers)
- DNS, SSL certificates, reverse proxy, firewall rules

Aki must flag these in `codex_task_packet.md` under `approval_gates`. Coda must not implement them until approved.

---

## 3. Input Validation

- All user-facing inputs must be validated at system boundaries.
- Agents must not generate code that trusts raw user input without validation.
- Seco must flag any input path lacking validation as a `security_check` finding.

---

## 4. Data Exposure

- No agent may write code that exposes internal data structures, stack traces, or error details to end users.
- API responses must not include fields beyond what is required by the acceptance criteria.
- Seco must flag over-exposure as a `security_check` finding.

---

## 5. Dependency and Supply Chain

- Third-party dependencies must be reviewed by Seco before inclusion.
- Dependencies from unknown or low-credibility sources → flag; Rika-Chan approval before use.
- Skills from third-party repositories must pass `llm_wiki/skill_trust_gate.md` before execution.
- No automatic installation of packages, plugins, or skills.

---

## 6. Production Safety

- No agent may deploy to production without Rika-Chan approval.
- No agent may merge to the main branch alone.
- No agent may modify production configuration without an approved `codex_task_packet.md` and Rika-Chan sign-off.
- Shippo's `ship_check.md` is a pre-condition for deployment consideration — not a deployment authorisation.

---

## 7. Skill and Automation Safety

- Skills must not execute shell commands or network requests not declared in their `SKILL.md`.
- Skills must not access files outside their declared scope.
- Any skill that requests credential access, performs hidden network calls, or runs destructive operations → reject; mark `Rejected` in `llm_wiki/skill_trust_gate.md`.

---

## 8. Security Incident Response

If a security issue is found in a live artifact or deployed system:

1. Stop the relevant workflow immediately.
2. Flag in `logs/risk_log.md` with `severity: high`.
3. Do not attempt to fix without Rika-Chan awareness.
4. Produce an `approval_request.md` describing the issue and proposed remediation.
5. Wait for Rika-Chan approval before remediation begins.

---

## Research Backing

- Claude Code agentic safety: `https://arxiv.org/abs/2604.14228`
- Skill security audit (SkillProbe): `https://arxiv.org/abs/2603.21019`
- Credential leakage in skills: `https://arxiv.org/abs/2604.03070`
- Emerging skill ecosystem threats: `https://arxiv.org/abs/2605.28588`

---

> Authority: `governance/approval_gates.md`
> Enforcement: Gina Governance Guardian · Seco Codex Security Checker
> Skill gate: `llm_wiki/skill_trust_gate.md`
