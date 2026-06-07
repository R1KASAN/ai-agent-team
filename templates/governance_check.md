---
template: governance_check
produced_by: Rika-Chan Governance Gate
slash_command: /governance-check
workflow: qa_review | product_idea_debate | product_idea_to_prd
version: "1.0"
---

# Governance Check

```yaml
check_id: ""
produced_by: Rika-Chan Governance Gate
artifact_reviewed: ""
date: ""
overall_verdict: ""       # clear / flag / block
```

## Source Quality

```yaml
issues: []
verdict: pass / flag / block
```

## Privacy Risk

```yaml
pii_detected: false
sensitive_data: false
flags: []
verdict: pass / flag / block
```

## Security Risk

```yaml
flags: []
verdict: pass / flag / block
```

## Data Ownership

```yaml
owner_clear: false
issues: []
```

## Legal Concerns

```yaml
flags: []
verdict: pass / flag / block
```

## Approval Required

| Item | Reason | Gate |
|------|--------|------|
| | | rika_chan / gina_review |

## Overall Verdict

`clear / flag / block`

> `block` → Rika-Chan must approve before workflow continues.

## Recommended Action

-

---

> Logs updated: `logs/risk_log.md`
> Passes to: `kai_kaizen_coach.md`
