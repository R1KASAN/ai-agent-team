#!/usr/bin/env bash
set -euo pipefail

failures=0

check_file() {
  local path="$1"
  if [[ -f "$path" ]]; then
    echo "PASS file: $path"
  else
    echo "FAIL file missing: $path"
    failures=$((failures + 1))
  fi
}

check_dir() {
  local path="$1"
  if [[ -d "$path" ]]; then
    echo "PASS dir: $path"
  else
    echo "FAIL dir missing: $path"
    failures=$((failures + 1))
  fi
}

check_cmd() {
  local name="$1"
  if command -v "$name" >/dev/null 2>&1; then
    echo "PASS command: $name"
  else
    echo "FAIL command missing: $name"
    failures=$((failures + 1))
  fi
}

echo "== Required commands"
check_cmd bash
check_cmd rg

echo
echo "== Core operating docs"
check_file AGENTS.md
check_file CLAUDE.md
check_file README.md
check_file HOW_TO_USE.md
check_file CLONE_QUICKSTART.md
check_file AI_AGENT_TEAM_ARCHITECTURE.md

echo
echo "== Runtime files"
check_dir .claude/agents
check_dir .claude/commands
check_file .claude/agents/minori_lead_conductor.md
check_file .claude/commands/idea-gate.md
check_file workflows/idea_gate.md
check_file workflows/workflow_index.md
check_file templates/workflow_plan.md
check_file templates/runtime_status.md
check_file logs/runtime_status.md
check_file logs/agent_runs/.gitkeep

echo
echo "== Validation"
if [[ -x scripts/validate_active_alignment.sh ]]; then
  bash scripts/validate_active_alignment.sh
else
  echo "FAIL script not executable: scripts/validate_active_alignment.sh"
  failures=$((failures + 1))
fi

echo
if [[ "$failures" -gt 0 ]]; then
  echo "Clone-ready check failed: $failures issue(s)."
  exit 1
fi

echo "Clone-ready check passed."
