---
artifact: global_env_backup
produced_by: codex
created_at: 2026-06-07
source_file: /Users/ark1/.claude.json
change: removed_invalid_subagent_model_override
version: "1.0"
---

# Global Env Backup — 20260607-001

Before the Phase 1 e2e proof retry config fix, `/Users/ark1/.claude.json` had this top-level `env`
block:

```json
{
  "ENABLE_EXPERIMENTAL_MCP_CLI": "true",
  "CLAUDE_CODE_SUBAGENT_MODEL": "claude-opus-4-6-thinking"
}
```

Applied fix: removed `CLAUDE_CODE_SUBAGENT_MODEL` and left `ENABLE_EXPERIMENTAL_MCP_CLI` untouched.
