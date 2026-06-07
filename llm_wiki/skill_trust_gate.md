---
version: "1.0"
maintained_by: llm_wiki_reference_owner
authority: Rika-Chan (final approval for Core status)
---

# Skill Trust Gate

Every skill must be scored here before use. No skill may be executed without passing this gate.

## Scoring Rubric (score each criterion: pass / fail / unknown)

| # | Criterion | Weight |
|---|-----------|--------|
| 1 | Clear SKILL.md with purpose, trigger, and boundaries | Required |
| 2 | Clear trigger conditions (when to use, when not to use) | Required |
| 3 | No suspicious shell or network behavior | Required |
| 4 | No credential request or secret access | Required |
| 5 | No hidden destructive operation | Required |
| 6 | Useful for an actual workflow (not vanity) | Required |
| 7 | Reduces token/context usage or improves reliability | Preferred |
| 8 | Maintainer / repo / source credibility known | Preferred |
| 9 | Low security risk overall | Required |
| 10 | License clarity (if applicable) | Preferred |

**A skill cannot reach Core or Trial status if any Required criterion is unknown or fail.**

---

## Status Levels

| Status | Meaning | Usage Rule |
|--------|---------|-----------|
| **Core** | Passed all required criteria + Rika-Chan approved | May be used in default workflows |
| **Trial** | Passed required criteria; not yet fully audited | Explicit note required in workflow plan |
| **Reference Only** | Useful as inspiration; not safe to install/run | May inspire custom skills; must not be installed |
| **Rejected** | Failed a required criterion | Must not be used in any form |

---

## Skill Registry

---

### mattpocock/skills — write-a-skill
- **Repo:** `https://github.com/mattpocock/skills` · 118k stars · trusted maintainer
- **Status:** **Core** ✓
- **Audited:** 2026-06-05 | **Approved by:** Rika-Chan 2026-06-05
- **Purpose:** Guide creation of new skills with proper SKILL.md structure
- **Trigger:** "Use when user wants to create, write, or build a new skill"
- **Shell/Network:** None | **Credentials:** None | **Destructive:** None (creates files only)
- **All Required Criteria:** PASS
- **Risk:** Low
- **Note:** Retroactive gate record — skill was already installed before audit

---

### mattpocock/skills — handoff
- **Repo:** `https://github.com/mattpocock/skills` · 118k stars · trusted maintainer
- **Status:** **Core** ✓
- **Audited:** 2026-06-05 | **Approved by:** Rika-Chan 2026-06-05
- **Purpose:** Compact current conversation into a handoff document for another agent
- **Trigger:** User invokes handoff with optional next-session context
- **Shell/Network:** Writes to OS temp dir only (not workspace) | **Credentials:** Actively redacts API keys/PII | **Destructive:** None
- **All Required Criteria:** PASS
- **Risk:** Low
- **Note:** Retroactive gate record — skill was already installed before audit

---

### mattpocock/skills — grill-me
- **Repo:** `https://github.com/mattpocock/skills` · 118k stars · trusted maintainer
- **Status:** **Core** ✓
- **Audited:** 2026-06-05 | **Approved by:** Rika-Chan 2026-06-05
- **Purpose:** Interview user relentlessly about a plan until all decision branches are resolved
- **Trigger:** User requests plan stress-test or says "grill me"
- **Shell/Network:** None | **Credentials:** None | **Destructive:** None
- **All Required Criteria:** PASS
- **Risk:** Low
- **Note:** Retroactive gate record — skill was already installed before audit

---

### mattpocock/skills — grill-with-docs
- **Repo:** `https://github.com/mattpocock/skills` · 118k stars · trusted maintainer
- **Status:** **Core** ✓
- **Audited:** 2026-06-05 | **Approved by:** Rika-Chan 2026-06-05
- **Purpose:** Interview-based planning that challenges assumptions against domain model; updates CONTEXT.md and ADRs
- **Trigger:** User requests design review against existing documentation
- **Shell/Network:** Reads CONTEXT.md/ADR files only | **Credentials:** None | **Destructive:** None
- **All Required Criteria:** PASS
- **Risk:** Low
- **Note:** Retroactive gate record — skill was already installed before audit

---

### mattpocock/skills — caveman
- **Repo:** `https://github.com/mattpocock/skills` · 118k stars · trusted maintainer
- **Status:** **Trial** (installed 2026-06-06 — Rika-Chan approved)
- **Audited:** 2026-06-05 | **Approved by:** Rika-Chan 2026-06-05 (Trial status only)
- **Purpose:** Compressed communication mode; reduces token usage ~75% while preserving technical accuracy
- **Trigger:** `/caveman` — user wants to minimize token overhead
- **Shell/Network:** None documented | **Credentials:** None | **Destructive:** None
- **Required Criteria:** All PASS (SKILL.md not fully fetched — assume consistent with repo pattern)
- **Risk:** Low — pure communication style modifier
- **Kaizen alignment:** High — directly reduces context waste per `llm_wiki/token_optimization_rules.md`
- **Install gate:** Rika-Chan must approve install before use. Do not install until approved.

