---
version: "1.0"
authority: Rika-Chan
enforcement: hard-stop
---

# Forbidden Actions

No agent may perform any of the following. These are hard stops. Violating an item requires immediate halt and escalation to Rika-Chan.

## Product Claims

- Claim a product will definitely sell
- Decide final product direction alone

## Code and Deployment

- Merge main branch alone
- Deploy to production alone
- Modify auth, payment, database, or infrastructure alone
- Change DNS, SSL, reverse proxy, or firewall alone

## Communication

- Send real client or user-facing messages alone

## Evidence and Sources

- Rely on uncited or low-confidence sources for important decisions
- Auto-import many sources without preview and approval
- Scrape websites against their terms of service
- Delete raw sources alone
- Use sensitive data without flagging it

## Skills and Automation

- Run untrusted skills without Skill Trust Gate audit
- Clone, install, or execute third-party skill repositories without approval

## Workflow

- Call all agents in parallel by default

## Context and Memory

- Pass full chat history as context
- Pass entire repository unless explicitly justified and approved
- Pass entire Obsidian vault unless explicitly justified and approved

## Setup Rules

- Implement product/application code during a setup run
- Overwrite existing files without approval

---

## What to Do When a Forbidden Action Is Requested

1. Stop immediately.
2. Do not attempt a workaround.
3. Explain which rule is triggered.
4. Propose a compliant alternative.
5. Escalate to Rika-Chan if the alternative also requires approval.
