---
version: "1.0"
maintained_by: lexi_llm_wiki_keeper
authority: Rika-Chan
note: "Backup created before applying strict spec source context map completion on 2026-06-05."
---

# Source Context Map

Documents where context enters the system at each layer of the memory stack. This is a reference map — not a permission registry.

---

## Memory Stack Layers

```
Raw Inbox → Graphify → Obsidian Vault → NotebookLM → Context Pack → Agent Handoff
```

### Layer 1 — Raw Inbox

**What enters:** Rika-Chan notes, pasted text, screenshots, URLs, uploaded files, session summaries.
**Handler:** Mira Memory Librarian (`/memory-intake`)
**Gate:** Privacy level assigned before anything moves downstream. PII → hard stop.

### Layer 2 — Graphify

**What enters:** Privacy-cleared `knowledge_intake_note.md` from Mira.
**Handler:** Graphy Knowledge Cartographer
**Gate:** No restricted data without Rika-Chan approval. Produces `graph_update.md`.

### Layer 3 — Obsidian Vault

**What enters:** `graph_update.md` and structured knowledge notes.
**Handler:** External tool (Obsidian). Data must not contain restricted-level content.
**Gate:** Third-party tool — confirm privacy terms before use (`governance/privacy_rules.md` §6).

### Layer 4 — NotebookLM

**What enters:** Curated, privacy-cleared knowledge from Obsidian.
**Handler:** External tool (Google NotebookLM). Same privacy gate as Layer 3.
**Gate:** Rika-Chan approval required if data is `sensitive` or `restricted`.

### Layer 5 — Context Pack

**What enters:** Distilled, scoped content from Layers 1–4 relevant to the current workflow step.
**Handler:** Minori + current agent
**Gate:** Context budget applies. Only the minimum data needed for the current step.

### Layer 6 — Agent Handoff

**What enters:** Output artifact path + next-step metadata from `handoff.md`.
**Handler:** Receiving agent
**Gate:** Artifact Gate — input artifact must exist before agent starts.

---

## Context Sources by Agent Type

| Agent | Loads From | Must Not Load |
|-------|-----------|--------------|
| Minori | `current_context_pack.md`, raw input | Full project history |
| Nova | Research question, `idea_challenge_brief.md` | Full codebase |
| Vera | `evidence_pack.md` | Raw web search results directly |
| Coda | `codex_task_packet.md`, `files_likely_affected.md` | Full codebase |
| Kai | Artifact paths only | Full artifact content |
| Gina | Active artifact under review | Unrelated project files |

---

## External Tools Referenced

The following tools are referenced in this system's memory stack. This list is documentation only — it does not constitute approval to use, install, or trust these tools. Each requires Rika-Chan approval and privacy review before use.

| Tool | Layer | Privacy Gate |
|------|-------|-------------|
| Obsidian | Layer 3 | No restricted data; confirm retention terms |
| NotebookLM | Layer 4 | Rika-Chan approval if sensitive/restricted |

---

> Privacy rules: `governance/privacy_rules.md` | Data governance: `governance/data_governance_checklist.md`
