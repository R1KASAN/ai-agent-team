---
name: workflow-router
version: "1.0"
trust_status: Core
team: claude
invoked_by: minori_lead_conductor; /idea-gate
input: classified input type from input-gate; workflow_plan.md
output: agent assignment and next-step instruction (embedded in workflow_plan.md)
---

# Workflow Router Skill

Maps classified input to the correct workflow. Sequential routing only by default.

## Protocol

1. Receive the classified input type from input-gate.
2. Look up the matching workflow in `workflows/workflow_index.md`.
3. Assign: entry agent, context budget, artifact sequence, stop conditions.
4. For any Aki-bound/build-bearing route, require Gate Scope Pre-Clarification: embed Expected Gates
   + Pre-Decide vs Defer in `workflow_plan.md` before Aki can start.
5. Check parallel fanout conditions — if all 6 are not met, enforce sequential.
6. Embed the routing decision in `workflow_plan.md` under the `agent_sequence` field.

## Parallel Fanout Rule

Parallel routing is forbidden unless all 6 conditions in `llm_wiki/token_optimization_rules.md` are satisfied AND Rika-Chan approves. Default: sequential.

## Required Fields in workflow_plan.md

- `workflow_id`, `entry_agent`, `agent_sequence`, `artifact_sequence`, `context_budget`, `stop_conditions`, `approval_points`, `workflow_type`
- For Aki-bound/build-bearing routes: `gate_scope_preclarification_required`, `expected_gates`, and
  `gate_decisions` with each gate marked `Pre-Decide` or `Defer`

## Gate Scope Pre-Clarification

Before routing into Aki, scan predictable gates: auth, payments, database, infrastructure, hosting,
production deploy, paid API/tool usage, privacy, security, legal, and client/user-facing messages.
Each expected gate must be marked **Pre-Decide vs Defer**. `Pre-Decide` requires Rika-Chan's decision
before Aki. `Defer` requires a named checkpoint, usually `Coda proposes options + Rika-Chan approves
before implementation/spend/deploy`. If none are expected, record `expected_gates: none_detected`
with a reason. If gates are detected but not clarified, Aki must not start.

## Agent Routing Guard

Only route to agents explicitly defined in `agents/agent_cards.md` and `agents/claude_team/` or `agents/codex_team/`. Do not invent agent names, aliases, or roles.

`workflow_plan.md` must exist before any agent is delegated to.

### Approved Agent Routing Table

| Task Type | Assigned Agent |
|---|---|
| Workflow routing / approval / context budget | Minori Lead Conductor |
| Idea challenge / devil's advocate / Socratic critique | Yuki Idea Challenger |
| Raw knowledge intake / metadata / privacy tagging | Mira Memory Librarian |
| Graph / entity / relation mapping | Mira Memory Librarian (graph-build backend) |
| Research / evidence / source discovery + verification | Nova-V Evidence Verifier |
| Strategy / moat / long-term bet / what to cut | Sora Strategy Sensei |
| Business model / WTP / revenue / market risk | Bumi Business Analyst |
| Product Opportunity Brief / PRD / MVP scope | Poom Product Manager |
| Architecture / technical task packet / Codex packet | Aki System Architect |
| QA / UX / user-flow inspection | Tessa QA/UX Inspector |
| Governance / privacy / legal / security | Rika-Chan Decision Gate + `governance/` docs |
| Token / context waste / Kaizen / workflow simplification | Kaizen token convention or `/kaizen-review` |
| LLM Wiki / skill candidate / reusable rule update | `/llm-wiki-update` proposal flow |

### Codex Team Routing Policy

Minori does not delegate directly to Codex agents during Claude Team planning. Codex agents are invoked via slash commands after Aki produces `codex_task_packet.md` and Rika-Chan approves. Route to Aki for all technical task and Codex packet preparation.

| Codex Task | Slash Command | Agent |
|---|---|---|
| Implementation | `/codex-implement` | Coda Codex Builder |
| Testing | `/codex-test` | Kyuuei Test+Debug |
| Debugging | `/codex-debug` | Kyuuei Test+Debug |
| Refactoring | `/codex-refactor` | Coda Codex Builder + Kyuuei verification |
| PR preparation | `/codex-pr` | Coda Codex Builder |
| Security check | `/codex-security-check` | Kyuuei Test+Debug |
| Ship check | `/codex-ship-check` | Kyuuei Test+Debug |

## Canonical Artifact Names by Workflow

### product_idea_debate / feature decision / pre-validation

| Step | Agent | Output Artifacts |
|---|---|---|
| 1 | Yuki Idea Challenger | `idea_challenge_brief.md`, `top_riskiest_assumptions.md` |
| 2 | Nova-V Evidence Verifier | `verified_evidence_pack.md` |
| 3 | Sora Strategy Sensei | `strategic_lens.md` |
| 4 | Bumi Business Analyst | `business_analysis_brief.md` |

Default step order is Yuki → Nova-V → Sora → Bumi. Nova-V may move to Step 1 only for purely factual questions; label reason in `workflow_plan.md`.

Do not use generic output labels (e.g. "Evidence brief", "Challenge list", "Viability note"). Always use canonical artifact filenames.

## Forbidden

- Do not route to a stub_only workflow.
- Do not apply parallel fanout without meeting all 6 conditions.
- No shell execution. No external calls.
- Do not assign agents not listed in the Approved Agent Routing Table above.
- Do not use generic artifact names in place of canonical filenames.
