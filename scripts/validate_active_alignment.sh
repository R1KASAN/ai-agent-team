#!/usr/bin/env bash
set -euo pipefail

# Read-only static checks for active AI Agent Team alignment.
# Archives, historical logs, and superseded graph updates are excluded by default.

RG_ACTIVE_EXCLUDES=(
  --glob '!agents/_archive/**'
  --glob '!.claude/agents/_archive/**'
  --glob '!**/_archive/**'
  --glob '!_archive/**'
  --glob '!archive/**'
  --glob '!handoffs/archive/**'
  --glob '!knowledge/archive/**'
  --glob '!handoffs/graph_update_*'
  --glob '!*.draft.md'
  --glob '!backups/**'
  --glob '!*.pre-strict-spec-backup.md'
  --glob '!*.pre-test.md'
)

ACTIVE_SCOPE=(
  AGENTS.md
  CLAUDE.md
  HOW_TO_USE.md
  README.md
  context.md
  .claude
  agents
  workflows
  skills
  templates
  knowledge
  llm_wiki
)

failures=0

check_absent() {
  local label="$1"
  local pattern="$2"
  echo "== $label"
  if rg "${RG_ACTIVE_EXCLUDES[@]}" -n "$pattern" "${ACTIVE_SCOPE[@]}"; then
    echo "FAIL: $label"
    failures=$((failures + 1))
  else
    echo "PASS: $label"
  fi
}

check_present() {
  local label="$1"
  local pattern="$2"
  shift 2
  echo "== $label"
  if rg "${RG_ACTIVE_EXCLUDES[@]}" -n "$pattern" "$@"; then
    echo "PASS: $label"
  else
    echo "FAIL: $label"
    failures=$((failures + 1))
  fi
}

check_absent "no active route targets to archived agents" "entry_agent: .*Nova Evidence Scout|entry_agent: .*Vera Critical|entry_agent: .*Gina Governance|entry_agent: .*Kai Kaizen|entry_agent: .*Lexi LLM|entry_agent: .*Graphy Knowledge|entry_agent: .*Testa Codex|entry_agent: .*Bugsy Codex|entry_agent: .*Rex Codex|entry_agent: .*Pria Codex|entry_agent: .*Seco Codex|entry_agent: .*Shippo Codex|executing_agent: .*Nova Evidence Scout|executing_agent: .*Vera Critical|handoff.*Nova Evidence Scout|handoff.*Vera Critical|handoff.*Gina Governance|handoff.*Testa Codex"

check_absent "no legacy evidence artifacts as canonical downstream input" 'Input:.*verification_report\.md|Input:.*(^|[^[:alnum:]_])evidence_pack\.md|input_artifact:.*verification_report\.md|input_artifact:.*(^|[^[:alnum:]_])evidence_pack\.md|source_artifact:.*verification_report\.md|source_artifact:.*(^|[^[:alnum:]_])evidence_pack\.md'

check_absent "no NotebookLM as normal memory or source of truth" "NotebookLM.*normal memory layer|notebooklm.*normal memory layer|NotebookLM.*source of truth|notebooklm.*source of truth|full-vault|entire vault|load.*whole vault"

check_absent "no /ai or /team runtime command" "command: (ai|team)|slash_command: /(ai|team)|/ai |/team "

check_present "idea-gate front door documented" "/idea-gate.*front door|front door.*idea-gate|single canonical front door" AGENTS.md CLAUDE.md HOW_TO_USE.md .claude/commands/idea-gate.md workflows/workflow_index.md

check_present "shortcuts documented as optional" "shortcut.*optional|optional shortcuts" AGENTS.md CLAUDE.md HOW_TO_USE.md .claude/commands/idea-gate.md workflows/workflow_index.md

check_present "Mira writer rule documented" "Mira.*only normal writer|only normal writer.*Mira" AGENTS.md CLAUDE.md HOW_TO_USE.md .claude agents workflows skills knowledge

check_present "Tsumugi read-only documented" "Tsumugi.*read-only|read-only.*Tsumugi" AGENTS.md CLAUDE.md HOW_TO_USE.md .claude agents workflows skills knowledge

check_present "Nova-V NotebookLM-py gate documented" "Nova-V.*NotebookLM-py.*approval|NotebookLM-py.*Nova-V.*approval|per-command Rika" AGENTS.md CLAUDE.md HOW_TO_USE.md .claude agents workflows skills knowledge llm_wiki

check_present "Gate Scope Pre-Clarification documented" "Gate Scope Pre-Clarification" HOW_TO_USE.md README.md CLAUDE.md AGENTS.md workflows/workflow_index.md workflows/idea_gate.md templates/workflow_plan.md agents/claude_team/minori_lead_conductor.md .claude/agents/minori_lead_conductor.md .claude/commands/idea-gate.md .claude/commands/prd-to-codex-tasks.md skills/claude/workflow-router/SKILL.md

check_present "Pre-Decide vs Defer documented" "Pre-Decide vs Defer" HOW_TO_USE.md README.md CLAUDE.md AGENTS.md workflows/workflow_index.md workflows/idea_gate.md templates/workflow_plan.md agents/claude_team/minori_lead_conductor.md .claude/agents/minori_lead_conductor.md .claude/commands/idea-gate.md .claude/commands/prd-to-codex-tasks.md skills/claude/workflow-router/SKILL.md

check_present "Aki-bound workflows block missing gate preclarification" "Gate Scope Pre-Clarification.*before Aki|Gate Scope Pre-Clarification.*stop before Aki|stop before Aki.*Gate Scope Pre-Clarification" workflows/product_idea_to_prd.md workflows/prd_to_codex_tasks.md .claude/commands/product-idea-to-prd.md .claude/commands/prd-to-codex-tasks.md

check_present "Aki refuses unresolved gate preclarification" "Aki must not start|stop.*before technical translation|Do not use before.*Gate Scope Pre-Clarification" agents/codex_team/aki_system_architect.md .claude/agents/aki_system_architect.md

echo
if [[ "$failures" -gt 0 ]]; then
  echo "Active alignment validation failed: $failures check(s)."
  echo "Review allowed false positives separately: archived mappings and historical notes are allowed."
  exit 1
fi

echo "Active alignment validation passed."
