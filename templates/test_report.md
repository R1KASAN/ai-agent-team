---
template: test_report
produced_by: Kyuuei Test+Debug
slash_command: /codex-test
workflow: codex_build_loop
version: "1.0"
---

# Test Report

```yaml
task_id: ""
produced_by: Kyuuei Test+Debug
date: ""
overall_verdict: ""       # pass / fail / partial
```

## Tests Written

| Test Name | File | Covers Criterion # |
|-----------|------|-------------------|
| | | |

## Acceptance Criteria Results

| # | Criterion | Test Case | Status | Notes |
|---|-----------|----------|--------|-------|
| 1 | | | pass / fail / not_tested | |
| 2 | | | | |

## Failures

| Test | Failure Reason | Recommended Action |
|------|---------------|-------------------|
| | | debug / fix / escalate |

## Regression Check

`passed / issues_found`

Issues (if any):
-

## Next Step

`proceed_to_seco / route_to_bugsy / fix_and_retest`

---

> If failures → Kyuuei debug loop (`/codex-debug`)
> If all pass → Coda refactor utility (if approved) or Kyuuei security utility
