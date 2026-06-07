---
version: "2.0"
phase: 1
---

# Workflow Index  (v2.0 — Startup Studio OS v1.0)

Every input enters via **Minori**. Canonical front door: `/idea-gate [anything]`.
Optional shortcuts remain available for known routes, but `/idea-gate` is the single default UX.
Minori classifies input and routes to the correct workflow or specialist. No agent acts before
Minori assigns the workflow.

This is a hierarchical multi-agent orchestrator: Minori coordinates specialized agents, sequential
handoff is the default, and dynamic/parallel workflow requires Rika-Chan approval.

## Level 1 Runtime Status Layer

Level 1 Runtime is active as a status-only layer. It records task queue/status, run_status, and
artifact_return as compact artifact paths in `logs/runtime_status.md`.

- Runtime mode: `level_1_status_only`.
- Template: `templates/runtime_status.md`.
- It does not spawn agents, schedule tasks, enable parallel/fanout, or change routing.
- For `/idea-gate` beyond pure classification, Minori records `runtime_tracking` in
  `workflow_plan.md` and updates the runtime status row.

## Canonical Front Door + Optional Shortcuts

| Slash Command | Route | Purpose | Key Output |
|---------------|-------|---------|-----------|
| `/idea-gate` | Mi | Canonical front door: classify any input, produce Workflow Plan | `workflow_plan.md` (wp) |
| `/idea` | Mi→Yu→NV→So→Bu→Po→[Ri]→Ak→Co→QA→(Te if UI)→[Ri] | Full validate→PRD→build→ship pipeline | `product_opportunity_brief.md` (pb) → shipped artifact |
| `/build [task]` | Ak→Co→QA→(Te if UI)→[Ri] | Build from existing pb / owner task | `build_report.md` → ship gate |
| `/memory [note]` | Mr | Passive intake + mandatory graph-build (alias of `/memory-intake`) | `knowledge_intake_note.md` → graph_update (gu) |
| `/scout` | Mi→Hi | Daily signal feed (≤3 signals) | `daily_signal_brief.md` (ds) |
| `/recall` | Mi→Ts | Resurface saved knowledge from the graph | `resurface_pack.md` (rp) |
| `/next` | Mi→Ic | One clear next action | single action |

> Commands below `/idea-gate` are optional shortcuts/utilities. They do not replace the canonical
> front door and still obey Minori-first routing, artifact gates, and approval gates.

## Proposed Knowledge Channel (not active until separately approved)

| Proposed Slash Command | Proposed Owner | Purpose | Write Policy |
|------------------------|----------------|---------|--------------|
| `/ask` | Tsumugi | Read-only Q&A over `knowledge/README.md` → selected notes → graph/backlinks fallback | No writes |
| `/maintain` | Mira | Merge/split/index/update governed knowledge notes | Writes only after path listing + approval |
| `/check` | Nova-V | Contradiction/source check over selected notes and sources | No `knowledge/` writes; NotebookLM-py gated |
| `/outputs` | Minori-routed owner | Generate briefs/plans/summaries from knowledge | Draft artifacts only; source claims need Nova-V verification |

Files required before activation: `.claude/commands/{ask,maintain,check,outputs}.md` and
`workflows/knowledge_{ask,maintain,check,outputs}.md`.

## Agent Run Logging

Workflow-level runtime status is tracked separately in `logs/runtime_status.md`. Agent-level audit
logs remain under `logs/agent_runs/`.

Write run logs to `logs/agent_runs/` with `templates/agent_run_log.md`.

Required fields: `run_id`, `agent`, `command`, `mode`, `files_read`, `files_written`,
`sources_used`, `approval_gates_hit`, `notebooklm_mission_info`, and `final_artifact_paths`.

Workflows that must log:

| Workflow / Command | Logging trigger |
|--------------------|-----------------|
| `/idea-gate` | Any route beyond pure classification, any approval gate, or any downstream handoff |
| `/memory` / `memory_intake` / `memory_consolidate` | Any `knowledge/` write, graph update, merge, split, or privacy gate |
| `/research` / `/evidence-crosscheck` | Every verified evidence run and every source list used |
| NotebookLM-py mission | Every install/login/add-source/query/export attempt, approved or blocked |
| `/idea` / `product_idea_debate` | Every full validation pipeline run |
| `/build` / `codex_build_loop` | Every build/test/security/ship chain |
| `/governance-check` / `/codex-security-check` | Every blocked, conditional, or high-stakes finding |
| Dynamic Workflow stubs | Every activation attempt and every approved dynamic run |
| Proposed `/ask` `/maintain` `/check` `/outputs` | Required if those commands are separately activated |

