---
artifact: telegram_gateway_dispatch
runtime_mode: telegram_gateway_v1
run_id: run-tg-20260608-092750-1002
source_queue_item: runtime/queue/run-tg-20260608-092750-1002.md
telegram_command: "/ask"
job_hint: "consult"
target_agent: "yuki"
budget_cap: tiny
created_at: "2026-06-08T09:28:43+0700"
llm_invoked: false
---

# Telegram Gateway Dispatch

This v1 worker dispatches the approved Telegram queue item into a compact  handoff. It
does not invoke an LLM automatically.

## Mapped Payload

```text
command=/idea-gate; job_hint=consult; target_agent=yuki; payload_ref=runtime/queue/run-tg-20260608-092750-1002.md#payload
```

## Paste Into Claude/Codex Session

```text
/idea-gate challenge daily signal feed
```

## Payload

```text
challenge daily signal feed
```
