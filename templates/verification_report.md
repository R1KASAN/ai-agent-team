---
template: verification_report
produced_by: Nova-V Evidence Verifier
workflow: product_idea_debate | evidence_crosscheck
version: "1.0"
---

# Verification Report

```yaml
report_id: ""
verified_by: Nova-V Evidence Verifier
source_artifact: ""       # verified_evidence_pack or artifact reviewed
date: ""
```

## Claim Classification

> Every claim from the source artifact classified. No claim left unclassified.

| ID | Claim | Classification | Source | Notes |
|----|-------|---------------|--------|-------|
| C1 | | FACT / ASSUMPTION / OPINION / UNSUPPORTED / CONTRADICTION / HALLUCINATION_RISK | | |
| C2 | | | | |
| C3 | | | | |

**Classification key:**
- `FACT` — supported by cited source with acceptable quality
- `ASSUMPTION` — logical but not directly evidenced
- `OPINION` — attributed perspective, not a fact claim
- `UNSUPPORTED` — asserted without citation or reasoning
- `CONTRADICTION` — conflicts with another claim
- `HALLUCINATION_RISK` — model-generated, no traceable source

## Unsupported Claims

> Require Nova to extend evidence pack before these can be used downstream.

-

## Contradictions

-

## Hallucination Risk Flags

> Must be resolved before artifact proceeds. Do not pass downstream unresolved.

-

## Assumption Log Updates

> New assumptions to append to `logs/assumption_log.md`.

| Label | Text | Risk |
|-------|------|------|
| A | | high / medium / low |

## Risk Log Updates

> New risks to append to `logs/risk_log.md`.

| Risk | Severity | Source |
|------|---------|--------|
| | high / medium / low | |

## Verdict

`overall: verified_with_flags / verified_clean / cannot_verify`

---

> Passes to: `sora_strategy_sensei.md`
> Logs updated: `logs/assumption_log.md`, `logs/risk_log.md`
