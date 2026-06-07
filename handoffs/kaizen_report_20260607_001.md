---
template: kaizen_report
produced_by: Kaizen Token Convention (Kai, archived-but-active per CLAUDE.md)
slash_command: /kaizen-review
workflow: standalone — full-cycle review (Workstreams A–D, 2026-06-07 session)
version: "1.0"
---

# Kaizen Report

```yaml
report_id: kaizen_report_20260607_001
produced_by: Kaizen Token Convention
workflow_reviewed: 4-workstream session (D: Mira/Tsumugi/Ichika live-proof, A: Test-3 gate,
  B: Workflow-tool args-string bug + workaround, C: idea→Aki push)
session_date: 2026-06-07
overall_verdict: improvable
```

## Token Waste Findings

| Finding | Step / Agent | Suggestion |
|---------|-------------|-----------|
| Heavy `idea-stresstest.js` run launched (~226s, ~37k+ tokens for ONE of 12 fan-out agents, killed mid-run) immediately after a near-zero-cost probe (<30ms) had ALREADY conclusively proven the same `workflow({scriptPath}, obj)` workaround | Workstream B, step 3 (heavy run after probe) | The probe was sufficient proof. Either skip the heavy run entirely, or — if "production conditions" proof is genuinely required — scope it down to 1–2 agents, not a 12-agent fan-out, and set an explicit token/time kill-switch before launch |
| Aki re-spawned cold with a ~400-word context-recap prompt after mid-translation halt, costing a second ~64k-token pass on top of the first ~76k | Workstream C, Aki spawn 2 of 2 | If a `SendMessage`/resume-agent primitive is unavailable in-session, the gate question that will halt Aki should be asked BEFORE spawning Aki (front-load the owner decision), not mid-spawn — avoiding the recap tax entirely |
| Tsumugi/Ichika impersonation agents each had to cold-read their own persona spec file before acting | Workstream D, 2 of 3 spawns (general-purpose acting as Tsumugi/Ichika) | Register `tsumugi-second-brain` and `ichika-next-action` as real subagent types so persona context loads natively rather than via in-prompt "read spec file Y first" framing |
| Planned "Mira mirrors to decision_ledger" spawn would have duplicated a row already written by a prior session | Workstream A | Always grep/read the target artifact for existing entries before spawning a write-agent for a sync/mirror task — a 5-second `grep` replaced an entire subagent spawn here (and did, once caught) |

## Context Waste Findings

