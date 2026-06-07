---
version: "1.0"
authority: Rika-Chan
---

# Approval Gates

Rika-Chan must approve **before** any of the following. No agent may proceed past these gates autonomously.

## Product and Strategy

- [ ] Final product direction or idea kill/pivot
- [ ] Pricing or revenue model decision
- [ ] Roadmap decision
- [ ] Business model change

## Financial and Commercial

- [ ] Paid API or paid tool usage
- [ ] Any spend or subscription commitment

## Production and Infrastructure

- [ ] Production deployment
- [ ] Auth system changes
- [ ] Payment system changes
- [ ] Database schema or migration changes
- [ ] Infrastructure changes (cloud, servers, containers)
- [ ] DNS, SSL, reverse proxy, or firewall changes

## Legal, Privacy, and Security

- [ ] Privacy-sensitive decisions
- [ ] Security-sensitive decisions
- [ ] Legal decisions
- [ ] Client or user-facing messages (real send)

## Data and Sources

- [ ] Deleting or moving raw source data
- [ ] Importing large source batches (10+ sources)
- [ ] Using sensitive or personally identifiable data

## Skills and Automation

- [ ] Running untrusted skills (not yet Core status)
- [ ] Installing or cloning third-party skill repositories

## Workflow and Context

- [ ] Parallel / fanout workflow that may consume high tokens
- [ ] Context budget escalation to `large` or `dynamic`
- [ ] Overwriting any existing project file

---

## How to Request Approval

Minori must produce an `approval_request.md` artifact that includes:

- which gate is triggered
- why it is triggered
- proposed action
- risk level
- what happens if denied

> See handoff template: `handoffs/handoff_template.md`