---

### anthropics/skills — skill-creator
- **Repo:** `https://github.com/anthropics/skills` · 147k stars · OFFICIAL Anthropic
- **Status:** **Reference Only**
- **Audited:** 2026-06-05 | **Decision by:** Rika-Chan 2026-06-05
- **Purpose:** Create, benchmark, and iteratively improve Claude skills with eval loops
- **Shell:** YES — executes `python -m scripts.*`, `kill $PID`, `cp -r`, opens browser
- **Destructive:** YES — overwrites `SKILL.md` content during optimization iterations
- **Security:** No sandboxing for Python script execution; scripts can read/write arbitrary local paths
- **Failed Criteria:** C3 (shell/network), C5 (destructive ops), C9 (security risk)
- **Risk:** Medium-High — not suitable for this project's workflow without isolated environment
- **Use:** Read as pattern reference for eval loop design. Do not install or execute.

---

### VoltAgent/awesome-claude-code-subagents — multi-agent-coordinator
- **Repo:** `https://github.com/VoltAgent/awesome-claude-code-subagents` · 21.2k stars
- **Status:** **Reference Only**
- **Audited:** 2026-06-05 | **Decision by:** Rika-Chan 2026-06-05
- **Purpose:** Coordinate multiple concurrent agents across distributed workflows
- **Tools declared:** Read, Write, Edit, Glob, Grep | **Model:** opus
- **Shell/Network:** None | **Credentials:** None | **Destructive:** None documented
- **Blocker:** VoltAgent's own published disclaimer — *"We do not audit or guarantee the security or correctness of any subagent."* Agents are community-contributed.
- **Failed Criteria:** C8 (maintainer credibility unknown per individual agent)
- **Risk:** Low-Medium (file ops only, but unaudited source)
- **Use:** Read for orchestration pattern inspiration only.

---

### VoltAgent/awesome-claude-code-subagents — workflow-orchestrator
- **Repo:** `https://github.com/VoltAgent/awesome-claude-code-subagents` · 21.2k stars
- **Status:** **Reference Only**
- **Audited:** 2026-06-05 | **Decision by:** Rika-Chan 2026-06-05
- **Purpose:** Design, implement, and optimize complex state machine workflows with error handling
- **Tools declared:** Read, Write, Edit, Glob, Grep | **Model:** opus
- **Shell/Network:** None | **Credentials:** None | **Destructive:** None documented
- **Blocker:** Same VoltAgent unaudited disclaimer as above
- **Risk:** Low-Medium
- **Use:** Read for state machine and Saga pattern inspiration only.

---

### VoltAgent/awesome-claude-code-subagents — agent-organizer
- **Repo:** `https://github.com/VoltAgent/awesome-claude-code-subagents` · 21.2k stars
- **Status:** **Reference Only**
- **Audited:** 2026-06-05 | **Decision by:** Rika-Chan 2026-06-05
- **Purpose:** Assemble and optimize multi-agent teams; capability matching and workflow composition
- **Tools declared:** Read, Write, Edit, Glob, Grep | **Model:** sonnet
- **Shell/Network:** None | **Credentials:** None | **Destructive:** None documented
- **Blocker:** Same VoltAgent unaudited disclaimer
- **Risk:** Low-Medium
- **Use:** Read for agent-team composition patterns only.

---

### VoltAgent/awesome-claude-code-subagents — agent-installer
- **Repo:** `https://github.com/VoltAgent/awesome-claude-code-subagents` · 21.2k stars
- **Status:** **Rejected** ✗
- **Audited:** 2026-06-05 | **Decision by:** Rika-Chan 2026-06-05
- **Purpose:** Browse and install agents from GitHub into `~/.claude/agents/`
- **Shell:** YES — `curl` downloads from `raw.githubusercontent.com`; `mkdir -p ~/.claude/agents/`; `set -e` bash script
- **Destructive:** YES — writes unverified files to Claude's global agent directory; uninstall deletes files
- **Integrity:** NO checksums; no signature verification on downloaded agent files
- **Supply-chain risk:** HIGH — any compromised agent file in the repo would be installed without review
- **Failed Criteria:** C3 (shell + network downloads), C5 (writes to sensitive global path without integrity check), C9 (supply-chain injection vector)
- **Risk:** High
- **Decision:** Must not be used in any form — neither the bash script nor the subagent version.

---

### VoltAgent/awesome-agent-skills (repo)
- **Repo:** `https://github.com/VoltAgent/awesome-agent-skills` · 24.3k stars
- **Status:** **Reference Only** (discovery source)
- **Audited:** 2026-06-05
- **Notes:** 1,424+ skills from Anthropic, Microsoft, Google, Trail of Bits, and community. Includes code-executing security scanners (Trail of Bits). No per-skill audit. Each individual skill must pass this gate before use.

---

