# AI Agent Team Memory/Evidence Full Alignment Roadmap

## Overview

Canonical stack:

```text
Raw input -> Mira tag/privacy -> knowledge/ LLM Wiki -> Graphify graph_update -> Obsidian backlinks/graph -> Tsumugi recall -> Nova-V uses NotebookLM-py only for approved deep source reading
```

Canonical command:

```text
/idea-gate [anything]
```

Optional shortcuts:

```text
/idea, /build, /memory, /recall, /scout, /next, /research, plus Codex utilities
```

Global constraints:

- Do not create `/ai` or `/team`.
- `/idea-gate` remains the single canonical front door.
- Shortcut commands remain available but are documented as optional aliases/utilities.
- NotebookLM-py is Nova-V-only and requires per-command Rika-Chan approval.
- NotebookLM-py is not a memory layer and not a truth source.
- Mira is the only normal writer to `knowledge/`.
- Tsumugi is read-only.
- Nova-V may read selected `knowledge/` notes and use NotebookLM-py only when approved.
- No full-vault load.
- Do not edit archive files or historical logs.
- Follow the No-Overwrite Rule for existing files.

Global validation exclusions:

- `agents/_archive/**`
- `.claude/agents/_archive/**`
- `archive/**`
- `handoffs/archive/**`
- `knowledge/archive/**`
- Superseded historical `handoffs/graph_update_*` unless explicitly approved

False-positive policy:

- Active route target to an archived agent is a failure.
- Archived mapping, migration notes, historical explanations, and "function preserved as backend" references are allowed.
- `verification_report` or raw `evidence_pack` text is not automatically a failure; it fails only when active downstream routing treats those as canonical inputs instead of `verified_evidence_pack`.

Reusable active ripgrep exclusions:

```bash
RG_ACTIVE_EXCLUDES=(
  --glob '!agents/_archive/**'
  --glob '!.claude/agents/_archive/**'
  --glob '!archive/**'
  --glob '!handoffs/archive/**'
  --glob '!knowledge/archive/**'
  --glob '!handoffs/graph_update_*'
  --glob '!*.draft.md'
)
```

## Phase 1 - Canonical Alignment

Objective:

Fix active docs/runtime drift so `/idea-gate` is the front door, shortcuts are optional, active agent names are consistent, and the Memory/Evidence stack matches the canonical ownership model.

Files to inspect:

- `AGENTS.md`
- `CLAUDE.md`
- `context.md`
- `HOW_TO_USE.md`
- `README.md`
- `.claude/commands/*.md`
- `.claude/agents/*.md` active runtime stubs only, excluding `.claude/agents/_archive/`
- `agents/agent_cards.md`
- `agents/claude_team/*.md`
- `agents/codex_team/*.md`
- `workflows/*.md`
- `skills/**/*.md`
- `.claude/skills/**/*.md`
- `templates/*.md`
- `knowledge/README.md`

Files to edit/create:

- `AGENTS.md`
- `CLAUDE.md`
- `HOW_TO_USE.md`
- `.claude/commands/idea-gate.md`
- `workflows/workflow_index.md`
- Active agent cards/stubs
- Active workflow docs
- Active skills/templates
- `knowledge/AGENTS_RULES.md`

Exact checklist:

- [x] Document `/idea-gate [anything]` as the single canonical front door in active public docs.
- [x] Document `/idea`, `/build`, `/memory`, `/recall`, `/scout`, `/next`, `/research`, and Codex utilities as optional shortcuts/utilities.
- [x] Confirm no `/ai` or `/team` command is created, proposed as canonical, or added to runtime commands.
- [x] Fix `AGENTS.md` team labels so Claude Team and Codex Team are not both named Codex Team.
- [x] Fix runtime path language to use `.claude/...`, not `.Codex/...`, where active runtime paths are described.
- [x] Remove active route targets to archived agent names from active routing tables, commands, and workflow docs.
- [x] Use active names only in active routes: Minori, Yuki, Nova-V, Sora, Bumi, Poom, Rika-Chan, Mira, Hikari, Tsumugi, Ichika, Aki, Coda, Kyuuei, Tessa.
- [x] Preserve archived-agent function mapping only as historical/backend explanation, not as active delegation.
- [x] Make `verified_evidence_pack` the canonical evidence artifact for downstream active workflows.
- [x] Update active downstream docs so Sora/Bumi/Poom consume `verified_evidence_pack` rather than old `verification_report` or raw `evidence_pack`.
- [x] Document Mira as the only normal `knowledge/` writer.
- [x] Document Tsumugi as read-only and `knowledge/README.md` first.
- [x] Document Nova-V as read-only over selected `knowledge/` notes.
- [x] Document NotebookLM-py as Nova-V-only, gated per command, not memory, not truth.
- [x] Create `knowledge/AGENTS_RULES.md` if absent; if present, create `knowledge/AGENTS_RULES.draft.md`.
- [x] In `knowledge/AGENTS_RULES.md`, define ownership, privacy levels, no full-vault load, Graphify/Obsidian fallback, and NotebookLM-py control rules.

