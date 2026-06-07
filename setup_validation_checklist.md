---
version: "1.5"
phase: 3
validated_by: "Rika-Chan"
validated_at: "2026-06-06"
status: setup_closeout_complete
latest_change: "Clone readiness + Level 1 Runtime status layer — see Current Readiness section"
---

# Setup Validation Checklist — Phase 1, Phase 2, and Phase 3

## Setup Closeout Status

Phase 1–3 setup is structurally complete. First safe command remains `/idea-gate`.

Closeout constraints confirmed:

- No product workflow was started.
- No Nova research, PRD, Codex build loop, Dynamic Workflow, LINE workflow, market research, or implementation was started.
- No third-party skill or repository was installed, cloned, imported, executed, or promoted.
- Existing draft/proposal files remain untouched unless Rika-Chan separately approves cleanup.
- `llm_wiki/source_context_map.pre-strict-spec-backup.md` remains as the approved backup for auditability.

Check every item before starting Phase 2. Mark `[x]` when confirmed.

## Core Files

- [x] `CLAUDE.md` exists and contains all 22 required operating contract topics
- [x] `README.md` exists with system overview and how-to-start instructions
- [x] `project_state.md` exists and reflects current phase
- [x] `current_context_pack.md` exists and is scoped to current session
- [x] `last_checkpoint.md` exists with Phase 1 completion notes
- [x] `setup_validation_checklist.md` exists (this file)

## Agent Index

- [x] `agents/agent_cards.md` exists with summary table for all 21 agents (14 Claude + 7 Codex)
- [x] No full agent detail files were created during the Phase 1 pass (reserved for Phase 2)

## Workflows

- [x] `workflows/workflow_index.md` exists with all 11 workflows listed
- [x] `workflows/idea_gate.md` exists with full input classification + Orchestrator Contract

## Templates and Handoffs

- [x] `handoffs/handoff_template.md` exists with all required YAML fields
- [x] `context_packs/context_pack_template.md` exists with all required YAML fields

## Governance

- [x] `governance/approval_gates.md` exists with all approval trigger items
- [x] `governance/forbidden_actions.md` exists with all hard-stop actions
- [x] `governance/data_governance_checklist.md` exists (deferred in Phase 1, completed in Phase 2)

## LLM Wiki

- [x] `llm_wiki/skill_trust_gate.md` exists with scoring rubric + 4 status levels + seed registry
- [x] `llm_wiki/token_optimization_rules.md` exists with 12 rules + Context Budget Enum + Dynamic Workflow policy

## System Rules Verification

- [x] No product code was created in Phase 1
- [x] No third-party skill was installed or cloned
- [x] No existing file was overwritten without approval
- [x] `.claude/` runtime files were not created during the Phase 1 pass (reserved for Phase 3)
- [x] Context Budget Enum (`tiny | small | medium | large | dynamic`) is used in workflow files
- [x] First recommended command is `/idea-gate`

## Phase 2 Readiness

- [x] All Phase 1 checklist items above are checked
- [x] Rika-Chan has reviewed `CLAUDE.md`, `approval_gates.md`, `forbidden_actions.md`, and `skill_trust_gate.md`
- [x] Phase 2 scope is understood: agent detail files, templates, remaining workflows, log stubs

---

## Phase 2 Validation

Mark `[x]` when confirmed. Check before starting Phase 3.

### Agent Files

- [x] `agents/claude_team/` — 14 agent files created (Minori through Lexi)
- [x] `agents/codex_team/` — 7 agent files created (Coda through Shippo)

### Templates

- [x] `templates/` — 22 artifact templates created (workflow_plan through kaizen_report)

### Workflow Files

- [x] 10 classified workflow files created (product_idea_debate through kaizen_review)
- [x] 2 Dynamic Workflow stubs created (security_audit, diff_review) — inactive, approval required
- [x] 1 sub-workflow created (memory_consolidate)
- [x] Workflow total in `workflows/` folder = 15 (2 Phase 1 + 13 Phase 2)

### Log Stubs

- [x] `logs/decision_log.md` created
- [x] `logs/assumption_log.md` created
- [x] `logs/risk_log.md` created
- [x] `logs/source_log.md` created
- [x] `logs/kaizen_log.md` created

### Governance (deferred from Phase 1)

- [x] `governance/data_governance_checklist.md` created
- [x] `governance/privacy_rules.md` created
- [x] `governance/security_guardrails.md` created

### Phase 2 Rules Verification

