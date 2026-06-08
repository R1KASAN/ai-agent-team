---
log: kaizen_log
maintained_by: Kai Kaizen Coach
appended_by: Kai
version: "1.0"
---

# Kaizen Log

Record every waste finding, workflow simplification, and skill candidate identified across all sessions. Used by Lexi to determine LLM Wiki updates and by Minori to improve future workflow plans.

## Entry Format

```yaml
- kaizen_id: ""           # e.g. K1, K2 — unique across project
  date: ""
  workflow_id: ""
  finding_type: ""        # token_waste / context_waste / agent_overuse / repeated_context / bottleneck / skill_candidate / simplification
  description: ""
  location: ""            # step number or agent name
  suggestion: ""
  estimated_token_saving: ""   # rough estimate or "unknown"
  status: ""              # noted / proposed / applied / deferred
  skill_candidate: false
  skill_name: ""          # if skill_candidate is true
  artifacts_ref: []
```

## Skill Candidate Tracking

When `skill_candidate: true`, the entry must also appear in a `skill_candidate_note.md` passed to Lexi. Skill candidates remain `status: proposed` until Skill Trust Gate is run and Rika-Chan approves.

---

## Kaizen Findings

<!-- Entries appended here by Kai during live workflows. -->
<!-- Most recent entry at top. -->