Validation commands:

```bash
rg --glob '!agents/_archive/**' --glob '!.claude/agents/_archive/**' --glob '!**/_archive/**' --glob '!archive/**' --glob '!handoffs/archive/**' --glob '!knowledge/archive/**' --glob '!handoffs/graph_update_*' -n "Nova Evidence Scout|Vera Critical|Gina Governance|Kai Kaizen|Lexi LLM|Graphy Knowledge|Testa Codex|Bugsy Codex|Rex Codex|Pria Codex|Seco Codex|Shippo Codex" AGENTS.md CLAUDE.md HOW_TO_USE.md README.md context.md .claude agents workflows skills templates
rg --glob '!agents/_archive/**' --glob '!.claude/agents/_archive/**' --glob '!**/_archive/**' --glob '!archive/**' --glob '!handoffs/archive/**' --glob '!knowledge/archive/**' --glob '!handoffs/graph_update_*' -n "verified_evidence_pack" AGENTS.md CLAUDE.md HOW_TO_USE.md .claude agents workflows skills templates
rg --glob '!agents/_archive/**' --glob '!.claude/agents/_archive/**' --glob '!**/_archive/**' --glob '!archive/**' --glob '!handoffs/archive/**' --glob '!knowledge/archive/**' --glob '!handoffs/graph_update_*' --glob '!*.draft.md' -n "NotebookLM.*normal memory layer|notebooklm.*normal memory layer|NotebookLM.*source of truth|notebooklm.*source of truth|full-vault|entire vault|load.*whole vault" AGENTS.md CLAUDE.md HOW_TO_USE.md .claude agents workflows skills templates knowledge
rg --glob '!agents/_archive/**' --glob '!.claude/agents/_archive/**' --glob '!**/_archive/**' --glob '!archive/**' --glob '!handoffs/archive/**' --glob '!knowledge/archive/**' --glob '!handoffs/graph_update_*' -n "command: (ai|team)|slash_command: /(ai|team)|/ai |/team " .claude AGENTS.md CLAUDE.md HOW_TO_USE.md workflows
```

Validation interpretation:

- Review archived-agent-name hits manually.
- Fail only if the hit is an active `entry_agent`, `executing_agent`, route, trigger, handoff target, or "next agent" instruction.
- Allow hits that explicitly describe archived mappings or backend-preserved functions.

Expected final state:

Active docs, runtime stubs, workflows, skills, and templates describe one coherent v2 system. `/idea-gate` is the easiest entry point and all shortcuts are optional.

Risks / approval gates:

- Editing existing active files requires Rika-Chan approval under the No-Overwrite Rule.
- Any privacy, security, production, auth, payment, database, deployment, or infrastructure decision remains a Rika-Chan hard gate.
- Do not silently rewrite existing `knowledge/` notes.

What not to touch:

- `agents/_archive/`
- `.claude/agents/_archive/`
- `archive/`
- `handoffs/archive/`
- `knowledge/archive/`
- Historical handoff logs
- Superseded historical `handoffs/graph_update_*` unless explicitly approved

## Phase 2 - Knowledge Channel

Objective:

Specify a clear "Knowledge Channel" interface that makes read-only Q&A, knowledge maintenance, source checks, and knowledge-derived outputs easy, without replacing `/idea-gate`.

Files to inspect:

- `.claude/commands/`
- `workflows/workflow_index.md`
- `agents/claude_team/tsumugi_second_brain.md`
- `agents/claude_team/mira_memory_librarian.md`
- `agents/claude_team/nova_v.md`
- `knowledge/AGENTS_RULES.md`
- `knowledge/README.md`

Files to edit/create:

Proposed only unless separately approved:

