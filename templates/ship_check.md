---
template: ship_check
produced_by: Kyuuei Ship-Check Utility
slash_command: /codex-ship-check
workflow: codex_build_loop
version: "1.0"
---

# Ship Check

```yaml
task_id: ""
produced_by: Kyuuei Ship-Check Utility
date: ""
verdict: ""
# ready_pending_approval / not_ready / blocked
# Note: "ready_pending_approval" is the best possible outcome.
# Actual deployment always requires Rika-Chan approval.
```

## Pre-Ship Checklist

| Item | Status | Notes |
|------|--------|-------|
| Build passes | pass / fail | |
| All tests pass | pass / fail | |
| Acceptance criteria met | pass / fail | |
| Security check clean | pass / fail / flagged | |
| QA/UX approved | pass / fail / blocked | |
| PR summary complete | pass / fail | |
| No open blockers | pass / fail | |

## Release Risk

`low / medium / high`

Risk notes (top 3):
1.
2.
3.

## Open Items

> Must be resolved or explicitly accepted before deployment.

-

## Deployment Approval Request

```yaml
required: true
gate: rika_chan
items:
  - ""
```

**Kyuuei does not deploy. Rika-Chan approves and deploys.**

---

> Passes to: Rika-Chan for deployment decision
