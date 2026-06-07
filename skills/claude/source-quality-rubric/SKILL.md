---
name: source-quality-rubric
version: "1.0"
trust_status: Core
team: claude
invoked_by: nova_v; rika_chan_governance_gate
input: source list from verified_evidence_pack.md
output: source quality scores (embedded in verified_evidence_pack.md or governance_check.md)
---

# Source Quality Rubric Skill

Scores each source across five criteria before it enters verification.

## Scoring Criteria (each: high / medium / low)

1. **Recency** — is the source current enough for the decision?
2. **Author/Org credibility** — known, verifiable author or institution?
3. **Methodology visibility** — for research/data: is the method described?
4. **Conflict of interest** — does the source have a financial or competitive stake?
5. **Corroboration** — does at least one independent source agree?

## Fail Conditions

- Two or more criteria rated `low` → flag as `low_quality`; do not use as primary evidence.
- Unknown origin → flag as `unverified_origin`; stop and note in `verified_evidence_pack.md`.
- High-risk domain (finance, legal, health, security) + low recency → escalate to Rika-Chan.

## Forbidden

- Do not pass a `low_quality` source downstream as primary evidence.
- No shell execution. No external calls.