- [x] No `.claude/` files were created during the Phase 2 pass
- [x] No `skills/` files were created during the Phase 2 pass
- [x] No product code was created
- [x] No workflow was run automatically
- [x] No existing file was overwritten

### Canonical File Counts

| Metric | Value |
|--------|-------|
| Phase 1 planned | 15 |
| Phase 1 actual | 16 (15 planned + `handoffs/workflow_plan_test_001.md` test artifact, now archived) |
| Phase 2 planned | 64 |
| Phase 2 actual | 64 |
| Total planned (excl. test artifact) | 79 |
| Total actual (incl. test artifact) | 80 |
| Missing files | 0 |
| Overwrites | 0 |

---

## Phase 3 Validation

Mark `[x]` when confirmed. Run after Phase 3 is complete.

### Runtime Files

- [x] `.claude/agents/` — 21 runtime stubs created; all have `trigger:`, `not_trigger:`, and `ref:` fields
- [x] `.claude/commands/` — 17 slash command files created; all have `context_budget:` frontmatter field
- [x] `.claude/skills/` — 28 skill directories created; each contains one `SKILL.md` (no flat `.md` files)
- [x] `.claude/workflows/` — 3 runtime stubs created (codex-build-loop, security-audit, diff-review)

### Skill Source Stubs

- [x] `skills/claude/` — 16 `SKILL.md` source stubs created
- [x] `skills/codex/` — 12 `SKILL.md` source stubs created
- [x] `karpathy-coding-guidelines` and `debug-mantra` both have `trust_status: Reference Only`

### LLM Wiki

- [x] `llm_wiki/` — 8 new files created (README + 7 rule/policy files); 10 total including Phase 1
- [x] `llm_wiki/source_context_map.md` — documentation-only note confirmed in frontmatter and body

### Dynamic Workflow Safety

- [x] `security-audit` and `diff-review` both have `status: stub_only` and `activation_requires: Rika-Chan approval`
- [x] `llm_wiki/dynamic_workflow_policy.md` explicitly states Dynamic Workflow is not the default

### Phase 3 Rules Verification

- [x] No product code, app code, deployment config, DB schema, auth/payment code was created
- [x] No third-party skill was installed, cloned, imported, or executed
- [x] No existing file was overwritten without approval
- [x] Final acceptance audit completed and all 3 recommended patches applied

### Agent Registry Lock (§4.1 / §32) — merged 2026-06-05

- [x] Agent Registry Lock rule present in `agents/claude_team/minori_lead_conductor.md`
- [x] Routing Guard lists all 14 Claude Team agents including Mira Memory Librarian and Graphy Knowledge Cartographer
- [x] Routing Guard includes Codex Team routing policy (via slash commands, not direct Minori delegation)
- [x] No invented agent names used in any workflow plan or agent file

### Nova Runtime v2 Compliance (§13 / §32) — merged 2026-06-05

- [x] `agents/claude_team/nova_evidence_scout.md` includes Nova Research Runtime v2 flow (11 steps)
- [x] `gap_statements` is a named formal output in Nova's outputs table
- [x] `logs/source_log.md` update is mandatory before Nova handoff (stated in Required Artifacts)
- [x] `notebooklm-py` documented as Conditional Default — not installed or executed
- [x] Fallback path (manual NotebookLM → prepared source pack → direct source notes) documented

### Evidence Crosscheck Entry Agent (§29.3 / §31 / §32) — merged 2026-06-05

- [x] `.claude/commands/evidence-crosscheck.md` has `entry_agent: minori_lead_conductor`
- [x] `workflows/evidence_crosscheck.md` has `entry_agent: Minori Lead Conductor`

### Required LLM Wiki Files (§28 / §32) — merged 2026-06-05

- [x] `llm_wiki/domain_sources_registry.md` exists with named trusted sources per domain
- [x] `llm_wiki/evidence_source_rules.md` exists with source tier definitions

### Entry Gates (§29 / §32) — merged 2026-06-05

- [x] `workflows/product_idea_to_prd.md` has Entry Gate block
- [x] `workflows/prd_to_codex_tasks.md` has Entry Gate block
- [x] `workflows/codex_build_loop.md` has Entry Gate block
- [x] `workflows/qa_review.md` has Entry Gate block

### Canonical File Counts (Phase 3)

| Metric | Value |
|--------|-------|
| Phase 3 planned | 105 |
| Phase 3 actual | 105 |
| Grand total (all phases) | 185 |
| Missing files | 0 |
| Overwrites | 0 |