- `.claude/commands/ask.md`
- `.claude/commands/maintain.md`
- `.claude/commands/check.md`
- `.claude/commands/outputs.md`
- `workflows/knowledge_ask.md`
- `workflows/knowledge_maintain.md`
- `workflows/knowledge_check.md`
- `workflows/knowledge_outputs.md`
- Matching skill stubs only if Rika-Chan approves command implementation

Exact checklist:

- [x] Propose `/ask` or equivalent as read-only Tsumugi Q&A.
- [x] `/ask` reads `knowledge/README.md` first, then selected notes only, then Obsidian graph/backlinks fallback.
- [x] `/ask` cites note path and heading where possible.
- [x] `/ask` never writes to `knowledge/`, logs, or graph files.
- [x] Propose `/maintain` or equivalent as Mira knowledge maintenance.
- [x] `/maintain` can merge, split, index, or update notes only after approval and No-Overwrite path listing.
- [x] Propose `/check` or equivalent as Nova-V contradiction/source check.
- [x] `/check` uses selected notes and source rules; NotebookLM-py remains gated and optional.
- [x] Propose `/outputs` or equivalent for generating artifacts from knowledge.
- [x] `/outputs` may draft briefs, plans, summaries, and task packets from knowledge, but cannot upgrade source claims without Nova-V verification.
- [x] Document all four proposed commands as optional knowledge-channel shortcuts, not replacements for `/idea-gate`.
- [x] Define exact files that would need changes before implementing each proposed command.

Validation commands:

```bash
rg --glob '!agents/_archive/**' --glob '!.claude/agents/_archive/**' --glob '!**/_archive/**' --glob '!archive/**' --glob '!handoffs/archive/**' --glob '!knowledge/archive/**' --glob '!handoffs/graph_update_*' -n "(/ask|/maintain|/check|/outputs)" .claude workflows AGENTS.md CLAUDE.md HOW_TO_USE.md knowledge
rg --glob '!agents/_archive/**' --glob '!.claude/agents/_archive/**' --glob '!**/_archive/**' --glob '!archive/**' --glob '!handoffs/archive/**' --glob '!knowledge/archive/**' --glob '!handoffs/graph_update_*' -n "single canonical front door|canonical front door|/idea-gate \\[anything\\]" AGENTS.md CLAUDE.md HOW_TO_USE.md .claude/commands/idea-gate.md
```

Validation interpretation:

- It is acceptable for `/ask`, `/maintain`, `/check`, and `/outputs` to appear as proposed commands.
- It is a failure if any proposed knowledge-channel command is documented as replacing `/idea-gate`.

Expected final state:

Knowledge-channel commands are specified as future or approved optional interfaces with clear ownership and safe read/write boundaries.

Risks / approval gates:

- Creating new runtime commands requires Rika-Chan approval.
- `/maintain` is a write path and must use No-Overwrite handling.
- `/check` cannot use NotebookLM-py without per-command approval.

What not to touch:

- Existing shortcut command behavior unless separately approved.
- Archive and historical logs.

## Phase 3 - Logging and Auditability

Objective:

Define forward-looking agent run logging so every significant workflow is auditable without relying on long-running chat history.

Files to inspect:

- `logs/`
- `workflows/*.md`
- `.claude/commands/*.md`
- `templates/`
- `agents/agent_cards.md`
- `knowledge/AGENTS_RULES.md`

Files to edit/create:

- `logs/agent_runs/`
- `templates/agent_run_log.md`
- Active command docs for workflows that must log
- Active workflow docs for workflows that must log
- Optional: `llm_wiki/workflow_patterns.md` logging rule update

Exact checklist:

- [x] Create `logs/agent_runs/` if missing.
- [x] Create `templates/agent_run_log.md`.
- [x] Define `run_id` format: `YYYYMMDD-HHMMSS-command-agent`.
- [x] Include `agent` field.
- [x] Include `command` field.
- [x] Include `mode` field.
- [x] Include `files_read` field.
- [x] Include `files_written` field.
- [x] Include `sources_used` field.
- [x] Include `approval_gates_hit` field.
- [x] Include `notebooklm_mission_info` field.
- [x] Include `final_artifact_paths` field.
- [x] Require logs for `/idea-gate`.
- [x] Require logs for `/memory`.
- [x] Require logs for `/recall`.
- [x] Require logs for `/research`.
- [x] Require logs for `/evidence-crosscheck`.
- [x] Require logs for `/idea`.
- [x] Require logs for `/build`.
- [x] Require logs for Codex utilities when they modify or verify files.
- [x] Require logs for `/governance-check`.
- [x] Redact sensitive/restricted content from logs.
- [x] NotebookLM-py mission info must include approval reference, source list, notebook/source action summary, query summary, and final artifact path.

