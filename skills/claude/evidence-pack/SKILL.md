---
name: evidence-pack
version: "1.0"
trust_status: Core
team: claude
invoked_by: nova_v; /evidence-crosscheck
input: research question or idea_challenge_brief.md
output: verified_evidence_pack.md (source section)
template: templates/verified_evidence_pack.md
---

# Evidence Pack Skill

Assembles sources into the source section of `verified_evidence_pack.md`. Web search = discovery
only; Nova-V verifies claims before downstream use.

## Protocol

1. Derive search queries from the open questions in the input.
2. Gather sources; apply source-quality-rubric to each.
3. For each source: record url/path, type, captured_at, owner, confidence, privacy_level.
4. List all claims extracted from sources.
5. Verify claims by entailment and citation faithfulness before marking them usable downstream.
6. Flag any source with confidence: low or privacy_level: restricted.
7. Write `verified_evidence_pack.md` using `templates/verified_evidence_pack.md`.

## Required Fields in Output

- `sources` (list with metadata), `claims` (labelled), `citation_audit`, `gap_statements`, `low_confidence_flags`, `privacy_flags`

## Forbidden

- Do not pass unverified claims downstream.
- Do not use sources with unknown origin as primary evidence.
- No shell execution. No external calls beyond web discovery.
