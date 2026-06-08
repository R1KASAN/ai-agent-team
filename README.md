---
project: AI-Human Startup Studio OS
version: "1.0"
phase: 1
owner: Rika-Chan
---

# AI-Human Startup Studio OS

A structured AI Agent Team system for converting scattered knowledge into validated product ideas, PRDs, MVP scopes, Codex implementation tasks, and improvement loops.

This project is a **hierarchical multi-agent orchestrator**: Minori routes work through specialized
agents, sequential handoffs are the default, and dynamic/parallel workflows require Rika-Chan
approval.

> Architecture diagrams: `AI_AGENT_TEAM_ARCHITECTURE.md`

---

## What This System Does

- Routes input through Input Gatekeeper (Minori) to the correct workflow
- Tracks workflow status with Level 1 Runtime (`runtime_tracking` + `logs/runtime_status.md`)
- Supports Telegram Gateway v1 as an approval-first inbox/queue interface to `/idea-gate`
- Challenges, validates, and plans product ideas before any build starts
- Enforces sequential handoff: each agent produces an artifact before the next starts
- Requires Gate Scope Pre-Clarification before any Aki/build path
- Keeps token and context usage low via Context Packs and Handoff Artifacts
- Requires Rika-Chan approval for all strategic, financial, legal, and production decisions

---

## Two Teams

| Team | Purpose | Must Not |
|------|---------|----------|
| Claude Team (14 agents) | Think, debate, validate, plan | Be the main coding labor |
| Codex Team (7 agents) | Implement, test, debug, ship | Decide product strategy |

> Agent roster: `agents/agent_cards.md`

---

## Memory Stack

```
Raw Inbox → Graphify (entity/relation graph) → Obsidian Vault (human-readable)
→ NotebookLM (source-grounded reading) → Context Pack → Agent Handoff
```

---

## How to Start

1. Clone the repo and enter the folder:

```bash
git clone https://github.com/R1KASAN/ai-agent-team.git
cd ai-agent-team
bash scripts/clone_ready_check.sh
```

2. Open this repo in Claude Code
3. Run: `/idea-gate`
4. Describe your input — Minori will classify it and produce a Workflow Plan
5. Review `workflow_plan.md` before any agent proceeds
6. Confirm `runtime_tracking.runtime_mode: level_1_status_only` is present for logged workflows
7. For Aki/build paths, confirm `expected_gates` and `gate_decisions` exist before technical planning

Optional Telegram Gateway v1 helpers:

```bash
bash scripts/telegram_queue.sh enqueue --user-id local --message-id 1 --text '/ask yuki challenge this'
bash scripts/telegram_queue.sh status
bash scripts/telegram_queue.sh approve <run_id>
bash scripts/telegram_worker_run_once.sh
```

Telegram v1 is an inbox + approval queue only. It does not run a webhook/VPS daemon and does not
invoke an LLM from `/status`, `/approve`, `/reject`, or `/budget`.

Optional Telegram polling:

```bash
TELEGRAM_BOT_TOKEN=... TELEGRAM_ALLOWED_USER_ID=... bash scripts/telegram_gateway_poll_once.sh
```

> New machine setup: `CLONE_QUICKSTART.md`

---

## Workflow Index

> `workflows/workflow_index.md`
> Architecture map: `AI_AGENT_TEAM_ARCHITECTURE.md`

Core workflows: `idea_gate` → `product_idea_debate` → `evidence_crosscheck` → `product_idea_to_prd` → `prd_to_codex_tasks` → `codex_build_loop` → `qa_review`

---

## Key Rules

- Sequential handoff is the default. Parallel requires Rika-Chan approval.
- Level 1 Runtime is status-only: `logs/runtime_status.md` records run status and artifact paths,
  not a scheduler, fanout controller, or extra agent.
- Telegram Gateway v1 is approval-first: queue files live in `runtime/queue/`, budget caps are
  `tiny|small|medium`, and Telegram chat is not long-chat memory.
- No agent may proceed without its required input artifact.
- No Aki/build handoff may proceed without Expected Gates + Pre-Decide vs Defer in `workflow_plan.md`.
- No product code in setup runs.
- No third-party skill installed without Skill Trust Gate + approval.
- No file overwritten without approval.

> Full contract: `CLAUDE.md`
> Approval gates: `governance/approval_gates.md`
> Forbidden actions: `governance/forbidden_actions.md`
> Clone readiness: `CLONE_QUICKSTART.md`

---

## Setup Status

Phase 1-3 setup is complete. Current clone/runtime readiness is checked by
`scripts/clone_ready_check.sh`, and active system alignment is checked by
`scripts/validate_active_alignment.sh`.

> Full setup history: `setup_validation_checklist.md`
