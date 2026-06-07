# context.md — Studio OS Orientation (read before implementation)

> Stable orientation note for Claude Code. Compact by design. Not a full-system doc.
> Canonical contract: `CLAUDE.md` · Direction: `system_prompt_v1.md` · Usage: `HOW_TO_USE.md`

## What this system is

An **AI-Human Startup Studio OS for a Solo Founder** (owner = Rika-Chan). Its job: turn
**knowledge overflow + saved ideas + unstructured inputs** (notes, links, PDFs, clips, news, trends)
into **insight → decision → next action → ship-ready product artifacts** — while the **human stays
the decision-maker** on everything that matters.

5 jobs: (1) resurface saved knowledge at the right moment · (2) one clear next action when
overwhelmed · (3) daily signal feed → opportunities · (4) thought partner (product/strategy/
business/critical thinking) · (5) validate idea → PRD → build → test → ship.

## Why Phase 1 exists

The team is solid but has three gaps blocking the Goal: no single easy front door, no task-size
awareness (every idea ran the full pipeline → token waste), and memory that didn't compound.
**Phase 1** fixes exactly these and nothing more:

- Upgrade `/idea-gate` into a **universal, size-aware dispatcher** (one command for everything).
- Add **job + weight classification** (tiny → strategic) and `execution_mode` routing.
- Wire a **compounding memory loop** (decision ledger · lessons · instincts · proactive recall).
- Ship **one real JS Dynamic Workflow** as proof (`idea-stresstest.js`); everything else stays spec.

Per-agent output upgrades (viability score, ADR, prototype direction, evaluator loops, etc.) are
**Phase 2+** — explicitly out of scope here.

## Non-negotiable balance rules (Phase 1 must preserve all)

- **Minori-first routing** — every input enters through Minori; nothing acts before the plan.
- **Orchestrator Contract** — 8 fields defined in `workflow_plan.md` before any delegation.
- **Sequential-by-Default** — fan-out/parallel is forbidden unless the six conditions + Rika approve.
- **Human Gates** — Rika-Chan is final authority on strategy, legal, privacy, security, payment,
  deploy, kill/pivot, `dynamic` budget. No agent passes a hard gate autonomously.
- **No-Overwrite Rule** — existing files get a `.draft.md` sibling; owner approves the swap.
- **Token & context economy** — smallest useful workflow; Just-in-Time context only; artifact
  references over pasted content; never dump full chat/repo/vault into a run.

## Dynamic Workflow — not the default

Dynamic Workflow (Claude Code JS, fan-out subagents) is the **highest-cost** path. It is reserved
for **heavy/strategic** work that is genuinely worth the token/context cost, and only **after
Rika-Chan approves `context_budget: dynamic`**. Minori **recommends** it in the plan and **stops**
for approval — it never auto-escalates. Small/medium work always stays sequential or single-agent.

## Backend memory infrastructure (use, don't dump)

Obsidian and Graphify are **backend memory/context infrastructure**. NotebookLM-py is separate:
Nova-V-only deep source reading, gated per command, not memory, not truth. Just-in-Time only:

- **Obsidian** — `[[backlinks]]` + graph layer. Tsumugi *reads* (fallback), Mira *writes*. Holds
  decision ledger, instincts, ideas as linked notes.
- **NotebookLM-py** — **Nova-V only**, **per-command approval every time** (Controlled Operational
  Use). Deep-reads heavy sources *off* the main context to save tokens. Never client PII/secrets.
- **Graphify** — Mira-owned backend graph (entities/relations/clusters via `graph_update.md`).
  Powers proactive recall and decision history. Read by Tsumugi; not loaded wholesale.
