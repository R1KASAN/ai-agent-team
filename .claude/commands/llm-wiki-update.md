---
command: llm-wiki-update
description: Propose an update to the LLM Wiki or add a skill candidate note.
entry_agent: Minori (gate)
context_budget: small
required_input: proposed rule change, new pattern, skill candidate note, or correction
optional_input: supporting artifact paths, constraints, risk notes, approval notes; never full chat history
forbidden_actions: bypassing Minori, skipping artifact gates, starting downstream workflows automatically, using large/dynamic context without approval, overwriting existing files without approval
produces: llm_wiki_update.md (status: proposed)
approval_gate: all updates status:proposed until Rika-Chan approves; no auto-apply
stop_condition: llm_wiki_update.md produced; no llm_wiki/ file is modified without approval
ref: workflows/llm_wiki_update.md
---

All updates are proposals only. Minori gates the request, then the owner drafts `llm_wiki_update.md` with the proposed change and rationale. Rika-Chan approves or rejects before any `llm_wiki/` file is touched.
