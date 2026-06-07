---
workflow_id: diff_review
type: dynamic_workflow_stub
status: stub_only
activation: requires_rika_chan_approval
context_budget: dynamic
version: "1.1"
---

# Workflow Stub: diff_review

> **Stub only.** This workflow is not active. It must be fully designed and approved by Rika-Chan before use.
> Do not execute this workflow from this file.

---

## Purpose

Multi-lens diff review where independent agents evaluate the same changeset from separate perspectives (correctness, security, UX impact, architecture). For use when a PR or migration is large enough that a single reviewer pass is insufficient.

## When to Use (Dynamic Workflow criteria from §9)

- Large PR or migration affecting multiple systems or modules
- Cross-cutting refactor where correctness, security, and UX must all be verified independently
- Diff that needs adversarial review before a sensitive production change
- Any scenario where results from multiple independent lenses must converge before approval

## When NOT to Use

- Routine PR from `codex_build_loop` → Coda/Kyuuei optional utility chain is sufficient
- Single-file or small-scope change
- Any diff that can be reviewed by one agent

---

## Proposed Flow (to be designed in Phase 3)

```
Diff artifact + scope definition (Rika-Chan approved)
→ Minori: dynamic workflow plan
→ Parallel lens passes (each independent, each produces separate artifact):
    Lens A: Correctness (Coda or Kyuuei)
    Lens B: Security (Kyuuei security backend check)
    Lens C: UX impact (Tessa)
    Lens D: Architecture (Aki)
→ Compaction step: lens findings aggregated
→ Governance review (Rika-Chan gate + `governance/` docs) on aggregated findings
→ Rika-Chan: approval decision
```

## Required Definitions Before Activation

```yaml
to_define_before_use:
  - workflow_goal: ""
  - diff_artifact: ""         # PR, branch, or file list
  - lenses: []                # which independent reviewers
  - input_artifacts: []
  - agent_count: 0
  - context_budget: dynamic
  - approval_points: []
  - output_artifacts: []
  - stop_conditions: []
  - compaction_step: ""
  - log_update_targets:
      - project_state
      - decision_log
      - risk_log
      - kaizen_log
```

## Activation Requirements

- [ ] Full workflow definition written and reviewed
- [ ] Rika-Chan approves lens selection and agent count
- [ ] Context budget `dynamic` approved
- [ ] Parallel fanout conditions verified (§6 of requirements: 6 conditions all true)
- [ ] Output artifacts confirmed separate per lens

---

> Full design: Phase 3
> Policy reference: `llm_wiki/token_optimization_rules.md` → Dynamic Workflow section
