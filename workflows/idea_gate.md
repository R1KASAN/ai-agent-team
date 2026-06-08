---
workflow_id: idea_gate
slash_command: /idea-gate
entry_agent: Minori Lead Conductor
context_budget: small
output_artifact: workflow_plan.md
version: "2.0"
changelog: "v2.0 — universal size-aware dispatcher: adds job + weight classification and execution_mode routing; dynamic route halts for Rika approval."
ref: context.md · llm_wiki/dynamic_workflow_policy.md · .claude/workflows/idea-stresstest.js
---

# Workflow: idea_gate (v2 — universal dispatcher)

## Purpose

Prevent wrong input from causing wrong (or wrongly-sized) workflow execution. Every workflow begins
here. v2 adds **size awareness**: pick the cheapest execution_mode that fits, and reserve the
expensive Dynamic Workflow for heavy/strategic work behind a Rika gate.

## Flow

```
Rika-Chan input (anything)
→ Minori: classify JOB (recall/next/scout/memory/research/idea-debate/build/governance)
→ Minori: classify WEIGHT (tiny/small/medium/heavy/strategic)
→ Minori: pick execution_mode (single_agent | sequential_handoff | dynamic_workflow)
→ Minori: produce workflow_plan.md (8-field Orchestrator Contract + weight + execution_mode + runtime_tracking)
→ if route proceeds beyond pure classification → write/update logs/runtime_status.md (Level 1 Runtime)
→ if job = consult → escalation check → route single_agent (adhoc_consult), skip full plan (see below)
→ if execution_mode = dynamic_workflow OR route is high-risk → approval_request.md + STOP for Rika
→ else → route to first agent
→ after each routed step returns → orchestrator writes one logs/agent_runs/ entry (see below)
```

---

## Job Classification

Exactly one of: `recall · next · scout · memory · research · idea-debate · build · governance ·
consult` (see job table in `.claude/commands/idea-gate.md`). These map to the existing workflow IDs:
`product_idea_debate · evidence_crosscheck · product_idea_to_prd · prd_to_codex_tasks ·
codex_build_loop · qa_review · governance_check · memory_intake`. `consult` has no full pipeline
workflow ID — it is the lightweight single-agent lane (see **Fast-Path Consult** below).

| Job | Trigger signal | Routes toward |
|---|---|---|
| `consult` | Owner names a *specific* agent + asks one narrow question — e.g. "ขอ Yuki ท้าทายเรื่อง X หน่อย", "Sora มองมุมกลยุทธ์ของ Y ยังไง" | that named agent directly, `single_agent` mode |

## Weight Classification

Exactly one of: `tiny · small · medium · heavy · strategic`.

| Weight | execution_mode | Notes |
|--------|----------------|-------|
| tiny | single_agent | one agent, knowledge/ read only |
| small | single_agent / sequential_handoff | Mira writes + graph_update on save |
| medium | sequential_handoff | current `/idea` pipeline; notebooklm-py only if a deep source exists |
| heavy | dynamic_workflow | `idea-stresstest.js`; Rika dynamic gate |
| strategic | dynamic_workflow | + extra Rika gates (kill/pivot/portfolio) |

**Lower-weight tie-break:** when two weights are plausible, choose the cheaper; escalation requires a
written reason in `assumptions` / `risk_flags`.

---

## Orchestrator Contract (extended)

