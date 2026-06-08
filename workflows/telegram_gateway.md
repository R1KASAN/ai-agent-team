---
workflow_id: telegram_gateway
entry_surface: Telegram Bot API / local command adapter
entry_agent: none
routes_to: /idea-gate
runtime_mode: telegram_gateway_v1
version: "1.0"
---

# Workflow: Telegram Gateway v1

## Purpose

Provide a token-safe Telegram inbox, queue, and approval console for the AI Agent Team. Telegram is
an interface layer, not a new agent and not a scheduler. It records compact requests, maps them to
`/idea-gate` payloads, and waits for the manual worker to dispatch approved items. The optional
poller is `scripts/telegram_gateway_poll_once.sh`; it reads Telegram updates and calls
`scripts/telegram_queue.sh` only.

## Operating Rules

- Telegram commands must not invoke an LLM directly.
- `/status`, `/approve`, `/reject`, and `/budget` only read or update queue state.
- No Telegram chat history is used as memory. Store only the current compact payload and artifact
  paths.
- The manual worker processes at most one `approved` queue item per run.
- `large`, `dynamic`, parallel/fanout, webhook daemon, VPS daemon, multi-model router, and automatic
  scheduler are out of scope for v1.

## Command Mapping

| Telegram command | mapped_idea_gate_payload | Default budget_cap | LLM trigger |
|---|---|---:|---|
| `/idea <text>` | `command: /idea-gate`, `job_hint: idea-debate`, `payload_ref: runtime/queue/<run_id>.md#payload` | `small` | no |
| `/ask yuki <question>` | `command: /idea-gate`, `job_hint: consult`, `target_agent: yuki`, `payload_ref: runtime/queue/<run_id>.md#payload` | `tiny` | no |
| `/status` | queue/status read only | n/a | no |
| `/approve <run_id>` | state update only | unchanged | no |
| `/reject <run_id>` | state update only | unchanged | no |
| `/budget <run_id> tiny\|small\|medium` | budget update only | requested value | no |

Other named-agent consults may use `/ask <agent-key> <question>` if the target exists in the active
agent roster. Build-bearing, strategic, or gate-triggering asks must be redirected to full
`/idea-gate`.

## Queue Item Schema

Queue items live at `runtime/queue/<run_id>.md`, one file per request.

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

Allowed `queue_state` values: `queued`, `needs_approval`, `approved`, `running`, `blocked`,
`complete`, `rejected`.

Allowed `budget_cap` values in v1: `tiny`, `small`, `medium`. `medium` requires `/budget <run_id>
medium` plus `/approve <run_id>`. `large` and `dynamic` are blocked and must return to the normal
Rika-Chan gate.

## Approval-First Behavior

High-risk inputs are marked `needs_approval` before any worker run. High-risk domains include auth,
payments, database, infrastructure, hosting, production deploy, paid API/tool usage, privacy,
security, legal, and client/user-facing messages.

If a run exhausts or exceeds its budget cap, mark it `blocked` and return this Telegram-safe message:

`run นี้หมด budget แล้ว; ใช้ /budget <run_id> medium แล้ว /approve <run_id> ถ้าต้องการให้ต่อ`

## Worker Lifecycle

Run one foreground worker pass:

```bash
bash scripts/telegram_worker_run_once.sh
```

Optional Telegram poll pass:

```bash
TELEGRAM_BOT_TOKEN=... TELEGRAM_ALLOWED_USER_ID=... bash scripts/telegram_gateway_poll_once.sh
```

The poller stores only an offset at `runtime/telegram_gateway_offset` and must not store bot tokens,
secrets, full chat history, or LLM output.

The worker:

1. Finds the oldest `approved` queue item.
2. Marks it `running`.
3. Writes a dispatch artifact for the Claude/Codex session.
4. Writes/updates `logs/runtime_status.md`.
5. Writes one `logs/agent_runs/` audit entry.
6. Marks the queue item `complete` or `blocked`.

If no approved work exists, it prints a pending summary and exits without calling any LLM.
