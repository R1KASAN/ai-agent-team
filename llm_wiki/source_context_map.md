---
version: "1.1"
maintained_by: llm_wiki_reference_owner
authority: Rika-Chan
status: active_reference_registry
captured_at: "2026-06-05"
source_path: "/Users/ark1/Downloads/# Source Context Prompt for Claude: AI-H.md"
usage_decision: reference_only
note: "Documentation only. Does not approve installing, cloning, importing, executing, scraping, or trusting any external source."
---

# Source Context Map

Purpose: compact registry of source references used to design the AI-Human Startup Studio OS. Use official docs first. Treat GitHub repos, marketplaces, blogs, and research as references until reviewed.

## Global Approval Rule

Rika-Chan approval is required before any source is used for:

- installing or cloning external code
- executing scripts, skills, workflows, or automations
- importing large source batches
- uploading sensitive or restricted data
- modifying core project files from external guidance

## Source Categories

| Source | URL | Category | Trust | Used For | Connects To | Approval Before |
|---|---|---|---|---|---|---|
| Claude Code Overview | https://code.claude.com/docs/en/overview | Official | Official | Claude role and tool boundaries | `CLAUDE.md`, `tool_selection_rules.md` | none for reading |
| Claude Code Agent Teams | https://code.claude.com/docs/en/agent-teams | Official | Official | team design, separate contexts, fanout cost | `product_idea_debate.md`, `dynamic_workflow_policy.md` | none for reading |
| Claude Code Subagents | https://code.claude.com/docs/en/sub-agents | Official | Official | agent cards and runtime agents | `agents/claude_team/`, `.claude/agents/` | none for reading |
| Claude Code Workflows | https://code.claude.com/docs/en/workflows | Official | Official | dynamic workflow stubs and limits | `.claude/workflows/`, `workflow_index.md` | running dynamic workflows |
| Claude Code Context Window | https://code.claude.com/docs/en/context-window | Official | Official | context budgets, compaction, artifact memory | `token_optimization_rules.md` | none for reading |
| Claude Code How It Works | https://code.claude.com/docs/en/how-claude-code-works | Official | Official | execution loop and safety rules | `CLAUDE.md`, `security_guardrails.md` | none for reading |
| Claude Code Best Practices | https://code.claude.com/docs/en/best-practices | Official | Official | low-context operating rules | `kaizen_review.md`, `token_optimization_rules.md` | none for reading |
| Claude Code Features | https://code.claude.com/docs/en/features-overview | Official | Official | skills, subagents, hooks, MCP references | `tool_selection_rules.md`, `.claude/` | enabling integrations |
| Claude Agent Skills Overview | https://platform.claude.com/docs/en/agents-and-tools/agent-skills/overview | Official | Official | skill folder design | `skills/claude/`, `skill_trust_gate.md` | none for reading |
| Claude Skill Best Practices | https://platform.claude.com/docs/en/agents-and-tools/agent-skills/best-practices | Official | Official | concise SKILL.md files | `skills/claude/*/SKILL.md` | none for reading |
| Claude Help: Skills | https://support.claude.com/en/articles/12512176-what-are-skills | Official | Official | user-facing skills explanation | `README.md` | none for reading |
| Claude Help: Use Skills | https://support.claude.com/en/articles/12512180-use-skills-in-claude | Official | Official | skill usage guidance | `skills/claude/` | enabling skills |
| Claude Help: Create Skills | https://support.claude.com/en/articles/12512198-how-to-create-custom-skills | Official | Official | custom skill creation | `write-a-skill`, `llm_wiki/` passive reference | creating executable skills |
| Codex CLI Overview | https://developers.openai.com/codex/cli | Official | Official | Codex execution team boundaries | `agents/codex_team/` | none for reading |
| Codex Slash Commands | https://developers.openai.com/codex/cli/slash-commands | Official | Official | command docs | `.claude/commands/`, `skills/codex/` | running commands |
| Codex Skills | https://developers.openai.com/codex/skills | Official | Official | Codex SKILL.md structure | `skills/codex/` | enabling executable skills |
| skills.sh | https://www.skills.sh/ | Marketplace | Discovery only | skill discovery patterns | `skill_trust_gate.md` | install/execute any skill |
| SkillsMP | https://skillsmp.com/ | Marketplace | Discovery only | skill marketplace comparison | `skill_trust_gate.md` | install/execute any skill |
| Agent Skills Open Format | https://agentskills.io/home | Marketplace/standard | Reference only | portable skill structure | `skills/claude/`, `skills/codex/` | adopting external spec details |
| Agent Skills Library | https://mcpservers.org/agent-skills | Marketplace | Discovery only | reusable skill browsing | `skill_trust_gate.md` | install/execute any skill |
| Matt Pocock Skills | https://github.com/mattpocock/skills | GitHub | High-signal reference | handoff, grill, to-issues patterns | `skills/claude/`, `skills/codex/to-issues/` | clone/install/execute/promote |
| multica-ai/andrej-karpathy-skills | https://github.com/multica-ai/andrej-karpathy-skills | GitHub | High-signal reference | coding behavior principles | `karpathy-coding-guidelines`, Coda | clone/install/execute/promote |
| thananon/9arm-skills | https://github.com/thananon/9arm-skills | GitHub | Trial/reference | debug-mantra and postmortem inspiration | `debug-mantra`, `skill_trust_gate.md` | any use beyond reading |
| Graphify | https://github.com/safishamsi/graphify | GitHub | Reference only | knowledge graph layer pattern | Mira-owned graph update backend, `memory_intake.md` | install/execute/import data |
| notebooklm-py | https://github.com/teng-lin/notebooklm-py | GitHub / unofficial integration | Trial Default Candidate | Nova-V source-grounded reading automation (Conditional Default after Tool Trust Gate) | Nova-V, `evidence_crosscheck.md`, `tool_selection_rules.md` | install · execution · auth/session use · importing sources · sensitive data · large batch import — unofficial, audit required, fallback direct source reading |
| NotebookLM Discover Help | https://support.google.com/notebooklm/answer/16215270?co=GENIE.Platform%3DDesktop&hl=en | Official | Official | source discovery workflow | Nova-V, `evidence_source_rules.md` | importing sensitive data |
| Google Blog: Discover Sources | https://blog.google/innovation-and-ai/models-and-research/google-labs/notebooklm-discover-sources/ | Blog | Secondary context | feature context only | `evidence_source_rules.md` | none for reading |
| Obsidian Graph View | https://obsidian.md/help/plugins/graph | Official | Official | graph navigation pattern | Graphy, `memory_intake.md` | uploading/syncing sensitive data |
| Obsidian Links and Backlinks | https://obsidian.md/help/link-notes | Official | Official | backlink memory design | `context_pack.md`, `memory_consolidate.md` | uploading/syncing sensitive data |
| NotebookLM Knowledge Graph Article | https://artemxtech.substack.com/p/notebooklm-has-a-knowledge-graph | Blog | Secondary context | conceptual reference only | `evidence_source_rules.md` | none for reading |
| Karpathy LLM Wiki Gist | https://gist.github.com/karpathy/442a6bf555914893e9891c11519de94f | Engineering reference | High-signal reference | LLM Wiki pattern | `llm_wiki/README.md` | copying/adopting code if any |
| Synto | https://github.com/kytmanov/synto | GitHub | Reference only | interlinked wiki inspiration | `memory_consolidate.md` | install/execute |
| nashsu/llm_wiki | https://github.com/nashsu/llm_wiki | GitHub | Reference only | LLM Wiki implementation inspiration | `llm_wiki/README.md` | install/execute |
| lucasastorian/llmwiki | https://github.com/lucasastorian/llmwiki | GitHub | Reference only | MCP/knowledge-base inspiration | `tool_selection_rules.md` | install/execute |
| Configuring Agentic AI Coding Tools | https://arxiv.org/abs/2602.14690 | Research | Research | context/skills/subagents justification | `token_optimization_rules.md` | none for reading |
| Dive into Claude Code | https://arxiv.org/abs/2604.14228 | Research | Research | agentic coding safety concepts | `security_guardrails.md` | none for reading |
| Agent Skills: Data-Driven Analysis | https://arxiv.org/abs/2602.08004 | Research | Research | skill ecosystem risks | `skill_trust_gate.md` | none for reading |
| SkillProbe | https://arxiv.org/abs/2603.21019 | Research | Research | marketplace skill audit risk | `skill_trust_gate.md` | none for reading |
| Emerging Threats of Agent Skill Ecosystem | https://arxiv.org/abs/2605.28588 | Research | Research | malicious skill payload risk | `security_guardrails.md` | none for reading |
| Credential Leakage in LLM Agent Skills | https://arxiv.org/abs/2604.03070 | Research | Research | credential exposure risk | `skill_trust_gate.md` | none for reading |
| SkillSmith | https://arxiv.org/abs/2605.15215 | Research | Research | boundary-guided skill interfaces | `token_optimization_rules.md` | none for reading |
| SkillFoundry | https://arxiv.org/abs/2604.03964 | Research | Research | converting repeated workflows into skills | `llm_wiki_update.md` | none for reading |
| IDEO Design Thinking | https://designthinking.ideo.com/ | Product reference | Secondary context | desirability/feasibility/viability framing | Yuki, `idea_challenge_brief.md` | none for reading |
| Strategyzer Critical Hypotheses | https://www.strategyzer.com/library/how-to-test-your-idea-start-with-the-most-critical-hypotheses | Product reference | Secondary context | assumption mapping | Yuki, Nova-V, Bumi | none for reading |

## Memory Stack

Raw input -> Mira tag/privacy -> knowledge/ LLM Wiki -> Graphify graph_update -> Obsidian backlinks/graph -> Tsumugi recall -> Nova-V uses NotebookLM-py only for approved deep source reading

Rules:

- LLM Wiki is reusable operating knowledge, not factual evidence.
- Web search is source discovery only.
- NotebookLM-py is Nova-V-only source-grounded reading support; every derived claim still requires Nova-V verification.
- GitHub repos are implementation references only until audited.
- Marketplaces are discovery only; popularity is not safety.
- Blogs are secondary context; official docs override blogs.

## Governance Metadata

Every source-derived artifact should include: `source_url` or `source_path`, `source_type`, `captured_at`, `owner`, `topic`, `entities`, `confidence`, `privacy_level`, `usage_decision`, `related_project`, and `last_verified_at` when relevant.

Related files:

- `llm_wiki/skill_trust_gate.md`
- `llm_wiki/evidence_source_rules.md`
- `governance/data_governance_checklist.md`
- `governance/privacy_rules.md`
- `governance/security_guardrails.md`