## Classified Workflows (think / validate / build)

| Workflow ID | Slash Command | Entry Agent | Key Output |
|-------------|--------------|-------------|-----------|
| `idea_gate` | `/idea-gate` | Minori | `workflow_plan.md` |
| `product_idea_debate` | `/product-idea-debate` | Minori → Yuki | `idea_challenge_brief.md` + `product_opportunity_brief.md` |
| `evidence_crosscheck` | `/evidence-crosscheck` | **Nova-V** | `verified_evidence_pack.md` (ep) |
| `product_idea_to_prd` | `/product-idea-to-prd` | Poom | `prd.md` + `mvp_scope.md` |
| `prd_to_codex_tasks` | `/prd-to-codex-tasks` | Aki | `codex_task_packet.md` (tp) |
| `codex_build_loop` | `/codex-implement` | Coda | `build_report.md` → `ship_check.md` |
| `qa_review` | `/codex-test` (QA path) | **Tessa (conditional — UI only)** | `qa_ux_report.md` (ur) |
| `memory_intake` | `/memory-intake` (= `/memory`) | Mira | `knowledge_intake_note.md` + graph_update (gu) |

## Backend Functions (preserved, NOT active workflow entries)

These v1 workflows map to backend functions in v2 — invoke only on demand, never as default chain steps.

| Former Workflow | v2 Status | Invoke |
|-----------------|-----------|--------|
| `governance_check` (Gina) | Rika-Chan hard gates + `governance/` docs | `/governance-check` on a raised flag only |
| `kaizen_review` (Kai) | Shared token convention (CLAUDE.md) | reference only |
| `llm_wiki_update` (Lexi) | `llm_wiki/` passive reference | `/llm-wiki-update` on demand |
| `security_audit` (Seco) | Kyuuei backend check + Rika-Chan gate | `/codex-security-check` utility |

## Optional Codex Utilities (not core flow)

`/codex-debug` `/codex-refactor` `/codex-pr` `/codex-security-check` `/codex-ship-check`
→ owner-invokable only; map to Coda / Kyuuei (archived agents' functions on demand).

---

## Workflow Files On Disk

| File | Type | Status |
|------|------|--------|
| `workflows/idea_gate.md` | core | active |
| `workflows/product_idea_debate.md` | core (v2 draft pending) | active |
| `workflows/evidence_crosscheck.md` | core | active (Nova-V) |
| `workflows/product_idea_to_prd.md` | core | active |
| `workflows/prd_to_codex_tasks.md` | core | active |
| `workflows/codex_build_loop.md` | core | active |
| `workflows/qa_review.md` | conditional (UI) | active |
| `workflows/memory_intake.md` | core | active |
| `workflows/governance_check.md` | backend/on-demand | retained |
| `workflows/llm_wiki_update.md` | backend/on-demand | retained |
| `workflows/kaizen_review.md` | backend reference | retained |
| `workflows/security_audit.md` | Dynamic Workflow stub | retained |
| `workflows/diff_review.md` | Dynamic Workflow stub | retained |
| `workflows/memory_consolidate.md` | sub-workflow | retained |

---

## Workflow Type Decision Tree

```
Input received by Minori
│
├─ Direct-intent (/scout /recall /next /memory) → Minori gates → specialist executes
├─ Small / single question → single agent or skill
├─ Repeated / procedural → skill first
├─ Multi-step, dependent → sequential handoff
└─ Large / cross-checked / multi-branch → Dynamic Workflow (Rika-Chan approval required)
```

## Governance

- Input Gatekeeper Rule: `/idea-gate [anything]` is the canonical front door; Minori produces `workflow_plan.md` before any delegation.
- Sequential-by-default: parallel fanout forbidden unless six conditions + Rika-Chan approval.
- Gate Scope Pre-Clarification: any Aki/build route requires `expected_gates` + `gate_decisions`
  with each expected gate marked Pre-Decide or Defer before Aki starts.
- Level 1 Runtime: `runtime_tracking` + `logs/runtime_status.md` are status-only; no scheduler,
  parallel fanout, or extra agent spawn is allowed for runtime logging.
- Agent Registry Lock: Nova-V replaces Nova+Vera; Gina/Kai/Lexi/Graphy/Seco are backend only.
- Dynamic Workflow policy: `llm_wiki/token_optimization_rules.md`.
