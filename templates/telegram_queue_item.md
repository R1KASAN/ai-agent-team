---
template: telegram_queue_item
version: "1.0"
runtime_mode: telegram_gateway_v1
---

# Telegram Queue Item Template

```yaml
run_id: run-tg-YYYYMMDD-HHMMSS-NNN
telegram_user_id: ""
telegram_message_id: ""
telegram_command: "/idea"
mapped_idea_gate_payload: "command=/idea-gate; job_hint=idea-debate; target_agent=; payload_ref=runtime/queue/<run_id>.md#payload"
job_hint: "idea-debate"
target_agent: ""
budget_cap: small
requires_approval: false
approval_state: none
queue_state: queued
latest_artifact: ""
created_at: ""
updated_at: ""
```

Allowed `queue_state`: `queued`, `needs_approval`, `approved`, `running`, `blocked`, `complete`,
`rejected`.

Allowed `budget_cap`: `tiny`, `small`, `medium`.

Rules:

- Store compact payload only.
- Do not store full Telegram chat history.
- Do not store secrets, tokens, PII, or source bodies.
- `/status`, `/approve`, `/reject`, and `/budget` must not invoke an LLM.