| Finding | Suggestion |
|---------|-----------|
| 4 separate Poom/Aki spawns (~37k + 55k + 76k + 64k = ~232k tokens) for what is fundamentally ONE continuous translation+drafting chain in Workstream C | Where a chain has known potential halt-points (auth/payments/infra gates are *predictable* — they are listed in `governance/approval_gates.md`), pre-clear those gates with the owner in the SAME pass that produces the workflow_plan, so Aki can run start-to-finish in one spawn |
| "Trust but partially verify" pattern — relied on subagent self-reports plus spot-checks via `find`/`grep` rather than re-reading every claimed-written file | Keep this — it is the *correct* tiny-budget pattern (matches Kai's own "review the artifact list, not full content" rule). Document it explicitly as the standard verification tier for routine artifact handoffs, reserving full re-reads for Rika-Chan gate artifacts only |

## Agent Overuse

| Agent | Reason | Alternative |
|-------|--------|------------|
| `general-purpose` (×2, impersonating Tsumugi & Ichika) | Required cold-reading persona spec + "act AS X" framing inside the prompt — extra tokens, fragile persona fidelity, no guarantee of adherence to the real spec's tone/output rules | Register `tsumugi-second-brain` + `ichika-next-action` as invokable subagent types (single config change; both already have complete `.md` specs in `.claude/agents/`) |
| `aki-system-architect` (2nd spawn, cold restart) | Halted mid-task on a predictable governance gate (auth/payments/infra), required full context-recap re-injection | Front-load the predictable-gate question before spawning, OR enable a resume/`SendMessage` primitive so the same agent instance continues post-gate without recap |
| `mira-memory-librarian` (planned 3rd spawn for ledger-mirror) | Was about to duplicate an already-present row | Pre-check target artifact state before spawning any sync/mirror agent — this one was caught and rejected, costing only the prompt-construction tokens, not a full spawn |

## Repeated Context

| Content | Appeared In | Fix |
|---------|------------|-----|
| Aki gate-resolution facts (file paths, prior artifact IDs, owner ruling) | Re-typed in full (~400 words) into the cold-restart prompt for Aki spawn 2 | Either (a) front-load the gate so no restart is needed, or (b) if restart is unavoidable, store the recap as a small structured handoff artifact (`aki_resume_context_[id].md`) once, and reference its path in the prompt rather than inlining prose each time |
| Persona/spec content for Tsumugi and Ichika | Read fresh by each impersonating `general-purpose` agent | Solved by registering them as real subagent types (spec loads natively, once, per the harness's own mechanism) |

## Bottlenecks

| Step | Cause | Suggestion |
|------|-------|-----------|
| Workstream C, Aki halt | Real owner-decision gate (auth/payments/infra) hit mid-translation, not pre-cleared | Add a "predictable gate scan" to Minori's `workflow_plan.md` step: if the task touches auth/payments/infra/data, ask the gate question BEFORE the first build-chain spawn, not after a halt |
| Workstream B, heavy run | No "is further proof needed?" checkpoint between the successful probe and the heavy-run launch | Add a standing rule: after a probe conclusively answers the question a heavy run was meant to answer, require an explicit "why are we still running the heavy version?" check before launch |
| External kill via `/model` switch mid-run | Not a script failure, but wasted the partial run's tokens (3 agents had completed before kill) | Not a workflow defect — but worth noting: Dynamic Workflow heavy runs should be scheduled at session-stable points, not immediately before a known model-context switch |

## Skill Candidates

> Highest-value output. Tasks that should become skills.

| Task | Why a Skill | Token Saving Estimate |
|------|------------|----------------------|
| "Probe-before-heavy-run" check for Dynamic Workflows (cheap diagnostic call to validate an assumption before a 12-agent fan-out) | Repeated + procedural — applies to any future `idea-stresstest.js`-style heavy run, and to any Dynamic Workflow with a costly fan-out step | High — this single session would have saved ~37k+ tokens (one Challenge agent alone) plus ~226 seconds of wall-clock by skipping the heavy run after the probe already proved the point |
| "Predictable-gate pre-clear" check (scan task for auth/payments/infra/data before first build spawn, ask gate question up front) | Repeated + procedural — every `/build`-style chain that touches governance-gated domains will hit this | Medium-high — saves the ~64k-token cold-restart-with-recap pattern seen here in Workstream C |
| "Target-artifact existence check before sync/mirror spawn" (grep/read target before spawning a write-agent for a mirror/sync task) | Repeated + procedural — any Mira-mirrors-to-X or similar duplication-prone handoff | Medium — saved a full Mira spawn here when caught; would be ~15-30k tokens per avoided duplicate spawn |

## Workflow Simplification

| Current | Proposed | Token Saving |
|---------|---------|-------------|
| Tsumugi/Ichika invoked via `general-purpose` + "act as X, read spec Y" framing | Register `tsumugi-second-brain` and `ichika-next-action` as real invokable subagent types (specs already complete in `.claude/agents/`) | Removes the cold-spec-read tax per spawn — modest per-call (~5-10k?) but compounds every time `/recall` or `/next` routes through Mi→Ts or Mi→Ic, which per `CLAUDE.md` routing law is frequent |
| Aki spawned twice (cold) for one logical translation chain, separated by an unplanned-for gate | Pre-scan for predictable governance gates at `workflow_plan.md` creation time; ask the gate question before the first spawn | ~64k tokens (the second spawn's cold-restart-with-recap cost) per occurrence |
| Heavy fan-out run launched after probe already answered the question | Standing "probe-before-heavy-run" convention for Dynamic Workflows: if a cheap diagnostic can answer the question, do not also run the expensive version "for production-conditions proof" unless Rika-Chan explicitly requires it | ~37k+ tokens per avoided heavy run (this session: at least one full Challenge-agent's cost, likely much more had it completed) |

## Overall Verdict

`improvable`

Three concrete, low-effort fixes would materially change the next cycle's cost profile:
1. Register Tsumugi and Ichika as real subagent types (config change, specs already exist).
2. Add a "predictable-gate pre-clear" step to Minori's workflow-plan creation for any chain touching auth/payments/infra/data.
3. Adopt a standing "probe-before-heavy-run" rule for Dynamic Workflows — if a cheap probe conclusively answers the question, do not also run the expensive version absent an explicit Rika-Chan requirement for production-conditions evidence.

What to keep doing (do not change):
- The "trust but partially verify" pattern (self-report + spot-check via `find`/`grep`) — this IS the correct tiny-budget verification tier; full re-reads should stay reserved for Rika-Chan-gate artifacts.
- Catching planned-spawn duplication before it happens (the Mira-mirror case) — the 5-second target-artifact check that prevented a redundant spawn is exactly the Jidoka "stop on uncertainty" principle in action; formalize it as a pre-spawn checklist item.
- Using the `Workflow` tool directly for near-zero-cost diagnostic probes rather than wrapping them in agent spawns — this is the cheapest possible way to validate an assumption and should remain the default first move for any "does X work?" question.

---

> Logs updated: `logs/kaizen_log.md` (entries K1–K6 appended below)
> Skill candidates → passes to: `lexi_llm_wiki_keeper.md` (archived; function preserved per `CLAUDE.md` — route via Minori for `llm_wiki/` update consideration)
