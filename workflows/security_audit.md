---
workflow_id: security_audit
type: dynamic_workflow_stub
status: stub_only
activation: requires_rika_chan_approval
context_budget: dynamic
version: "1.1"
---

# Workflow Stub: security_audit

> **Stub only.** This workflow is not active. It must be fully designed and approved by Rika-Chan before use.
> Do not execute this workflow from this file.

---

## Purpose

Codebase-wide or feature-wide security audit across multiple independent lenses. For use when a
single Kyuuei security backend check is insufficient — e.g., pre-launch audit, third-party
integration review, or compliance requirement.

## When to Use (Dynamic Workflow criteria from §9)

- Pre-launch security review of a full feature or codebase area
- Third-party API or library integration with unknown security surface
- Compliance-driven audit (GDPR, payment security, auth review)
- Any scenario where multiple independent reviewers must converge on a security verdict

## When NOT to Use

- Routine single-task security check → use `codex_build_loop` → Kyuuei security backend check instead
- Single-file or single-feature change → Kyuuei security backend check within `codex_build_loop` is sufficient

---

## Proposed Flow (to be designed in Phase 3)

```
Audit scope definition (Rika-Chan approved)
→ Minori: dynamic workflow plan
→ Multiple parallel Kyuuei security lenses across defined scope segments
  (each segment independent, separate output artifact)
→ Compaction step: findings aggregated
→ Governance review (Rika-Chan gate + `governance/` docs)
→ Aki: remediation task packet
→ Rika-Chan: approval before remediation begins
```

## Required Definitions Before Activation

```yaml
to_define_before_use:
  - workflow_goal: ""
  - audit_scope: []           # explicit file/module list
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
- [ ] Rika-Chan approves scope and agent count
- [ ] Context budget `dynamic` approved
- [ ] Parallel fanout conditions verified (§6 of requirements: 6 conditions all true)

---

> Full design: Phase 3
> Policy reference: `llm_wiki/token_optimization_rules.md` → Dynamic Workflow section
