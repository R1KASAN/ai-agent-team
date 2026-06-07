---
template: debug_report
produced_by: Kyuuei Test+Debug
slash_command: /codex-debug
workflow: codex_build_loop
version: "1.0"
---

# Debug Report

```yaml
task_id: ""
produced_by: Kyuuei Test+Debug
date: ""
root_cause_found: false
```

## Failing Tests

| Test | File |
|------|------|
| | |

## Reproduction Steps

1.
2.
3.

## Failure Path

> Trace from entry point to the failure. One paragraph maximum.

## Hypotheses

| # | Hypothesis | Falsified | Evidence |
|---|-----------|----------|---------|
| 1 | | yes / no | |
| 2 | | | |

## Root Cause

> One sentence. Confirmed cause only — not speculation.

## Fix Applied

| File | Change |
|------|--------|
| | |

## Verification

| Test | Status After Fix |
|------|----------------|
| | pass / still_failing |

## Regression Check

`passed / issues_found`

Issues (if any):
-

## Approval Gates Hit

> Any fix touching auth / payments / database / infra — flag here.

-

## Open Questions

-

---

> Passes to: Kyuuei Test+Debug (`/codex-test` re-run)
