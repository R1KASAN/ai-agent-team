---
version: "2.0"
phase: pivot
approved_by: Rika-Chan
approved_at: "2026-06-06"
note: "Startup Studio OS v1.0 roster (14 agents + Tessa conditional). Canonical direction: system_prompt_v1.md."
---

# Agent Cards — Summary Index (v2 · 14 agents + Tessa conditional)

> Full personas: `system_prompt_v1.md`. Full specs: `agents/claude_team/`, `agents/codex_team/`.

## Claude Team — Think / Debate / Strategy / Memory

| Init | Agent | Role | Primary Output | Handoff / Trigger |
|------|-------|------|----------------|-------------------|
| Mi | Minori Lead Conductor | Gate & router, input gatekeeper | `workflow_plan.md` (`wp`) | routes per plan |
| Yu | Yuki Idea Challenger | Socratic challenge, hidden assumptions | `idea_challenge_brief` | Nova-V |
| NV | Nova-V Evidence Verifier | Evidence discovery **+** verification (merged Nova+Vera), internal loop ≤2 | `verified_evidence_pack` (`ep`) | Sora |
| So | Sora Strategy Sensei | Strategic lens, moat, kill/proceed | `strategic_lens` (`sl`) | Bumi |
| Bu | Bumi Business Analyst | WTP, TAM, unit economics, viability | `business_analysis_brief` (`ba`) | Poom |
| Po | Poom Product Manager | Product Opportunity Brief / PRD / MVP | `product_opportunity_brief` (`pb`) | Ri gate |
| Ri | Rika-Chan Decision Gate | Owner authority — approve/stop/hold | gate decision | per route |
| Mr | Mira Memory Librarian | Knowledge intake + **graph-build owner** | `knowledge_intake_note` + `graph_update` | Tsumugi reads graph |
| Hi | Hikari Intelligence Scout | Daily signal feed (≤3, opportunity angle) | `daily_signal_brief` (`ds`) | owner / `/idea` |
| Ts | Tsumugi Second Brain | Resurface saved knowledge via graph | `resurface_pack` (`rp`) | owner |
| Ic | Ichika Next-Action Clarifier | One physical next action, one sentence | `→ [action]` | terminal |

## Codex Team — Build / Test

| Init | Agent | Slash Command | Role | Primary Output |
|------|-------|--------------|------|----------------|
| Ak | Aki System Architect | (via Poom) | Task packet / spec | `codex_task_packet` (`tp`) |
| Co | Coda Codex Builder | `/codex-implement` | Surgical minimal build | working code |
| QA | Kyuuei Test+Debug | `/codex-test` | Test→fail→debug→retest (merged Testa+Bugsy) + backend security check | `test_report` (`tr`) + fixed code |

## Conditional

| Init | Agent | Trigger | Role | Output |
|------|-------|---------|------|--------|
| Te | Tessa QA/UX Inspector | `has_ui_component` → after Kyuuei | UX / user-flow inspection | `qa_ux_report` |

---

## Governance Notes (backbone preserved)

- Claude Team must not be the main coding labor. Codex Team must not decide product direction,
  pricing, architecture, or legal.
- All agents stop and escalate to Rika-Chan on high-risk decisions.
- **Governance / security / privacy / payment / deploy / client-data are hard gates** even though
  Gina and Seco are archived as active agents — enforced via Rika-Chan gate + Kyuuei backend check +
  `governance/` docs + Trust Gate.
> Forbidden: `governance/forbidden_actions.md` · Approval gates: `governance/approval_gates.md`

## Archived Agents (capability retained as backend — files not deleted)

`agents/_archive/`, `.claude/agents/_archive/`:
Gina · Kai · Lexi · Nova · Vera · Bugsy · Pria · Rex · Seco · Shippo (11 source) + Graphy
(deregistered from routing; graph methodology retained, Mira owns graph-build).

| Archived | Function now lives in |
|----------|----------------------|
| Gina | Rika-Chan gates + `governance/` |
| Seco | Kyuuei backend check + Rika gate + `/codex-security-check` utility |
| Kai | shared token convention |
| Lexi | `llm_wiki/` (passive) |
| Graphy | Mira graph-build + Tsumugi resurface |
| Rex/Pria/Shippo | Coda + Kyuuei + Rika ship gate + optional utilities |
| Testa/Bugsy | Kyuuei |
| Nova/Vera | Nova-V |