```yaml
workflow_plan:
  workflow_id: ""
  job: ""             # recall | next | scout | memory | research | idea-debate | build | governance
  weight: ""          # tiny | small | medium | heavy | strategic
  goal: ""
  known_inputs: []
  missing_inputs: []
  assumptions: []
  risk_flags: []
  runtime_tracking:
    runtime_mode: level_1_status_only
    run_id: ""
    status_log: logs/runtime_status.md
    agent_run_log_dir: logs/agent_runs/
    current_status: planned
    current_agent: Minori Lead Conductor
    latest_artifact: ""
    next_step: ""
  agent_sequence:
    - step: 1
      agent: ""
      input_artifact: ""
      output_artifact: ""
      context_budget: small
      stop_condition: ""
      approval_gate: false
  execution_mode: ""  # single_agent | sequential_handoff | dynamic_workflow
  recommended_workflow: ""  # e.g. idea-stresstest.js (only when execution_mode = dynamic_workflow)
  context_budget: small     # dynamic ONLY with Rika approval
  approval_points: []
  stop_conditions: []
  proactive_recall: false   # true → Minori calls Tsumugi before heavy handoffs (JIT context)
  gate_scope_preclarification_required: false
  expected_gates: []        # use none_detected + reason when the scan finds no predictable gates
  gate_decisions:
    - gate: ""              # e.g. auth system, paid API, database, hosting, production deploy
      risk_domain: ""       # strategic | financial | privacy | security | infra | legal
      pre_decide_or_defer: ""  # Pre-Decide | Defer
      owner_decision: ""    # required before Aki when Pre-Decide
      deferred_to: ""       # required when Defer; name owner/checkpoint
      stop_condition: ""    # what blocks Aki/Coda if unresolved
```

---

## Level 1 Runtime Status

For any `/idea-gate` route beyond pure classification, Minori must record `runtime_tracking` in
`workflow_plan.md` and add or update a compact row in `logs/runtime_status.md`.

- `runtime_mode` is always `level_1_status_only`.
- Status values: `planned`, `running`, `awaiting_approval`, `blocked`, `complete`, `aborted`.
- `task_queue` is represented by `next_step`; this is a marker, not a scheduler.
- `artifact_return` is represented by `latest_artifact`; record paths only, not artifact bodies.
- Level 1 Runtime must not spawn agents, launch dynamic workflows, or enable parallel/fanout.

## Fast-Path Consult (ad-hoc single-agent)

`job: consult` is a Minori-gated *fast lane* for "ask one named agent one narrow question". The
Routing Law is intact — Minori still classifies first — but the heavy machinery that doesn't apply to
a single ask is skipped.

**Flow:** `Rika input names an agent + one question → Minori classifies job: consult → escalation
check (below) → route single_agent to the named agent → agent returns one artifact → orchestrator
writes the agent_run_log entry.`

**Minimal-artifact rule (what makes it fast):**
- No full 8-field `workflow_plan.md`, no `agent_sequence`, no Gate Scope Pre-Clarification (a consult
  never reaches Aki).
- Minori writes **one row** to `logs/runtime_status.md` via the append+verify helper (below) tagged
  `runtime_mode: adhoc_consult` — structurally distinct from `level_1_status_only` pipeline rows, so
  it can never be mistaken for or overwrite a live pipeline's status.
- Output artifact uses a **collision-proof name**: `handoffs/adhoc_<agent-key>_<YYYYMMDD_HHMMSS>.md`
  (e.g. `handoffs/adhoc_yuki_20260608_143000.md`). Never a canonical pipeline name
  (`idea_challenge_brief.md`, `verified_evidence_pack.md`, `strategic_lens.md`, …).
- Per **Agent Run Log Requirement** below, the orchestrator still writes one compact `agent_run_log`
  entry — even the fast path is fully audited.

**Escalation guard (stop-and-redirect — this keeps the fast-path safe):** if Minori or the named
agent recognizes the ask is actually build-bearing, strategic, or gate-triggering in disguise — e.g.
"ขอ Aki ลุยสร้างเลย", or "Sora บอกว่าควร kill โปรเจกต์นี้ไหม" used to *make* a kill/pivot decision
rather than get a perspective — Minori must **stop and redirect** to the full `/idea-gate` pipeline:
*"this needs the full pipeline, not a quick consult."* A consult must never substitute for a
Rika-Chan hard gate (strategic pivot, kill-signal, legal/privacy, security, payment/deploy).

## Agent Run Log Requirement

Every route beyond pure classification — full pipeline steps **and** fast-path consults — must leave
a per-step audit record in `logs/agent_runs/`, mirroring how `logs/runtime_status.md` already works.

- Immediately after each `agent_sequence` step returns its artifact and **before** spawning the next
  step, the orchestrator writes one compact entry (10–15 lines, paths only — no pasted content) using
  `templates/agent_run_log.md`.