Validation commands:

```bash
test -d logs/agent_runs
test -f templates/agent_run_log.md
rg --glob '!agents/_archive/**' --glob '!.claude/agents/_archive/**' --glob '!**/_archive/**' --glob '!archive/**' --glob '!handoffs/archive/**' --glob '!knowledge/archive/**' --glob '!handoffs/graph_update_*' -n "agent_run|run_id|files_read|files_written|sources_used|approval_gates_hit|notebooklm_mission_info|final_artifact_paths" logs templates workflows .claude/commands
```

Expected final state:

Future workflow runs can be audited from concise structured logs, and NotebookLM-py use is traceable.

Risks / approval gates:

- Logs must not expose sensitive/restricted content.
- Logging templates must not encourage dumping full source content, full vault content, or full chat history.

What not to touch:

- Historical logs.
- Archived handoffs.
- Existing private credentials or external tool state.

## Phase 4 - Wiki/Graph Schema

Objective:

Standardize `knowledge/` note frontmatter and graph mapping so Mira, Tsumugi, Nova-V, and future validation can reason over notes deterministically.

Files to inspect:

- `knowledge/README.md`
- `knowledge/_templates/note.md`
- `knowledge/reference/decision_ledger.md`
- `knowledge/reference/lessons_ledger.md`
- `knowledge/instincts/README.md`
- `agents/claude_team/mira_memory_librarian.md`
- `agents/claude_team/tsumugi_second_brain.md`
- `agents/claude_team/nova_v.md`
- Current non-archived `handoffs/graph_update_*.md` only if explicitly in scope

Files to edit/create:

- `knowledge/_templates/note.md`
- `knowledge/AGENTS_RULES.md`
- `agents/claude_team/mira_memory_librarian.md`
- `agents/claude_team/tsumugi_second_brain.md`
- `agents/claude_team/nova_v.md`
- `llm_wiki/agentic_ai_patterns.md`
- Optional: `templates/graph_update.md`

Exact checklist:

- [x] Add canonical `type` frontmatter.
- [x] Add canonical `status` frontmatter.
- [x] Add canonical `owner` frontmatter.
- [x] Add canonical `privacy_level` frontmatter.
- [x] Add canonical `source_type` frontmatter.
- [x] Add canonical `source_url_or_path` frontmatter.
- [x] Add canonical `confidence` frontmatter.
- [x] Add canonical `related_entities` frontmatter.
- [x] Add canonical `graph_node_type` frontmatter.
- [x] Add canonical `graph_relations` frontmatter.
- [x] Add canonical `last_verified_at` frontmatter.
- [x] Define graph node type `Idea`.
- [x] Define graph node type `Decision`.
- [x] Define graph node type `Instinct`.
- [x] Define graph node type `Source`.
- [x] Define graph node type `Research`.
- [x] Define graph node type `Spec`.
- [x] Define graph node type `Risk`.
- [x] Define graph node type `Product`.
- [x] Define graph node type `Agent`.
- [x] Define graph node type `Workflow`.
- [x] Define edge mapping `relates_to`.
- [x] Define edge mapping `derived_from`.
- [x] Define edge mapping `supports`.
- [x] Define edge mapping `contradicts`.
- [x] Define edge mapping `supersedes`.
- [x] Define edge mapping `owned_by`.
- [x] Define edge mapping `produced_by`.
- [x] Define edge mapping `consumed_by`.
- [x] Define edge mapping `blocks`.
- [x] Define edge mapping `mitigates`.
- [x] Update Mira docs so graph updates are emitted from the canonical schema.
- [x] Update Tsumugi docs so recall can filter by `type`, `privacy_level`, `graph_node_type`, and `related_entities`.
- [x] Update Nova-V docs so selected note reads respect schema and do not treat wiki notes as final evidence.

Validation commands:

