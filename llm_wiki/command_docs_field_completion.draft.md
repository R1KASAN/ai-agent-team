---
version: "1.0-draft"
status: proposed_patch
target_files: ".claude/commands/*.md"
captured_at: "2026-06-05"
approval_required: Rika-Chan
reason: "Existing command docs are concise and present, but Prompt Requirement section 31 requires explicit optional_input and forbidden_actions fields."
---

# Command Docs Field Completion Draft

Do not apply automatically. After Rika-Chan approval, add these two frontmatter fields to each command doc in `.claude/commands/`.

## Universal Field Additions

```yaml
optional_input: supporting artifact paths, constraints, risk notes, approval notes; never full chat history
forbidden_actions: bypassing Minori, skipping artifact gates, starting downstream workflows automatically, using large/dynamic context without approval, overwriting existing files without approval
```

## Codex Command Extra Constraint

For `/codex-*` command files, append this phrase to `forbidden_actions`:

```yaml
deciding product strategy, editing out-of-scope files, deploying production, modifying auth/payment/database/infrastructure without approval
```

## Claude Product Workflow Extra Constraint

For `/product-idea-debate`, `/evidence-crosscheck`, `/product-idea-to-prd`, and `/prd-to-codex-tasks`, append this phrase to `forbidden_actions`:

```yaml
skipping Rika-Chan approval for strategic, evidence, PRD, roadmap, or implementation-readiness decisions
```

## Files Requiring This Patch

- `.claude/commands/idea-gate.md`
- `.claude/commands/product-idea-debate.md`
- `.claude/commands/evidence-crosscheck.md`
- `.claude/commands/product-idea-to-prd.md`
- `.claude/commands/prd-to-codex-tasks.md`
- `.claude/commands/governance-check.md`
- `.claude/commands/kaizen-review.md`
- `.claude/commands/memory-intake.md`
- `.claude/commands/llm-wiki-update.md`
- `.claude/commands/codex-implement.md`
- `.claude/commands/codex-test.md`
- `.claude/commands/codex-debug.md`
- `.claude/commands/codex-refactor.md`
- `.claude/commands/codex-review.md`
- `.claude/commands/codex-pr.md`
- `.claude/commands/codex-security-check.md`
- `.claude/commands/codex-ship-check.md`

## Approval Needed

Approve adding the fields above to the existing runtime command docs. No command behavior should be expanded beyond the existing referenced workflow files.
