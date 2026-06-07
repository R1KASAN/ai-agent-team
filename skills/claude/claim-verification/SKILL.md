---
name: claim-verification
version: "1.0"
trust_status: Core
team: claude
invoked_by: nova_v
input: source and claim sections inside verified_evidence_pack.md
output: verified_evidence_pack.md (labelled claims + citation audit)
template: templates/verified_evidence_pack.md
---

# Claim Verification Skill

Labels every claim before it moves downstream. This skill now runs inside Nova-V's merged
evidence+verification loop; no separate Vera handoff is active.

## Labels

| Label | Meaning |
|-------|---------|
| `FACT` | Supported by high-quality, corroborated source |
| `ASSUMPTION` | Plausible but not independently confirmed |
| `OPINION` | Author's view; no objective basis cited |
| `UNSUPPORTED` | Claim present in source but no evidence given |
| `CONTRADICTION` | Conflicts with another source in the pack |
| `HALLUCINATION_RISK` | Plausible-sounding but no source found |

## Protocol

1. For each claim in `verified_evidence_pack.md`, assign one label.
2. Record the source(s) supporting the label.
3. Flag all CONTRADICTION and HALLUCINATION_RISK items for Rika-Chan review.
4. Update `verified_evidence_pack.md`.

## Forbidden

- Do not suppress or omit HALLUCINATION_RISK labels.
- Do not resolve contradictions — flag them.
- No shell execution. No external calls.