- The entry is written **inline by the orchestrating session** via the append+verify helper — never
  by spawning a separate "logger" agent (the same rule that already forbids an extra agent call for
  runtime status).
- One step = one file: `logs/agent_runs/<run_id>.md` where `run_id = YYYYMMDD-HHMMSS-command-agent`.

## Append + Verify Write Protocol (Layer 1 — the real fix for row loss)

`logs/runtime_status.md` is a single shared table; an ad-hoc full-file rewrite (or two writers) can
silently drop another run's row. All writes to it and to `logs/agent_runs/` go through one locked,
append-only, read-back-verified path: **`scripts/safe_log_write.sh`**.

- `safe_log_write.sh status append --run-id <id> --row '<one-line row>'` — locks
  (portable `mkdir`-mutex; no `flock` dependency), appends the row after the last data row, then
  **reads back** to confirm row count went up by exactly one and `<id>` appears exactly once. On any
  mismatch it leaves the live file untouched and exits non-zero (fail loud, never silently proceed).
- `safe_log_write.sh status update --run-id <id> --row '<row>'` — status transition
  (`planned→running→complete`); edits only the line matching `<id>`, verifies exactly one match.
- `safe_log_write.sh agent-run --run-id <id> < entry.md` — writes
  `logs/agent_runs/<id>.md`; **no-overwrite** (auto-suffixes `-2`, `-3`… if the path exists) per the
  No-Overwrite Rule, then verifies the file is non-empty.

## Usage Guidance (Layer 2 — prevention at the source)

Rules that keep the race from arising in the first place:

- **Sequential-by-default = one writer at a time.** Do not run two concurrent sessions that both
  write `logs/runtime_status.md`. The lock is the backstop, not a licence for fanout.
- **One `run_id` per run; one file per step** in `logs/agent_runs/`. Never share a file across runs
  except the single status index.
- **Edit only your own run's row**, identified by `run_id`. Never rewrite the whole table to change
  one row.
- **Paths, never bodies.** Keep every row one line (artifact paths only) so append + verify stays
  cheap and reliable — a multi-line paste defeats line-based append/verify.
- **Distinct ad-hoc naming** (`adhoc_<agent-key>_<timestamp>`) so a consult can never collide with a
  pipeline canonical name.

## Gate Scope Pre-Clarification

Before any Aki-bound or build-bearing route, Minori must add an **Expected Gates + Pre-Decide vs
Defer** section to `workflow_plan.md`.

- Scan for predictable gates: auth, payments, database, infrastructure, hosting, production deploy,
  paid API/tool usage, privacy, security, legal, and client/user-facing messages.
- If a gate is likely, ask Rika-Chan whether to **Pre-Decide** it before Aki or **Defer** it to a
  named checkpoint, usually `Coda proposes options + Rika-Chan approves before
  implementation/spend/deploy`.
- If no predictable gates are found, record `expected_gates: none_detected` with a short reason.
- If gates are detected but not clarified, Aki must not start.

This is mandatory, not advisory, for any workflow that can enter Aki.

---

## Stop Conditions

- `execution_mode: dynamic_workflow` → produce `approval_request.md`, set `context_budget: dynamic`,
  **halt for Rika-Chan**. Never launch the JS workflow from here.
- Required input artifact missing → generate first.
- Route high-risk (strategic/financial/legal/privacy/security) and not approved → request approval.
- Aki-bound route has unresolved Gate Scope Pre-Clarification → stop before Aki.
- Input conflicts with operating rules → explain adjusted workflow.
- Context budget would need `large`/`dynamic` without approval → stop.

## Output

`handoffs/workflow_plan_YYYYMMDD_NNN.md` (NNN increments per day). No downstream workflow auto-starts.

## Proactive recall (JIT, Phase 1)

When `weight ∈ {heavy, strategic}`, Minori sets `proactive_recall: true` and calls **Tsumugi** to
surface matching `knowledge/` + Obsidian-graph notes as **scoped** context for the relevant step
only — never load the full vault. This is the compounding-memory hook.
