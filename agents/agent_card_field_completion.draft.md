---
version: "1.0-draft"
status: proposed_patch
target_files: "agents/claude_team/*.md and agents/codex_team/*.md"
captured_at: "2026-06-05"
approval_required: Rika-Chan
reason: "Existing agent files are present and substantial, but Prompt Requirement section 14 asks each file to explicitly include dynamic workflow pattern and required artifacts."
---

# Agent Card Field Completion Draft

Do not apply automatically. After Rika-Chan approval, add these explicit sections to each human-readable agent card. Existing outputs and handoff rules already imply most content; this patch makes the prompt-required labels explicit.

## Section To Add To Every Agent

```md
## Dynamic Workflow Pattern

Sequential by default. This agent may participate in a Dynamic Workflow only when Minori has produced a workflow plan with Rika-Chan approval, independent input/output artifacts, explicit context budget, stop condition, and convergence step.

## Required Artifacts

The artifacts listed in this file's Outputs section are mandatory. The next handoff cannot proceed until the required output artifact exists.
```

## Extra Line For Minori

Add under `Required Artifacts`:

```md
Minori must produce `workflow_plan.md` before any agent receives delegation.
```

## Extra Line For Codex Team Agents

Add under `Dynamic Workflow Pattern`:

```md
Codex Team agents do not join product-strategy dynamic workflows. They only execute scoped build, test, debug, refactor, review, security, PR, or ship-check tasks from approved task packets.
```

## Files Requiring This Patch

- `agents/claude_team/minori_lead_conductor.md`
- `agents/claude_team/yuki_idea_challenger.md`
- `agents/claude_team/mira_memory_librarian.md`
- `agents/_archive/graphy_knowledge_cartographer.md`
- `agents/claude_team/nova_evidence_scout.md`
- `agents/claude_team/vera_critical_verifier.md`
- `agents/claude_team/sora_strategy_sensei.md`
- `agents/claude_team/bumi_business_analyst.md`
- `agents/claude_team/poom_product_manager.md`
- `agents/codex_team/aki_system_architect.md`
- `agents/claude_team/tessa_qa_ux_inspector.md`
- `agents/claude_team/gina_governance_guardian.md`
- `agents/claude_team/kai_kaizen_coach.md`
- `agents/claude_team/lexi_llm_wiki_keeper.md`
- `agents/codex_team/coda_codex_builder.md`
- `agents/codex_team/testa_codex_tester.md`
- `agents/codex_team/bugsy_codex_debugger.md`
- `agents/codex_team/rex_codex_refactorer.md`
- `agents/codex_team/pria_codex_pr_maker.md`
- `agents/codex_team/seco_codex_security_checker.md`
- `agents/codex_team/shippo_codex_ship_checker.md`

## Approval Needed

Approve adding the sections above to the existing agent files. Do not change agent missions, allowed tools, or workflows during this patch.
