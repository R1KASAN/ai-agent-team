---
version: "1.0"
maintained_by: llm_wiki_reference_owner
authority: Rika-Chan
created: 2026-06-06
status: reference
---

# Agentic AI Patterns — This System's Design + Tool-to-Agent Mapping

Reference document. Explains (1) where the AI Agent Team sits in the standard Agentic AI
taxonomy, (2) which architectural pattern it uses, and (3) which memory/research tool belongs
to which agent. Use this to decide tool ownership and to avoid mis-assigning capabilities.

---

## 1. Agentic AI Taxonomy (industry consensus)

| Level | Name | Characteristics |
|-------|------|-----------------|
| L1 | Single-turn Assistant | One answer, no tools, no planning |
| L2 | Basic Agentic | Multi-step reasoning + tool use, single agent |
| L3 | Planning Agent | Planning, memory, goal-directed, multi-step autonomous |
| L4 | Multi-Agent Coordination | Multiple role-specialized agents working together |
| L5 | Autonomous Agent Network | Dynamic routing, self-correction, minimal human approval |

**This system sits at L4 — Orchestrated Multi-Agent Pipeline with Human-in-the-Loop (HITL).**

The HITL gates (Rika-Chan approvals) are an intentional design choice, not a missing feature.
Going fully L5 (autonomous) would remove the approval gates that the operating contract requires
for strategic, financial, legal, privacy, security, and production decisions.

---

## 2. Architectural Pattern: Supervisor-Worker (Orchestrator-Subagent)

```
Minori (Supervisor / Orchestrator)
  ├── Yuki  (Worker: Idea Challenger)
  ├── Nova  (Worker: Evidence Scout)
  ├── Vera  (Worker: Claim Verifier)
  ├── Sora  (Worker: Strategist)
  ├── Bumi  (Worker: Business Analyst)
  ├── Poom  (Worker: Product Manager)
  ├── Gina  (Worker: Governance Guardian)
  ├── Kai   (Worker: Kaizen Coach)
  ├── Mira  (Worker: Memory Librarian)
  └── Graphy (Worker: Knowledge Cartographer)
```

Anthropic terms this **orchestrator-worker** / **subagent** pattern.

### How this system differs from a fully-autonomous agent network (by design)

| Difference | Why this system chooses it |
|------------|----------------------------|
| Agent = Claude role prompt, not a separate LLM instance | Resource-efficient; context isolation still preserved via scoped handoffs |
| Agents communicate through artifact files, not live API calls | Auditable, human-readable, no network dependency |
| HITL approval gates | Rika-Chan must own strategic/legal/financial decisions |
| Sequential routing (not dynamic) | Reduces hallucinated routing; safer for production decisions |

### Where this system matches Anthropic's research-system patterns

- Memory persistence (`project_state.md`, `last_checkpoint.md`, context packs) ≈ external memory save
- Scoped context per agent (handoff "Scoped Context" block) ≈ subagent fresh-context-window
- Clear subagent boundaries (each agent file's *When to Use / When NOT to Use*) ≈ "objectives, output formats, boundaries"
- Synthesis step (Poom assembles the Product Opportunity Brief) ≈ lead-agent synthesis
- Citation attribution (Vera's `citation_audit`, draft v1.1) ≈ CitationAgent — folded into Vera rather than a separate agent

**Deliberate divergence:** Anthropic spawns 3–5 subagents *in parallel*; this system is
sequential-by-default. Parallel fanout requires the six conditions in
`token_optimization_rules.md` plus Rika-Chan approval.

---

## 3. Memory Layer Pipeline

```
Raw Inbox
   → Mira      (tag + governance metadata + mandatory wiki-write)
   → knowledge/ (Karpathy wiki = Obsidian vault root — plain markdown + [[backlinks]])
               Claude Code reads here directly. Obsidian app points vault here.
   → Mira graph-build backend (entity/relation extraction → graph_update) [Graphify pattern]
   → Obsidian backlinks/graph fallback
   → Tsumugi read-only recall
   → Nova-V optional deep source reading with NotebookLM-py, only when approved
   → Context Pack    (scoped agent context)
   → Agent Handoff

Obsidian vault root: AI Agent Team/knowledge/
```

---

## 4. Tool-to-Agent Ownership Matrix

| Agent | Graphify | Obsidian / `knowledge/` | NotebookLM-py |
|-------|----------|------------------------|---------------|
| Mira (Memory) | **Primary graph-build backend** | Write → **`knowledge/` (= vault root)** | — |
| Tsumugi (Second Brain) | — | **Primary reader — `knowledge/` direct** (README.md index first, then subfolders) | — |
| Nova-V (Evidence+Verify) | ❌ none | Read-only — `knowledge/README.md` index first, then selected notes | **Owner — Controlled Operational Use** (per-command approval; approved 2026-06-06) |
| Others | — | — | — |

### Ownership rules

- **`knowledge/` IS the Obsidian vault.** Vault root = `AI Agent Team/knowledge/`. Mira เขียนที่นี่
  ตรงๆ — ไม่มี sync layer แยก Claude Code อ่านได้โดยตรง Obsidian app ชี้ vault มาที่ folder นี้
- **Graphify** is knowledge *structuring* — owned by Mira as a backend graph-build capability.
  Discovery agents (e.g. Nova-V) never call Graphify directly; new findings re-enter the graph
  through Mira after verification.
- **Tsumugi** อ่าน `knowledge/` โดยตรง (primary) ก่อน fallback Obsidian graph — ลด external dependency
- **Nova-V** อ่าน `knowledge/README.md` เป็น vault index check ก่อน search (แทน Obsidian index เดิม)
  **index/selected relevant notes only; never load the full vault**
- **notebooklm-py** owned by **Nova-V only**. Status 2026-06-06: Controlled Operational Use —
  sources = public + Rika-Chan-owned non-sensitive; **per-command approval required**; no PII/secrets.
  Remains Trial / not Core. It is not a memory layer and not a truth source. Full rules:
  `llm_wiki/skill_trust_gate.md`.

### Answer to the recurring question: "Should Nova-V use all three?"

| Tool | Nova-V? | Reason |
|------|---------|--------|
| Graphify | **No** | Structuring is Mira's backend role; Nova-V hands verified findings to Mira |
| `knowledge/` (Obsidian vault) | **Yes — read-only, README index first** | Vault Index Check before searching; never load the full vault; never write |
| notebooklm-py | **Yes, gated optional tool** | Nova-V-only deep source reader; per-command approval required; not truth |

---

## 5. Related

- `agents/claude_team/nova_v.md` — merged evidence + verification
- `agents/_archive/graphy_knowledge_cartographer.md` (Graphify pattern)
- `agents/claude_team/mira_memory_librarian.md` (intake + Obsidian write)
- `llm_wiki/token_optimization_rules.md` (sequential-by-default; parallel conditions)
- `llm_wiki/skill_trust_gate.md` · Tool Trust Gate (NotebookLM-py activation)
