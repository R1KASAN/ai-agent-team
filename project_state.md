---
project: AI-Human Startup Studio OS
version: "1.3"
phase: 3
status: setup_complete
os_edition: "Startup Studio OS v1.0 (14 agents + Tessa conditional)"
last_updated: "2026-06-08"
current_workflow: none
last_checkpoint: "chk-007 — Phase 1 e2e proof close-out: global subagent model override removed; Workflow retry executed; Test 4 closed as confirmed-diagnosed-and-blocked by args-stringification tool limitation"
---

# Project State

## Current Phase

Phase 3 setup complete, now operating as **Startup Studio OS v1.0** — solo-founder, token-optimized,
14 active agents + Tessa conditional. Canonical direction: `system_prompt_v1.md`. System remains in
First Run Mode; first safe command is `/idea-gate`.

## Active Roster (15)

**Claude Team:** Mi Minori · Yu Yuki · NV Nova-V · So Sora · Bu Bumi · Po Poom · Ri Rika-Chan ·
Mr Mira · Hi Hikari · Ts Tsumugi · Ic Ichika
**Codex Team:** Ak Aki · Co Coda · QA Kyuuei
**Conditional:** Te Tessa (has_ui_component → after Kyuuei)

## Active Workflow

None. Run `/idea-gate` to begin any work, or a direct-intent command (`/scout` `/recall` `/next` `/memory` `/idea` `/build`).

## Open Items