---

## Alignment Sprint Validation — 2026-06-05

Mark `[x]` when confirmed. Append-only; supersedes nothing above.

### Native Subagent Registration (task 1)

- [x] All 21 `.claude/agents/*.md` carry native `name:` (lowercase-hyphen) + `description:`
- [x] Stale `agent:` frontmatter key removed from all 21
- [x] Registration validation: 21/21 valid, 0 duplicate names
- [x] Restart required for Claude Code to load the change (noted in `last_checkpoint.md`)

### Skill Trust Gate Reconciliation (task 4)

- [x] `llm_wiki/skill_trust_gate.md` records Core/Trial/Reference Only/Rejected for all audited skills
- [x] `.claude/skills/{handoff,grill-me,grill-with-docs,write-a-skill}/SKILL.md` carry `trust_status: Core` (consistent with gate)

### Alignment Verification (tasks 2–3, no edits required)

- [x] `.claude/commands/evidence-crosscheck.md` confirmed `entry_agent: minori_lead_conductor`
- [x] `handoffs/handoff_template.md` + `context_packs/context_pack_template.md` confirmed scoped-context compliant
- [x] Invented-agent regression scan across repo: CLEAN

### Memory-State Reconciliation

- [x] `project_state.md` refreshed (was stale at Phase 1) → Phase 3 complete
- [x] `last_checkpoint.md` advanced chk-002 → chk-003

### Backlog From chk-003 (resolved later)

- [x] Remove orphaned `.agents/` directory — resolved 2026-06-06
- [x] Install `caveman` skill — resolved 2026-06-06
- [x] Claude Code restart — resolved 2026-06-06

---

## Startup Studio OS v1.0 Pivot Validation — 2026-06-06

Mark `[x]` when confirmed. Append-only; supersedes nothing above. Pivot from 21-agent setup to the
14-agent (+Tessa conditional) Startup Studio OS v1.0. Canonical: `system_prompt_v1.md`.

### Phase A — Foundation

- [x] `CLAUDE.pre-v1.backup.md` created as rollback point (intact)
- [x] `system_prompt_v1.md` + `system_prompt_v1.summary.md` imported as canonical direction
- [x] `agents/_archive/` + `.claude/agents/_archive/` directories created

### Phase B — New Agent Files

- [x] 6 new agent files: nova_v · kyuuei · hikari · tsumugi · ichika · rika_chan

### Phase C — Archive + Active Roster

- [x] 11 source agents archived (`agents/_archive/`): Gina·Kai·Lexi·Nova·Vera·Bugsy·Pria·Rex·Seco·Shippo·Testa
- [x] 12 runtime agents archived (`.claude/agents/_archive/`): above + Graphy
- [x] 15 active runtime agents registered (`.claude/agents/`): 11 Claude + 3 Codex + Tessa conditional
- [x] Mira graph-build ownership + Tessa conditional trigger (has_ui_component) verified
- [x] Graphy source retained (deregistered, not deleted) — backend infra preserved

### Phase D Part 1 — Contract + Cards

- [x] `CLAUDE.md` v2 live (Operating Contract — Startup Studio OS v1.0)
- [x] `agents/agent_cards.md` v2 live (14 + Tessa)
- [x] 4 gaps fixed: routing /recall /next · /build precondition · output codes gu/ur · /memory alias

### Phase D Part 2 — Workflows + Commands

- [x] `workflows/product_idea_debate.md` v2.0 — Nova-V replaces Nova→Vera; Gina/Kai = backend reference
- [x] `workflows/workflow_index.md` v2.0 — direct-intent table + Nova-V + Tessa conditional + backend/optional sections
- [x] 5 new core commands created: `/scout` `/recall` `/next` `/memory` `/idea`
- [x] 5 codex-extra commands marked `tier: optional_utility` + `core_flow: false`
- [x] codex-extra entry_agents fixed (archived → active): debug/security/ship→Kyuuei; refactor/pr→Coda
- [x] Output codes synced (+`gu` +`ur`, `ep`→verified_evidence_pack) in `system_prompt_v1.md` + summary + `[Te]` signing initial
- [x] No-Overwrite honoured: all 9 existing-file edits drafted, approved, swapped, drafts deleted
- [x] No `.draft.md` pollution remaining in `.claude/commands/`

### Phase E — State + Build Command

