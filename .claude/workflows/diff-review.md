---
workflow: diff-review
status: stub_only
type: dynamic
activation_requires: Rika-Chan approval
ref: workflows/diff_review.md
---

# Diff Review — STUB ONLY

**This workflow is not active and must not be run.**

Status `stub_only` means: no agent may invoke this workflow, no step may be executed, and no output artifact will be produced until Rika-Chan explicitly approves activation.

## Intended Scope (not yet designed)

- Multi-lens diff review across a branch or PR
- Lenses: Nova-V evidence/correctness check + Tessa UX check + Kyuuei security check (parallel fanout requires all 6 fanout conditions)
- Produces: diff_review_report.md

## Activation Requirements

- [ ] Workflow fully designed in `workflows/diff_review.md`
- [ ] Parallel fanout conditions verified (all 6 required — see `llm_wiki/token_optimization_rules.md`)
- [ ] Rika-Chan reviews and approves design
- [ ] Status updated from `stub_only` to `active` in both this file and `workflows/diff_review.md`

> Do not remove or modify this stub without Rika-Chan approval.
