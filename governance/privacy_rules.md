---
version: "1.0"
maintained_by: Gina Governance Guardian
authority: Rika-Chan
---

# Privacy Rules

These rules apply to all agents, all workflows, and all artifacts. Non-negotiable.

---

## 1. Privacy Levels

| Level | Definition | Handling |
|-------|-----------|---------|
| `public` | Freely available; no restrictions | Standard use |
| `internal` | Project-internal only; not for external sharing | Do not share outside project |
| `sensitive` | Client data, personal context, or commercially sensitive | Flag on intake; Gina reviews before use |
| `restricted` | PII, health, financial, or legally protected data | Hard stop; Rika-Chan approval required before any use |

---

## 2. PII Rules

- Any personally identifiable information (name, email, phone, address, ID number, biometric) must be flagged `privacy_level: restricted` immediately on detection.
- PII must not pass from Mira to Graphy or any downstream agent without Rika-Chan approval.
- PII must not appear in context packs, handoff artifacts, or evidence packs in identifiable form.
- If PII is required for a legitimate workflow step, Rika-Chan must approve the specific use case and scope.

---

## 3. Client Data Rules

- Any data originating from a client or user of Rika-Chan's products or services is `privacy_level: sensitive` at minimum.
- Client data must not be used in evidence packs, LLM Wiki, or training inputs without explicit consent and Rika-Chan approval.
- Client data must not be passed to third-party tools (NotebookLM, external APIs) without confirming the tool's data handling terms and Rika-Chan approval.

---

## 4. Data Minimisation

- Agents must load only the minimum data required for their step.
- Context packs must not include personal data that is not needed for the current workflow step.
- Source logs must record what was accessed, not reproduce full personal data content.

---

## 5. Sensitive Domain Escalation

Always escalate to Rika-Chan before proceeding when the artifact or decision involves:

- Health or medical data
- Financial account or transaction data
- Legal documents or proceedings
- Authentication credentials or secrets
- Payment information
- Government-issued identifiers

---

## 6. Third-Party Tool Privacy

Before passing any data to an external tool (NotebookLM, web search, APIs):

- [ ] Confirm data does not contain PII or `restricted`-level content
- [ ] Confirm tool's data retention and privacy terms are acceptable
- [ ] Log the tool use in `logs/source_log.md`
- [ ] Rika-Chan approval required if data is `sensitive` or `restricted`

---

## 7. Violation Response

If a privacy rule is violated or a violation is suspected:

1. Stop the workflow immediately.
2. Do not pass the artifact to the next agent.
3. Flag the violation in `logs/risk_log.md`.
4. Escalate to Rika-Chan before resuming.

---

> Authority: `governance/approval_gates.md`
> Enforcement: Gina Governance Guardian
> Checklist: `governance/data_governance_checklist.md`
