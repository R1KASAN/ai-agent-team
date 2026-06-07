---
version: "1.0"
maintained_by: llm_wiki_reference_owner
authority: Rika-Chan
---

# Tool Selection Rules

Guidelines for which tools agents should prefer, and when. Applies to Claude Team and Codex Team.

---

## Prefer Dedicated Tools Over Shell

| Task | Preferred | Avoid |
|------|-----------|-------|
| Read a file | `Read` tool | `cat` / `head` via Bash |
| Edit a file | `Edit` tool | `sed` / `awk` via Bash |
| Write a new file | `Write` tool | `echo >` via Bash |
| Search for a symbol | `grep` via Bash | Broad file reads |
| List directory | `ls` via Bash | Recursive `find /` |

---

## Web Search Rules

- Web search = **discovery only**. Never treat search results as verified facts.
- All web-sourced claims must pass through Nova-V claim verification before use downstream.
- Apply `source-quality-rubric` to every source before including it in `verified_evidence_pack.md`.
- Do not use web search in `tiny` or `small` budget steps unless the workflow explicitly includes it.

---

## NotebookLM / notebooklm-py Selection Rule

- **Tool reality (verified 2026-06-06):** `notebooklm-py` is an **unofficial** wrapper that **requires Google login via Playwright browser automation** (drives a real Google account = credential surface) and **uses undocumented Google APIs that can break without notice**. Not read-only — can add sources and generate/share content. See `llm_wiki/tool_capability_reference.md`.
- **Status (2026-06-06):** Rika-Chan approved for **Controlled Operational Use** (Trial / Medium-High / not Core; Tool Trust Gate stays active). Owner: **Nova-V only**. Allowed sources: public + Rika-Chan-owned non-sensitive project sources. Install/execute/login/auth/add-source/query require **per-command approval**. Forbidden: client PII, secrets/tokens/cookies, confidential/financial/legal/medical/private identity data, paywalled/login-only sources, external sharing, and direct query by any non-Nova-V agent. Full list: `llm_wiki/skill_trust_gate.md`. Ref: `https://github.com/teng-lin/notebooklm-py`.
- For Nova-V public low-risk `evidence_crosscheck`: prefer `notebooklm-py` **after** activation approval (Tool Trust Gate + audit + Rika-Chan + public-source test).
- If not activated → use manual NotebookLM or a prepared source pack.
- Use web search only for **discovery**.
- Use Jina Reader / Crawl4AI / Trafilatura only as **source-extraction helpers**, never as final evidence.
- NotebookLM output must be converted into structured notes for Nova-V verification, then into
  `verified_evidence_pack.md`, `gap_statements`, and a `logs/source_log.md` update.
- Nova-V verifies claims against the approved source docs it prepared. NotebookLM/notebooklm-py
  output is not final truth and is not a memory layer.

---

## File Loading Rules

1. Load only files declared in `files_likely_affected.md` or `workflow_plan.md`.
2. Do not load config files, lock files, or unrelated modules to "understand context."
3. If a file is needed but not listed → flag in the current artifact; do not load without approval.

---

## External Tool Rules

- No agent may call an external API, service, or tool not declared in its `SKILL.md`.
- Skills that request unlisted external calls → reject via `skill_trust_gate.md`.
- Governance-sensitive tools (auth, payment, db) require explicit approval before use.

---

> Skill gate: `skill_trust_gate.md` | Context rules: `token_optimization_rules.md`
