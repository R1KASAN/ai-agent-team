---
command: idea-gate
description: Universal front door — classify ANY input (job + weight) → workflow_plan → route or stop. One command for everything.
entry_agent: minori_lead_conductor
context_budget: small
required_input: any input from Rika-Chan — idea, topic, question, note, link, "ทำอะไรดี", "เคยเซฟ...", or a task
optional_input: supporting artifact paths, constraints, risk notes, approval notes; never full chat history
forbidden_actions: bypassing Minori, skipping artifact gates, starting downstream workflows automatically, auto-escalating to dynamic without Rika approval, using large/dynamic context without approval, overwriting existing files without approval, inventing agents
produces: handoffs/workflow_plan_YYYYMMDD_NNN.md (+ approval_request.md if a gate or dynamic budget is triggered)
approval_gate: none for classification; required if selected route is strategic/financial/legal/privacy/security OR execution_mode = dynamic
stop_condition: workflow_plan.md produced; no downstream workflow starts automatically; dynamic route → halt for Rika dynamic-budget approval
ref: workflows/idea_gate.md · context.md · llm_wiki/dynamic_workflow_policy.md
---

# /idea-gate — Universal Size-Aware Dispatcher

The single front door. Type `/idea-gate [anything]` and Minori does three things, then stops:

1. **Classify the job** — what kind of work is this?
2. **Classify the weight** — how big is it (tiny → strategic)?
3. **Route** — pick the cheapest execution_mode that fits, write `workflow_plan.md`, and stop at any gate.

Optional shortcuts (`/scout`, `/recall`, `/next`, `/idea`, `/memory`, `/research`, `/build`, plus
Codex utilities) still work for users who already know the intended route. `/idea-gate` is the
single canonical front door for everything else.

> **Read `context.md` first.** It defines the balance rules this command must never break.

---

## Step 1 — Job classification

Classify to exactly one job (maps to existing workflow IDs in `workflows/idea_gate.md`):

| Job | Trigger signal | Routes toward |
|-----|---------------|---------------|
| `recall` | "เคยเซฟ...", "มีอะไรเกี่ยวกับ X" | Tsumugi |
| `next` | "ทำอะไรดี", "ไม่รู้จะเริ่มตรงไหน", stuck | Ichika |
| `scout` | "สวัสดีตอนเช้า", "what's new", trends | Hikari |
| `memory` | save a note/link/file | Mira (`memory_intake`) |
| `research` | analyze a source (URL/PDF/YouTube) deeply | Mira privacy/source intake → Nova-V selected-note/source check → NotebookLM-py only if approved |
| `idea-debate` | a product/project idea to validate | Yu→NV→So→Bu→Po pipeline |
| `build` | approved brief/PRD → implement | Ak→Co→QA (→Te if UI) |
| `governance` | privacy/legal/security question | governance_check |

If ambiguous: low-risk → proceed with labeled assumptions; high-risk → ask ≤3 questions.

---

## Step 2 — Weight classification (the token-balance mechanism)

Pick the **smallest** weight that honestly fits. This is what protects token/context economy.

| Weight | Looks like | execution_mode | Cost |
|--------|-----------|----------------|------|
| `tiny` | one-line recall, `/next` | `single_agent` | tiny |
| `small` | save note, quick question, daily scout | `single_agent` or short `sequential_handoff` | small |
| `medium` | validate ONE clear idea | `sequential_handoff` (the current `/idea` pipeline) | small–medium |
| `heavy` | idea needing cross-checked evidence + adversarial debate | `dynamic_workflow` → `idea-stresstest.js` | dynamic |
| `strategic` | pivot, kill/bet, multi-idea portfolio | `dynamic_workflow` + extra Rika gates | dynamic |

Rules:
- `heavy`/`strategic` are the **only** weights that may use `dynamic_workflow`, and only when they
  match an approved Dynamic use case in `llm_wiki/dynamic_workflow_policy.md` (cross-checked
  research / adversarial evaluation).
- Minori **recommends** the dynamic route in `workflow_plan.md` and **STOPS** — it never launches a
  JS workflow itself. Owner approves `context_budget: dynamic` first.
- When unsure between two weights, pick the lower one (cheaper). Escalation needs a written reason.

---

## Step 3 — Orchestrator Contract + route

Before any delegation, fill all 8 fields in `workflow_plan.md` (schema in `workflows/idea_gate.md`),
now including `weight` and `execution_mode`. Then:

- `single_agent` / `sequential_handoff` → hand to the first agent (cheap path, no approval needed
  unless a hard gate applies).
- `dynamic_workflow` → produce `approval_request.md` (gate: parallel/fanout + `dynamic` budget),
  name the recommended script (`idea-stresstest.js`), and **halt for Rika-Chan**.

For any Aki-bound/build-bearing route, Minori must also add **Expected Gates + Pre-Decide vs Defer**
to `workflow_plan.md`. Predictable gates include auth, payments, database, infrastructure, hosting,
production deploy, paid API/tool usage, privacy, security, legal, and client/user-facing messages.
Each gate must be marked `Pre-Decide` with Rika-Chan's decision before Aki, or `Defer` with a named
checkpoint such as `Coda proposes options + Rika-Chan approves before implementation/spend/deploy`.
If none are expected, record `expected_gates: none_detected` with a reason. If gates are detected but
not clarified, Aki must not start.

---

## Hard Gates (always stop)
- Route is strategic / financial / legal / privacy / security → Rika approval before proceeding.
- `execution_mode: dynamic` → Rika `dynamic`-budget approval (`governance/approval_gates.md`).
- Required input artifact missing → generate it first, do not proceed.
- Input conflicts with operating rules → follow rules, explain the safe adjusted route.

## Governance
- Sequential-by-Default: no fan-out unless all six conditions + Rika approval.
- No auto-start of downstream workflows; no invented agents; No-Overwrite Rule applies.
- Memory/Evidence ownership: Mira is the only normal `knowledge/` writer; Tsumugi is read-only;
  Nova-V may read selected `knowledge/` notes and use NotebookLM-py only after per-command approval.
- NotebookLM-py is not a memory layer and not a truth source; Nova-V must verify any output before
  Mira writes `knowledge/research/[slug].md`.
- Routed work that proceeds beyond pure classification must create an agent run log in
  `logs/agent_runs/` using `templates/agent_run_log.md`.