- [x] `.claude/commands/build.md` created — route Ak→Co→QA→(Te if UI)→[Ri]; precondition: pb or owner task
- [x] `project_state.md` updated to v1.0 pivot, checkpoint chk-005
- [x] `last_checkpoint.md` advanced chk-004 → chk-005
- [x] `setup_validation_checklist.md` updated (this section)

### Pivot Rules Verification

- [x] No active agent file references an archived agent as owner (codex-extra entry_agents corrected)
- [x] Archived agents retained, not deleted (capability preserved as backend per CLAUDE.md table)
- [x] No-Overwrite Rule applied to every existing file touched
- [x] First safe command remains `/idea-gate`; no product workflow auto-started

### Deferred / Future Pass

- [x] Backlog from chk-003 resolved: remove orphaned `.agents/` dir · install `caveman` · Claude Code restart
- [x] Review remaining v1 workflow files (governance_check, llm_wiki_update, kaizen_review, qa_review) for v2 agent-name consistency
- [x] `agents/agent_cards.md` cross-check vs new command set

---

## Current Readiness — 2026-06-08

- [x] Level 1 Runtime status layer is active and status-only.
- [x] `runtime_tracking` exists in `templates/workflow_plan.md`.
- [x] `templates/runtime_status.md` exists.
- [x] `logs/runtime_status.md` exists.
- [x] `/idea-gate` runtime proof exists at `handoffs/workflow_plan_20260608_002.md`.
- [x] Clone quickstart exists at `CLONE_QUICKSTART.md`.
- [x] Clone readiness check exists at `scripts/clone_ready_check.sh`.
- [x] Active alignment validator exists at `scripts/validate_active_alignment.sh`.
- [x] `bash scripts/clone_ready_check.sh` passes.
- [x] `./scripts/validate_active_alignment.sh` passes.

---

## Phase 2 Scope (for reference)

Files to create in Phase 2:

- `agents/claude_team/` — 14 agent files
- `agents/codex_team/` — 7 agent files
- `templates/` — 22 artifact templates
- Remaining `workflows/` files — **13 files**:
  - 10 classified workflows: product_idea_debate, evidence_crosscheck, product_idea_to_prd, prd_to_codex_tasks, codex_build_loop, qa_review, governance_check, memory_intake, llm_wiki_update, kaizen_review
  - 3 additional (§28): security_audit (Dynamic Workflow), diff_review (Dynamic Workflow), memory_consolidate (sub-workflow)
- `logs/decision_log.md`, `assumption_log.md`, `risk_log.md`, `source_log.md`, `kaizen_log.md`
- `governance/data_governance_checklist.md`, `privacy_rules.md`, `security_guardrails.md`

## Phase 3 Scope (for reference)

Files to create in Phase 3:

- `.claude/agents/` — 21 compact runtime stubs (one per agent); ref to `agents/` full files
- `.claude/commands/` — 17 slash command definitions; ref to `workflows/` full files
- `.claude/skills/<skill>/SKILL.md` — 28 skill directories (Claude Code-compatible); each contains one concise SKILL.md referencing `skills/claude/` or `skills/codex/`
- `.claude/workflows/` — 3 runtime stubs (codex-build-loop, security-audit, diff-review)
- `skills/claude/<skill>/SKILL.md` — 16 full Claude skill stubs
- `skills/codex/<skill>/SKILL.md` — 12 full Codex skill stubs
- `llm_wiki/` — 8 remaining files (README, model_selection_rules, tool_selection_rules, evidence_source_rules, workflow_patterns, dynamic_workflow_policy, anti_patterns, source_context_map)

Phase 3 total: 105 files

---

## Active Alignment Validation — Memory/Evidence + Slash Command

- [x] Full roadmap exists at `plans/ai_agent_team_memory_evidence_full_alignment_plan.md`.
- [x] Active alignment validator exists at `scripts/validate_active_alignment.sh`.
- [x] Validator excludes archive and historical paths: `agents/_archive/`, `.claude/agents/_archive/`, `archive/`, `handoffs/archive/`, `knowledge/archive/`, backups, and superseded historical graph updates.
- [x] Validator checks `/idea-gate` as canonical front door.
- [x] Validator checks shortcut commands are optional.
- [x] Validator checks active route targets do not point to archived agents.
- [x] Validator checks legacy evidence artifacts are not canonical downstream inputs.
- [x] Validator checks Mira writes, Tsumugi reads, and Nova-V gates NotebookLM-py.
- [x] Validator is read-only and does not rewrite files.
