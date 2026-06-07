---
template: verified_evidence_pack
produced_by: Nova-V Evidence Verifier
version: "1.0"
---

# Verified Evidence Pack

```yaml
research_question: ""
produced_by: Nova-V Evidence Verifier
created_at: ""
source_log_refs: []

sources:
  - id: ""
    title: ""
    url_or_path: ""
    source_type: ""
    captured_at: ""
    owner: ""
    privacy_level: public
    confidence: ""
    quality_notes: ""

claims:
  - claim: ""
    label: ""            # FACT | ASSUMPTION | OPINION | UNSUPPORTED | CONTRADICTION | HALLUCINATION_RISK
    source_ids: []
    citation_audit: ""
    notes: ""

gap_statements: []
contradictions: []
approval_gates_hit: []
notebooklm_mission_ref: ""
handoff_target: ""
```

## Rules

- Web search and NotebookLM-py are discovery/reading aids only.
- No claim moves downstream without a label and citation audit.
- NotebookLM-derived claims must be verified against source material.