```bash
rg --glob '!agents/_archive/**' --glob '!.claude/agents/_archive/**' --glob '!**/_archive/**' --glob '!archive/**' --glob '!handoffs/archive/**' --glob '!knowledge/archive/**' --glob '!handoffs/graph_update_*' -n "graph_node_type|graph_relations|related_entities|last_verified_at|source_url_or_path" knowledge agents llm_wiki templates
rg --glob '!agents/_archive/**' --glob '!.claude/agents/_archive/**' --glob '!**/_archive/**' --glob '!archive/**' --glob '!handoffs/archive/**' --glob '!knowledge/archive/**' --glob '!handoffs/graph_update_*' -n "Idea|Decision|Instinct|Source|Research|Spec|Risk|Product|Agent|Workflow" knowledge agents llm_wiki templates
```

Expected final state:

New and maintained knowledge notes share a consistent schema and graph mapping. Existing notes are not mass-rewritten unless approved.

Risks / approval gates:

- Mass migration of existing notes requires a separate approval.
- Sensitive/restricted notes must not be exposed in graph updates without approval.
- Schema changes must not break Tsumugi's low-cost README-first recall path.

What not to touch:

- `knowledge/archive/`
- Historical graph updates
- Existing canonical notes unless a migration plan and approval exist

## Phase 5 - NotebookLM Intake Pipeline

Objective:

Define a controlled NotebookLM-py intake pipeline that lets Nova-V deep-read approved sources without bypassing verification, source logging, Mira writing, or graph updates.

Files to inspect:

- `agents/claude_team/nova_v.md`
- `agents/claude_team/mira_memory_librarian.md`
- `agents/claude_team/tsumugi_second_brain.md`
- `.claude/commands/research.md`
- `.claude/skills/research-pipeline/SKILL.md`
- `skills/claude/evidence-pack/SKILL.md`
- `skills/claude/claim-verification/SKILL.md`
- `llm_wiki/skill_trust_gate.md`
- `llm_wiki/tool_selection_rules.md`
- `llm_wiki/tool_capability_reference.md`
- `logs/source_log.md`

Files to edit/create:

- `agents/claude_team/nova_v.md`
- `agents/claude_team/mira_memory_librarian.md`
- `.claude/commands/research.md`
- `.claude/skills/research-pipeline/SKILL.md`
- `llm_wiki/tool_selection_rules.md`
- `templates/notebooklm_mission.md`
- Optional: `templates/verified_evidence_pack.md`

Exact checklist:

- [x] Document pipeline: Nova-V approved NotebookLM-py mission -> structured output -> Nova-V verification -> Mira writes `knowledge/research/[slug].md` -> Mira emits `graph_update.md` -> Tsumugi can later recall it.
- [x] Require Mira privacy/source intake before any source is considered for NotebookLM-py.
- [x] Block sensitive/restricted/client/paywalled/login-only/private source import without explicit approval.
- [x] Require per-command Rika-Chan approval for NotebookLM-py install, login, auth, add-source, query, or export actions.
- [x] State that NotebookLM output is never truth.
- [x] Require Nova-V to verify NotebookLM-derived claims against source material.
- [x] Require `logs/source_log.md` update before downstream use.
- [x] Require NotebookLM mission/run log when used.
- [x] Require Mira, not Nova-V, to write `knowledge/research/[slug].md`.
- [x] Require Mira to emit graph update after verified research write.
- [x] Require Tsumugi to recall NotebookLM-derived research only through `knowledge/` and graph metadata, not NotebookLM directly.
- [x] Define fallback when NotebookLM-py is unavailable: direct source reading, prepared source pack, or manual notes.
- [x] Define stop condition for expired login or unavailable tool.

Validation commands:

```bash
rg --glob '!agents/_archive/**' --glob '!.claude/agents/_archive/**' --glob '!**/_archive/**' --glob '!archive/**' --glob '!handoffs/archive/**' --glob '!knowledge/archive/**' --glob '!handoffs/graph_update_*' -n "NotebookLM-py|notebooklm-py|NotebookLM" agents .claude llm_wiki workflows skills templates
rg --glob '!agents/_archive/**' --glob '!.claude/agents/_archive/**' --glob '!**/_archive/**' --glob '!archive/**' --glob '!handoffs/archive/**' --glob '!knowledge/archive/**' --glob '!handoffs/graph_update_*' -n "not final truth|never truth|not truth|source_log|knowledge/research|Mira writes|Nova-V.*approval|per-command" agents .claude llm_wiki workflows skills templates
```

Expected final state:

