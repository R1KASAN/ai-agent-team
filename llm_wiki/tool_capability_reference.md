---
version: "1.0"
maintained_by: llm_wiki_reference_owner
authority: Rika-Chan
created: 2026-06-06
status: reference
purpose: "Ground-truth capability notes so agents do not misjudge what each memory/research tool actually does. Verified against each project's README on 2026-06-06."
---

# Tool Capability Reference

Short, verified notes on the three memory-layer tools. Read this before assigning a tool to an
agent. Capabilities are taken from each project's own README, not inferred from the name.

---

## Obsidian

- **What it is:** Local Markdown knowledge base. Files are plain `.md` on disk.
- **Does:** `[[wikilinks]]`, backlinks, graph view, tags, plugin ecosystem. No forced cloud.
- **Auth / network:** None required (local-first). Sync is optional/separate.
- **In this system:** Shared store. Write = Mira only. Read (index/selected notes only) = Tsumugi, Nova-V, and approved workflow owners.
- **Risk:** Low. Local files.

---

## notebooklm-py (`github.com/teng-lin/notebooklm-py`)

- **What it is:** **Unofficial** Python/CLI wrapper that drives Google NotebookLM.
- **Does (more than "reading"):** add sources (URL/YouTube/PDF/text/image/audio/video/Drive),
  **generate** audio overviews, videos, slide decks, quizzes, flashcards, infographics, mind maps,
  reports; chat/Q&A; web + Drive research agents; sharing/permissions; batch downloads.
- **Auth / network:** ⚠️ **Requires Google login via Playwright browser automation** (interactive
  login or cookie import). It **drives a real Google account** — this is a credential surface.
- **Official status:** ❌ Not Google. **Uses undocumented Google APIs that can break without notice.**
  README: "Use at Your Own Risk." MIT, ~15.9k ⭐.
- **In this system:** Nova-V's connector for source-grounded reading — **owner: Nova-V only.**
  No other agent may query it directly. Status 2026-06-06: **Controlled Operational Use** — public +
  Rika-Chan-owned non-sensitive project sources; install/execute/login/query require **per-command
  approval**; no client PII / secrets / confidential / paywalled-login / external sharing. Full
  Allowed/Forbidden list: `llm_wiki/skill_trust_gate.md`.
- **Risk:** Medium-High — credential use (Google account) + unofficial/undocumented API + can generate
  and share content, not just read. Remains Trial / not Core; Tool Trust Gate stays active.

---

## Graphify (`github.com/safishamsi/graphify`)

- **What it is:** Turns a folder of code/docs/media into a **queryable knowledge graph**.
  Strongest on **codebases** (27 languages, tree-sitter AST, "god nodes", architecture diagrams).
- **Does:** entity/relation extraction, community clustering, query/path-find/explain via CLI.
- **Input → Output:** folder → `graph.html` + `GRAPH_REPORT.md` + `graph.json`.
  **`graphify ./raw --obsidian` generates an Obsidian vault directly.**
- **Auth / network:** Code processed **locally** (tree-sitter). Docs/PDF/images are sent to an
  **LLM backend you configure** (Claude/Gemini/OpenAI/DeepSeek/Kimi/Bedrock/Ollama/claude-cli) —
  **requires an API key** for that backend (Ollama = fully local option).
- **In this system:** Knowledge-structuring backend for Mira-owned `graph_update.md`. Nova-V does **not** call it directly.
- **Risk:** Medium — API key + content sent to chosen LLM backend (unless Ollama local). Graph HTML
  gets unwieldy >~5000 nodes; "ghost duplicate" nodes possible.

---

## Quick Ownership Recap

| Tool | Owner agent | Others | Key gate |
|------|-------------|--------|---------|
| Obsidian | Mira (write) | Tsumugi/Nova-V read index/selected only | No full vault load |
| notebooklm-py | Nova-V only | All others read verified artifacts only | Controlled Operational Use — per-command approval; no sensitive data |
| Graphify | Mira backend | Nova-V reads selected graph outputs only | API key / pick Ollama for local |

> See also: `llm_wiki/agentic_ai_patterns.md` · `llm_wiki/tool_selection_rules.md` · `llm_wiki/skill_trust_gate.md`