| Item | Decision Needed | Owner |
|------|-----------------|-------|
| ~~Remove orphaned `.agents/` directory~~ | Deleted 2026-06-06 | ✅ Rika-Chan |
| ~~Install `caveman` skill~~ | Installed 2026-06-06 | ✅ Rika-Chan |
| ~~Claude Code restart~~ | Restarted 2026-06-06 | ✅ Rika-Chan |
| ~~Review v1 workflows (governance_check, llm_wiki_update, kaizen_review, qa_review)~~ | Clean — no patch needed | ✅ 2026-06-06 |
| ~~Mira / Tsumugi / Ichika — live-prove the memory-loop chain~~ | Live-proven 2026-06-07: `/memory`→Mira wrote `knowledge/inbox/workflow-tool-args-string-bug.md` (+1 README index line, `handoffs/graph_update_20260607_004.md`, `handoffs/knowledge_intake_note_20260607_004.md`); `/recall`→Tsumugi read README-first and wrote `handoffs/resurface_pack_20260607_001.md`; `/next`→Ichika returned exactly one sentence, one action | ✅ 2026-06-07 |
| ~~Test 3 gate (`approval_request_20260607_001.md`) — stuck AWAITING RIKA-CHAN DECISION~~ | Resolved by waiver 2026-06-07: confirmed deliberate proof-test scaffold; 3 open questions waived, `context_budget: dynamic` granted one-time for Test 4 only. Recorded `dec-20260607-003` (`logs/decision_log.md`), mirrored to `decision_ledger.md` | ✅ Rika-Chan |
| ~~Push "AI Assistant: Scattered Client Feedback" idea from Bumi's stop → Aki~~ | **Pipeline reached Aki — `codex_task_packet.md` (ctp-20260607-001) exists in `handoffs/`, `source_prd` → approved `prd.md` (prd-20260607-001).** Crossed all 3 named gates + 1 triggered gate with real owner decisions: Gate① strategic fork → one-shot tool (`dec-20260607-004`); Gate② POB approved (`dec-20260607-005`, `product_opportunity_brief.md`); Gate③ PRD approved (`dec-20260607-006`, `prd.md`+companions); Gate④ Aki's auth/payments/infra halt → resolved via Shape-A ruling (`dec-20260607-007`: minimal shared invite-link/password, not a full auth system; paid-API provider deferred to a Coda-proposes/Rika-Chan-approves in-build checkpoint). Next: Coda builds from the packet (still gated — provider/spend approval, access-mechanism extension, prod deploy, and any persistent-state discovery all route back to Rika-Chan per the packet's named Approval Gates) | ✅ 2026-06-07 |
| ~~`args`-as-string Workflow-tool bug — confirm + fix/workaround (Test 4)~~ | **Closed — workaround CONFIRMED, 3rd+4th independent confirmation.** Isolated A/B probe: top-level `Workflow` tool delivers `args` as a JSON-string (`typeof "string"`, guard would abort) vs. inline `workflow({scriptPath}, realObject)` launcher delivers a genuine object (`typeof "object"`, guard passes) — reproducible, deterministic. Real heavy `idea-stresstest.js` run via the launcher then independently confirmed it: `args.idea` resolved cleanly, 3 Challenge agents ran to completion (9 real assumptions), Evidence phase began (9 agents) — 226s of genuine fan-out — before an unrelated session event (`/model` switch) killed the background task externally (NOT the args bug — that aborts in <1s with zero fan-out). `lessons_ledger.md` `confirm_count` 2→3, `promoted: no→yes`; instinct written: `knowledge/instincts/workflow-args-typed-launcher.md`. Per "do not loop retrying the same fix," the heavy run was NOT repeated — already proven 4×, repeating would waste ~200k+ tokens | ✅ 2026-06-07 |

## Open Risks

None active. See `logs/risk_log.md`.

## Phase Completion

| Phase | Status | Notes |
|-------|--------|-------|
| Phase 1 — Core OS | Complete | 16 files |
| Phase 2 — Agent Files + Templates | Complete | 64 files |
| Phase 3 — Skills + Runtime | Complete | 105 files |
| Alignment Sprint — 2026-06-05 | Complete | Subagent registration 21/21; skill trust gate |
| Evidence-Pipeline Upgrade — 2026-06-06 | Complete | idea-pipeline; Nova/Vera v1.2; notebooklm-py |
| **Startup Studio OS v1.0 Pivot — 2026-06-06** | **Complete** | **Phases A–E: 14-agent roster, Nova-V merge, 6 new commands, /build, swaps live** |

## Recent Changes (God Mode Pipeline — 2026-06-06)

- **notebooklm-py v0.7.0** installed on Python 3.14 (`/opt/homebrew/bin/python3.14 -m notebooklm`).
  Login: winskych@gmail.com · auth: `~/.notebooklm/profiles/default/storage_state.json`.
- **Tsumugi v1.1** — `knowledge/` primary read (README index first), Obsidian graph fallback.
- **Nova-V v1.1** — Step 2 reads `knowledge/README.md` vault index before external search;
  triggers Mira to write `knowledge/research/[slug].md` after evidence verified.
- **`/research` skill** (`research-pipeline` v1.0, Trial/Controlled Operational Use):
  `/research [URL/PDF/YouTube/.md]` → Mira intake → vault check → NotebookLM analyze →
  `knowledge/research/[slug].md` → README index update. Per-command approval gate maintained.
- **Alias:** `notebooklm` → `python3.14 -m notebooklm` added to `~/.zshrc`.

## Recent Changes (Gate Scope Pre-Clarification — 2026-06-08)

- **Gate Scope Pre-Clarification added:** any Aki/build route now requires `expected_gates` and
  `gate_decisions` in `workflow_plan.md` before Aki can start.
- **Runtime proof artifact:** `handoffs/workflow_plan_20260608_001.md` verifies `/idea-gate` emits
  gate fields before Poom/Aki handoff.
- **Docs synced:** `HOW_TO_USE.md`, `README.md`, `CLAUDE.md`, `AGENTS.md`,
  `workflows/workflow_index.md`, and runtime specs now describe Expected Gates + Pre-Decide vs
  Defer.
- **Validation:** `scripts/validate_active_alignment.sh` checks the rule in active docs and runtime
  stubs.

## Recent Changes (Phase 1 e2e Proof Close-out — 2026-06-07)

- **Root cause fixed:** removed invalid global `CLAUDE_CODE_SUBAGENT_MODEL=claude-opus-4-6-thinking`
  from `/Users/ark1/.claude.json`; left `ENABLE_EXPERIMENTAL_MCP_CLI=true` untouched.
- **Backup note:** `handoffs/global_env_backup_20260607_001.md` records the original env block.
- **Verification:** trivial Codex subagent spawn returned `subagent model check passed`, confirming
  the exposed subagent surface no longer fails immediately on the stale model override.
- **Memory loop updated:** appended 1 decision row and 1 correction lesson row; emitted
  `handoffs/graph_update_20260607_002.md` linking the corrected lesson to
  `idea_20260607_calorie_app_proof_sample`.
- **Test 4 closed (2026-06-07, Claude Code session):** retried `.claude/workflows/idea-stresstest.js`
  via the `Workflow` tool. The retry aborted instantly with `dynamic_not_approved` despite passing
  `rika_dynamic_approved: true`. A diagnostic probe confirmed the root cause is a **Workflow-tool
  limitation, not an environment/auth issue**: `args` arrives inside the script as a JSON-encoded
  **string**, so `args.rika_dynamic_approved` evaluates `undefined`/falsy. This is the *same* lesson
  already staged in `lessons_ledger.md` — now **reconfirmed** (`confirm_count` 1→2), proving it is a
  tool-level behaviour rather than a Codex-session quirk. Decision: do not run the heavy/strategic
  stresstest merely to force a pass; Test 4 closes as **confirmed-diagnosed-and-blocked**. See
  `handoffs/graph_update_20260607_003.md`.

## Recent Changes (Karpathy LLM-Wiki Layer — 2026-06-06)

- **New `knowledge/` wiki layer** (Karpathy LLM-Wiki pattern) — Claude-queryable plain markdown, no
  external tool. Folders: `inbox/ ideas/ research/ market/ reference/` + `README.md` (index) +
  `_templates/note.md`.
- **Mira v1.2** — mandatory **wiki-write** as Step 4 of `memory_intake`: writes every `/memory` note
  to `knowledge/inbox/[slug].md` + appends `knowledge/README.md` index. `sensitive/restricted` items
  skip the wiki write until Rika-Chan approves.
- **`memory_intake` v1.1** — Step 4 added; Memory Stack Integration now routes through `knowledge/`.
- **CLAUDE.md Memory Layer** — `knowledge/` inserted after Mira, before the graph; Tsumugi reads
  `knowledge/` notes directly. No-Overwrite honoured: 3 drafts → approved → swapped → deleted.

## Recent Changes (Startup Studio OS v1.0 Pivot — 2026-06-06)

- **Roster pivot 21 → 14 (+Tessa conditional).** 11 source + 12 runtime agents archived
  (`_archive/`, retained not deleted). 6 new agents: Nova-V, Kyuuei, Hikari, Tsumugi, Ichika, Rika-Chan.
- **CLAUDE.md v2** (Operating Contract) + **agents/agent_cards.md v2** live. Backup
  `CLAUDE.pre-v1.backup.md` intact.
- **Nova-V merge** — `workflows/product_idea_debate.md` v2.0: single evidence+verify agent (loop ≤2)
  replaces Nova→Vera; Gina/Kai demoted to backend reference (not active steps).
- **`workflows/workflow_index.md` v2.0** — direct-intent command table + backend/optional sections.
- **6 new commands:** `/scout` (Mi→Hi) · `/recall` (Mi→Ts) · `/next` (Mi→Ic) · `/memory` (Mr alias) ·
  `/idea` (full pipeline) · `/build` (Ak→Co→QA→(Te if UI)→[Ri], precondition: pb or owner task).
- **5 codex-extra commands** marked `tier: optional_utility` + entry_agents corrected from archived
  agents to active (Kyuuei / Coda).
- **Output codes synced** — `+gu` (graph_update) `+ur` (qa_ux_report); `ep`→verified_evidence_pack;
  `[Te]` added to signing initials — in `system_prompt_v1.md` + `.summary.md` (CLAUDE.md already had them).
- **No-Overwrite honoured** — all 9 existing-file edits drafted → approved → swapped → drafts deleted;
  no `.draft.md` pollution in `.claude/commands/`.

## Recent Changes (Evidence-Pipeline Upgrade 2026-06-06)

- `idea-pipeline` skill; `agentic_ai_patterns.md`; `tool_capability_reference.md`.
- notebooklm-py → Controlled Operational Use (now owned by Nova-V backend).
- Nova/Vera v1.2 (capability now merged into Nova-V); `evidence_source_rules.md` v1.1.

## Recent Changes (Alignment Sprint 2026-06-05)

- `.claude/agents/*.md` migrated to native frontmatter; registration verified.
- `skill_trust_gate.md` updated; invented-agent scan CLEAN; orphaned `.agents/` flagged.

## Last Decision

Startup Studio OS v1.0 pivot Phases A–E approved and merged; all 5 drift decisions confirmed; drafts
swapped to live (Rika-Chan, 2026-06-06).

## Notes

Update this file at each session start and phase change. Do not use long-running chat as a substitute.