NotebookLM-py is a controlled optional deep-source reader owned by Nova-V. It feeds verified artifacts and Mira-owned memory updates; it never becomes memory or truth.

Risks / approval gates:

- NotebookLM-py uses a credentialed unofficial wrapper; every action remains gated.
- Any sensitive/restricted source is a hard stop.
- High-stakes domains require primary sources and Rika-Chan escalation on conflict.

What not to touch:

- NotebookLM credentials
- Browser auth state
- External notebooks
- Private/client data
- Historical NotebookLM notes or logs

## Phase 6 - Validation Suite

Objective:

Add static checks that catch future alignment drift while avoiding false positives from archive files, historical notes, and allowed backend mappings.

Files to inspect:

- `setup_validation_checklist.md`
- `llm_wiki/`
- Existing scripts, if any
- `AGENTS.md`
- `CLAUDE.md`
- `.claude/commands/`
- `.claude/agents/`
- `agents/`
- `workflows/`
- `skills/`
- `templates/`
- `knowledge/`

Files to edit/create:

- `scripts/validate_active_alignment.sh` or `validation/active_alignment_checks.md`
- `setup_validation_checklist.md`
- Optional: `llm_wiki/workflow_patterns.md`

Exact checklist:

- [x] Add check for no active routing to archived agents.
- [x] Exclude `agents/_archive/**`.
- [x] Exclude `.claude/agents/_archive/**`.
- [x] Exclude `archive/**`.
- [x] Exclude `handoffs/archive/**`.
- [x] Exclude `knowledge/archive/**`.
- [x] Exclude superseded historical `handoffs/graph_update_*` unless explicitly approved.
- [x] Treat archived mapping and historical explanation as allowed hits.
- [x] Check no `verification_report` or raw `evidence_pack` is used as canonical downstream input in active route docs.
- [x] Allow legacy/template/migration mentions of `verification_report` and `evidence_pack` when not canonical downstream inputs.
- [x] Check no NotebookLM as normal memory layer.
- [x] Check no NotebookLM as truth source.
- [x] Check no full-vault load instruction.
- [x] Check `/idea-gate` documented as front door.
- [x] Check shortcuts documented as optional.
- [x] Check knowledge writes only through Mira.
- [x] Check Tsumugi read-only.
- [x] Check Nova-V NotebookLM-py gated.
- [x] Document manual review rules for grep hits that cannot be classified by regex alone.

Validation commands:

```bash
scripts/validate_active_alignment.sh
rg --glob '!agents/_archive/**' --glob '!.claude/agents/_archive/**' --glob '!**/_archive/**' --glob '!archive/**' --glob '!handoffs/archive/**' --glob '!knowledge/archive/**' --glob '!handoffs/graph_update_*' --glob '!*.draft.md' -n "entry_agent: .*Nova Evidence Scout|entry_agent: .*Vera Critical|entry_agent: .*Gina Governance|entry_agent: .*Kai Kaizen|entry_agent: .*Lexi LLM|entry_agent: .*Graphy Knowledge|entry_agent: .*Testa Codex|entry_agent: .*Bugsy Codex|entry_agent: .*Rex Codex|entry_agent: .*Pria Codex|entry_agent: .*Seco Codex|entry_agent: .*Shippo Codex|executing_agent: .*Nova Evidence Scout|executing_agent: .*Vera Critical|handoff.*Nova Evidence Scout|handoff.*Vera Critical|handoff.*Gina Governance|handoff.*Testa Codex" AGENTS.md CLAUDE.md HOW_TO_USE.md .claude agents workflows skills templates
rg --glob '!agents/_archive/**' --glob '!.claude/agents/_archive/**' --glob '!**/_archive/**' --glob '!archive/**' --glob '!handoffs/archive/**' --glob '!knowledge/archive/**' --glob '!handoffs/graph_update_*' --glob '!*.draft.md' -n 'Input:.*verification_report\.md|Input:.*(^|[^[:alnum:]_])evidence_pack\.md|input_artifact:.*verification_report\.md|input_artifact:.*(^|[^[:alnum:]_])evidence_pack\.md|source_artifact:.*verification_report\.md|source_artifact:.*(^|[^[:alnum:]_])evidence_pack\.md' AGENTS.md CLAUDE.md .claude agents workflows skills templates
rg --glob '!agents/_archive/**' --glob '!.claude/agents/_archive/**' --glob '!**/_archive/**' --glob '!archive/**' --glob '!handoffs/archive/**' --glob '!knowledge/archive/**' --glob '!handoffs/graph_update_*' --glob '!*.draft.md' -n "NotebookLM.*normal memory layer|notebooklm.*normal memory layer|NotebookLM.*source of truth|notebooklm.*source of truth|full-vault|entire vault|load.*whole vault" AGENTS.md CLAUDE.md HOW_TO_USE.md .claude agents workflows skills templates knowledge
rg --glob '!agents/_archive/**' --glob '!.claude/agents/_archive/**' --glob '!**/_archive/**' --glob '!archive/**' --glob '!handoffs/archive/**' --glob '!knowledge/archive/**' --glob '!handoffs/graph_update_*' --glob '!*.draft.md' -n "/idea-gate.*front door|front door.*idea-gate|single canonical front door|shortcut.*optional|optional shortcuts" AGENTS.md CLAUDE.md HOW_TO_USE.md .claude/commands/idea-gate.md workflows/workflow_index.md
rg --glob '!agents/_archive/**' --glob '!.claude/agents/_archive/**' --glob '!**/_archive/**' --glob '!archive/**' --glob '!handoffs/archive/**' --glob '!knowledge/archive/**' --glob '!handoffs/graph_update_*' --glob '!*.draft.md' -n "Mira.*only normal writer|Tsumugi.*read-only|Nova-V.*NotebookLM-py.*approval|per-command Rika" AGENTS.md CLAUDE.md HOW_TO_USE.md .claude agents workflows skills knowledge
```

