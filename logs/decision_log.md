---
log: decision_log
maintained_by: Minori Lead Conductor
appended_by: any agent reaching an approval gate
version: "1.0"
---

# Decision Log

Record every strategic, financial, legal, privacy, security, or architectural decision that is approved by Rika-Chan or explicitly deferred. Do not log routine workflow steps.

## Entry Format

```yaml
- decision_id: ""
  date: ""
  workflow_id: ""
  decision: ""
  made_by: ""             # Rika-Chan / Minori / agent name
  approved_by: ""         # Rika-Chan if approval gate was triggered
  rationale: ""
  artifacts_ref: []       # files this decision is documented in
  reversible: true / false
  status: ""              # active / superseded / deferred
```

---

## Decisions

<!-- Entries appended here by agents during live workflows. -->
<!-- Most recent entry at top. -->

- decision_id: dec-20260607-007
  date: 2026-06-07
  workflow_id: idea_ai_assistant_scattered_client_feedback / gate_4_aki_auth_payments_infra_halt
  decision: |
    RESOLVED approval_request_20260607_002.md (Aki's auth/payments/infra halt) — three-part ruling:
    (Q1) Beta access = SHAPE A — a single shared invite link/password known only to the 10-20 seeded testers; no accounts, no user table, no persistent per-user state.
    (Q2) This minimal mechanism is ruled NOT a full "auth system" — it stays inside the locked one-shot architecture (dec-20260607-004) and out_of_scope.md's boundary; Coda may build it without a separate auth-gate review.
    (Q3) Paid model-API provider/spend ceiling is DEFERRED — Coda researches and proposes options with cost estimates when it reaches that part of the build; Rika-Chan approves the specific choice then (the spend-commitment gate stays open for that follow-up, not closed blindly now).
    Aki is cleared to complete codex_task_packet.md.
  made_by: Rika-Chan
  approved_by: Rika-Chan
  rationale: "Shape A is the narrowest mechanism that keeps a real-client-data-processing tool out of public reach for a 10-20 person bounded beta, without building anything resembling the account system the PRD/out-of-scope locked out — it doesn't widen the pending PDPA/privacy review's scope (Shape B would) and doesn't over-build (a full auth gate would violate dec-20260607-004's one-shot architecture). Naming the access mechanism now lets hosting + the technical packet proceed; deferring the paid-API choice to Coda's proposal-then-approval cycle is appropriate because provider selection is an implementation research task, not a strategic commitment that needs to gate translation — the spend-approval gate itself stays intact, just resolved at the right step."
  artifacts_ref: [handoffs/approval_request_20260607_002.md, handoffs/technical_task_packet.md, logs/decision_log.md#dec-20260607-006]
  reversible: true
  status: active

- decision_id: dec-20260607-006
  date: 2026-06-07
  workflow_id: idea_ai_assistant_scattered_client_feedback / gate_3_prd_approval
  decision: "APPROVED — prd.md (prd-20260607-001) + companions (mvp_scope.md mvp-20260607-001, acceptance_criteria.md ac-20260607-001, out_of_scope.md oos-20260607-001) for 'AI Assistant: Scattered Client Feedback → Clear Next Actions'. MVP locked to 5 features (paste-first text, screenshot upload, exactly ONE next action, exactly ONE Thai client-update draft, zero persistent memory). Aki is now activated via /prd-to-codex-tasks to produce the technical task packet — this is the named hard gate immediately preceding Aki."
  made_by: Rika-Chan
  approved_by: Rika-Chan
  rationale: "PRD carries forward the approved brief (dec-20260607-005) and the locked one-shot architecture (dec-20260607-004) without re-litigation; scope is tight (5 features in, everything else — connectors, voice, scheduling, multi-seat, pricing/auth/DB/billing — explicitly out and flagged back to owner if Aki's technical translation surfaces a real need). Acceptance criteria are concrete and testable (exactly-one-output discipline, zero-retrievable-trace check). Clears CLAUDE.md's PRD-approval hard gate; build may now be sized."
  artifacts_ref: [handoffs/prd.md, handoffs/mvp_scope.md, handoffs/acceptance_criteria.md, handoffs/out_of_scope.md, logs/decision_log.md#dec-20260607-005]
  reversible: true
  status: active

- decision_id: dec-20260607-005
  date: 2026-06-07
  workflow_id: idea_ai_assistant_scattered_client_feedback / gate_2_pob_approval
  decision: "APPROVED — product_opportunity_brief.md (pob-20260607-001) for 'AI Assistant: Scattered Client Feedback → Clear Next Actions' (one-shot paste-first tool: paste client feedback text/screenshot → one prioritized next action + one Thai client-update draft). Poom's recommendation `proceed_to_prd` accepted. Poom may now begin PRD phase (prd.md + mvp_scope.md + acceptance_criteria.md + out_of_scope.md) — still gated: owner approves the PRD before Aki activates."
  made_by: Rika-Chan
  approved_by: Rika-Chan
  rationale: "Brief clears CLAUDE.md's named 'Product Opportunity Brief before PRD' hard gate. Problem is real/daily/high-pain per Bumi; the strategic-fork blocker is resolved (dec-20260607-004); MVP scope is lean and tests the riskiest assumption (A1 — does one-shot beat ChatGPT enough to retain users) directly via Bumi's existing >60% day-3 return gate. Open risks (low moat, Thai-NLP accuracy, PDPA/privacy) are explicitly tracked — owner accepts them as carry-forward PRD inputs, not blockers to drafting."
  artifacts_ref: [handoffs/product_opportunity_brief.md, logs/decision_log.md#dec-20260607-004]
  reversible: true
  status: active

- decision_id: dec-20260607-004
  date: 2026-06-07
  workflow_id: idea_ai_assistant_scattered_client_feedback / gate_1_strategic_fork
  decision: "Strategic fork resolved: build 'AI Assistant: Scattered Client Feedback → Clear Next Actions' as a ONE-SHOT TOOL (not a memory layer). This is the framing input Poom uses to draft product_opportunity_brief.md."
  made_by: Rika-Chan
  approved_by: Rika-Chan
  rationale: "Sora flagged this fork as a precondition in strategic_lens.md ('One-shot tool or memory layer? — Rika-Chan to decide'). Owner chose one-shot: faster to build and validate, lower switching cost, validates WTP quickly — accepting the tradeoff of lower moat / easier substitution by ChatGPT-class tools, which Poom and downstream evidence work should track as an open risk rather than a blocker."
  artifacts_ref: [handoffs/strategic_lens.md, handoffs/business_analysis_brief.md]
  reversible: true
  status: active

- decision_id: dec-20260607-003
  date: 2026-06-07
  workflow_id: workflow_plan_20260607_003 / approval_request_20260607_001
  decision: "WAIVE the 3 open questions in approval_request_20260607_001.md as 'test scaffold, not a real pivot' (gate mechanics only — no live B2B strategic question is being evaluated). GRANT context_budget: dynamic for the Test 4 (idea-stresstest.js) proof run ONLY — a one-time grant for this proof, not a standing approval. Strategic-pivot hard gate is closed for this synthetic scenario."
  made_by: Rika-Chan
  approved_by: Rika-Chan
  rationale: "approval_request_20260607_001.md's own test_context field states this was raised as 'Phase 1 proof run — Test 3 (Heavy/strategic gate)' — a deliberate proof-test scaffold, not a genuine product-pivot question. Spending real strategic-decision effort answering synthetic questions would be wasteful; waiving them lets Test 4 (the args-string-bug workaround attempt) proceed using a real, owner-granted rika_dynamic_approved=true value, while keeping the dynamic-budget gate's authority intact (one-time grant, not standing)."
  artifacts_ref: [handoffs/approval_request_20260607_001.md, knowledge/reference/lessons_ledger.md, .claude/workflows/idea-stresstest.js]
  reversible: true
  status: active

- decision_id: dec-20260607-002
  date: 2026-06-07
  workflow_id: product_scout_link_to_ideation
  decision: "Standing approval — Hikari, in Product Scout mode (/scout <URL>), may (a) WebFetch a single PUBLIC URL and (b) write a templates-shaped product_scout_brief.md + append ONE row to logs/signal_log.md. Append-only; no per-run gate for public links."
  made_by: Rika-Chan
  approved_by: Rika-Chan
  rationale: "Enables a fast 'paste a link → summary + product ideation' loop without manual logging or per-run approval, mirroring discovery's dec-20260607-001. Public URLs only; sensitive-domain URLs (health/finance/legal/auth/payment/gov-ID) → STOP + flag Rika-Chan, no fetch/write (privacy_rules.md §5). WebFetch registered in skill_trust_gate.md. Output is leads-not-facts; promotion to a claim still requires Nova-V. Append-only to signal_log (never overwrite/edit/delete existing rows, frontmatter, or header)."
  artifacts_ref: [.claude/commands/scout.md, agents/claude_team/hikari_intelligence_scout.md, .claude/agents/hikari_intelligence_scout.md, templates/product_scout_brief.md, logs/signal_log.md, llm_wiki/skill_trust_gate.md]
  reversible: true
  status: active

- decision_id: dec-20260607-001
  date: 2026-06-07
  workflow_id: phase_1b_signal_log_auto_append
  decision: "Standing approval — Hikari (and Minori coordination) may AUTO-APPEND signal rows to logs/signal_log.md, append-only, no per-run gate"
  made_by: Rika-Chan
  approved_by: Rika-Chan
  rationale: "Owner does not want to hand-write signal rows. Append-only (never overwrite/edit/delete existing rows, never touch frontmatter/header) satisfies the No-Overwrite Rule; logs/ already supports multi-writer append (cf. decision_log, source_log). Signals remain leads-not-facts; promotion to a claim still requires Nova-V."
  artifacts_ref: [logs/signal_log.md, .claude/commands/scout.md, agents/claude_team/hikari_intelligence_scout.md, agents/claude_team/minori_lead_conductor.md, plans/.../plan-phase-1-only-signal-decision-tracking.md]
  reversible: true
  status: active