### multica-ai / andrej-karpathy-skills
- **Repo:** `https://github.com/multica-ai/andrej-karpathy-skills`
- **Status:** Reference Only (not yet audited per rubric)
- **Useful For:** karpathy-coding-guidelines — Think Before Coding, Simplicity First, Surgical Changes
- **Security Risk:** Unknown — criteria 3, 4, 5 not yet individually scored
- **Approval Required Before:** installing or executing
- **Promotion Path:** Score all Required criteria → pass → Rika-Chan approves → promote to Trial

---

### thananon / 9arm-skills
- **Repo:** `https://github.com/thananon/9arm-skills`
- **Status:** Reference Only (trial pending audit)
- **Useful For:** debug-mantra inspiration, scrutinize/post-mortem pattern
- **Security Risk:** Unknown — not fully audited
- **Approval Required Before:** any use beyond reading for inspiration

---

### skills.sh
- **URL:** `https://www.skills.sh/`
- **Status:** Reference Only (discovery source)
- **Notes:** Do not install from this source automatically. Run individual skill through this gate first.

---

### SkillsMP
- **URL:** `https://skillsmp.com/`
- **Status:** Reference Only (discovery source)
- **Notes:** 66,500+ skills indexed. Popularity is not proof of safety. Each skill must pass this gate individually.

---

## Tool Trust Gate — notebooklm-py (tool, not a skill)

### teng-lin / notebooklm-py
- **Repo:** `https://github.com/teng-lin/notebooklm-py` · ~15.9k stars · MIT
- **Status:** **Trial — Controlled Operational Use** (Rika-Chan, 2026-06-06). Medium-High risk · **not Core** · Tool Trust Gate stays active. Owner: **Nova-V only**.
- **Purpose:** Programmatic access to Google NotebookLM (source-grounded reading + content generation).
- **Tool reality (verified 2026-06-06):**
  - ❌ **Unofficial** — not affiliated with Google; **uses undocumented Google APIs that can break without notice** ("use at your own risk").
  - ⚠️ **Requires Google login via Playwright browser automation** (interactive login or cookie import) — drives a **real Google account = credential surface**.
  - Not read-only — can **add sources and generate/share** audio, video, slides, quizzes, etc.
- **At-risk criteria:** C3 (browser automation + network), C4 (Google credentials), C8 (unofficial/undocumented API) — hence gated, not Core.

#### Controlled Operational Use — Allowed
- Nova-V may use `notebooklm-py` to ask NotebookLM questions against **approved** notebooks/sources.
- Claude may **draft** questions for NotebookLM and **execute only after per-command approval**.
- Allowed sources: **public** + **Rika-Chan-owned non-sensitive project** sources.
- Allowed outputs: structured mission output, `verified_evidence_pack.md`, `logs/source_log.md` update, and `gap_statements.md`.
- Install / execute / login / auth / add-source / query → **per-command approval every time**.

#### Controlled Operational Use — Forbidden
- client PII / third-party personal data
- passwords, tokens, API keys, cookie import/export
- confidential client work
- financial / legal / medical / private identity data
- private chats / messages
- paywalled / login-only sources (unless separately approved)
- sharing / exporting NotebookLM content externally
- Any non-Nova-V direct `notebooklm-py` query/import.

- **Boundary:** Output is never truth → Nova-V verifies against approved source material, then Mira may write `knowledge/research/[slug].md` and `graph_update.md`.
- **Ref:** `llm_wiki/tool_capability_reference.md` · `llm_wiki/tool_selection_rules.md`

---

## Tool Trust Gate — WebFetch (built-in tool)

### Claude Code — WebFetch
- **Source:** Anthropic-native built-in tool (first-party; no third-party install). MIT-equivalent trust.
- **Status:** **Core** ✓ — scoped use, low risk. **Approved by:** Rika-Chan 2026-06-07 (standing `dec-20260607-002`).
- **Purpose:** Fetch a single web URL and return its extracted text. Used by **Hikari** in Product
  Scout mode (`/scout <URL>`) to summarize a link and frame product opportunity angles.
- **Owner:** Hikari (Product Scout). Other agents may use WebFetch under their own gated workflows.
- **Tool reality:** read-only fetch (GET); sends the URL out to the fetch service; no credentials,
  no writes, no shell. First-party tool — no undocumented-API or supply-chain concern.
- **Allowed:** **public** URLs only. Output is **leads, not facts** — same posture as web search.
- **Forbidden / STOP:** sensitive-domain URLs (health / finance / legal / auth / payment /
  government-ID), anything `sensitive`/`restricted`, or any URL carrying PII → STOP, flag Rika-Chan,
  do not fetch or auto-write (`governance/privacy_rules.md` §5–§6).
- **Required Criteria:** All PASS (C3 network = first-party read-only GET; C4 no credentials;
  C5 no destructive op; C9 low risk).
- **Boundary:** A fetched claim that must drive a decision still requires Nova-V verification before
  it is promoted from a lead to a claim.

---

## Research Backing

- SkillProbe security audit study: `https://arxiv.org/abs/2603.21019`
- Credential leakage in LLM agent skills: `https://arxiv.org/abs/2604.03070`
- Emerging threats in skill ecosystems: `https://arxiv.org/abs/2605.28588`

> Source map: `llm_wiki/source_context_map.md` (Phase 2)
