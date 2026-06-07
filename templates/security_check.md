---
template: security_check
produced_by: Kyuuei Security Utility
slash_command: /codex-security-check
workflow: codex_build_loop
version: "1.0"
---

# Security Check

```yaml
task_id: ""
produced_by: Kyuuei Security Utility
date: ""
overall_verdict: ""       # clean / flagged / blocked
scope: []                 # files reviewed
```

## Secrets Exposure

```yaml
findings: []
verdict: clean / flagged / blocked
```

## Auth Risk

```yaml
findings: []
verdict: clean / flagged / blocked
```

## Input Validation

```yaml
findings: []
verdict: clean / flagged / blocked
```

## Data Exposure

```yaml
findings: []
verdict: clean / flagged / blocked
```

## Dependency Risks

```yaml
findings: []
verdict: clean / flagged / blocked
```

## Sensitive Code Paths

```yaml
findings: []
verdict: clean / flagged / blocked
```

---

## Remediation Required

| Finding | Severity | Action |
|---------|---------|--------|
| | blocked / flagged | |

## Approval Required

| Item | Gate |
|------|------|
| | rika_chan |

---

> `blocked` verdict → do not proceed to PR summary. Fix required + Rika-Chan approval.
> `flagged` or `clean` → passes to: Coda PR utility