Expected final state:

Validation can be run repeatedly without noisy archive false positives and without banning legitimate migration text.

Risks / approval gates:

- Static checks should be read-only.
- Any script that edits files is out of scope and requires separate approval.
- Regex cannot fully replace manual review for allowed archived mapping text.

What not to touch:

- Archive files
- Historical handoff logs
- Historical graph updates
- Existing external tool state

## Phase 7 - Backlog / Deferred Enhancements

Objective:

Record optional improvements that are useful but not required for the canonical alignment.

Files to inspect:

- `llm_wiki/`
- `knowledge/`
- `workflows/`
- `.claude/commands/`
- `logs/`
- `plans/`

Files to edit/create:

- `plans/backlog.md` or a backlog section in this plan
- Future workflow specs only when approved
- Future command docs only when approved

Exact checklist:

- [x] Add graph-assisted routing proposal.
- [x] Add richer `/ask` citations by heading proposal.
- [x] Add run dashboard proposal.
- [x] Add knowledge health report proposal.
- [x] Add stale note detector proposal.
- [x] Add decision/lesson promotion automation proposal.
- [x] Add integration tests for command docs proposal.
- [x] Mark each backlog item as deferred, optional, and not part of Phase 1 canonical alignment.
- [x] Require a new workflow plan and Rika-Chan approval before implementing any deferred enhancement.

Validation commands:

```bash
rg --glob '!agents/_archive/**' --glob '!.claude/agents/_archive/**' --glob '!**/_archive/**' --glob '!archive/**' --glob '!handoffs/archive/**' --glob '!knowledge/archive/**' --glob '!handoffs/graph_update_*' -n "graph-assisted routing|heading citation|run dashboard|knowledge health|stale note|decision/lesson promotion|integration tests for command docs|Deferred|deferred" plans llm_wiki workflows .claude knowledge
```

Expected final state:

Future work is visible, clearly deferred, and not mixed into the required alignment checklist.

Risks / approval gates:

- Do not implement backlog items without a new approved plan.
- Graph-assisted routing may increase complexity and must preserve `/idea-gate` as front door.
- Run dashboards and automation may touch logs or privacy-sensitive metadata.

What not to touch:

- Production workflows
- External integrations
- Archive files
- Historical logs

## Implementation Instruction

When this file is attached and the user says ‘Implement this plan’, execute only the unchecked checklist items. Before editing existing files, list the paths to be edited and treat this plan plus the user’s explicit implementation request as Rika-Chan approval for those listed active paths. Do not modify archive files or historical handoff logs. Exclude `agents/_archive/`, `.claude/agents/_archive/`, `archive/`, `handoffs/archive/`, `knowledge/archive/`, and superseded historical graph updates unless explicitly approved. After implementation, run the validation commands and summarize remaining unchecked items.
