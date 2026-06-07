---
template: pr_summary
produced_by: Coda PR Utility
slash_command: /codex-pr
workflow: codex_build_loop
version: "1.0"
---

# PR Summary

```yaml
task_id: ""
produced_by: Coda PR Utility
date: ""
title: ""
```

## Summary

> 2–3 sentences. Plain language. What changed and why.

## Changed Files

| File | Change Type | Reason |
|------|------------|--------|
| | added / modified / deleted | |

## Test Evidence

**Passing tests:**
-

**Acceptance criteria met:**
-

**Known failures or gaps:**
-

## Security Status

`clean / flagged / pending`

Security flags (if any):
-

## Risk Notes

> Prominent. Do not bury.

-

## Open Questions

-

## Reviewer Checklist

- [ ] Scope matches task packet
- [ ] All acceptance criteria implemented or explicitly deferred
- [ ] Tests pass (no regressions)
- [ ] Security check complete and verdict documented
- [ ] No unrelated changes included
- [ ] Open questions documented

## Approval Required Before Merge

| Item | Gate |
|------|------|
| Production merge | rika_chan |
| Auth / payments / db / infra changes | rika_chan |

---

> Passes to: Kyuuei ship-check utility
