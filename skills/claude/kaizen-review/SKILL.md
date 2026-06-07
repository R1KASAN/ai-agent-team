---
name: kaizen-review
version: "1.0"
trust_status: Core
team: claude
invoked_by: kaizen token convention; /kaizen-review
input: artifact list from current workflow cycle (paths only, not content)
output: kaizen_report.md
template: templates/kaizen_report.md
context_budget: tiny
---

# Kaizen Review Skill

Reviews the artifact list for waste, redundancy, and simplification opportunities. Context budget: `tiny` — loads artifact names only.

## Protocol

1. Receive the artifact list (paths, not content).
2. Check for:
   - Duplicate or near-duplicate artifacts
   - Artifacts that were produced but never consumed downstream
   - Steps where context budget exceeded `small` without approval
   - Handoffs that carried full content instead of paths
3. Produce improvement proposals — do not apply them.
4. Write `kaizen_report.md` with proposals ranked by waste reduction impact.

## Forbidden

- Do not load full artifact content — paths only.
- Do not auto-apply any improvement.
- Do not exceed `tiny` context budget.
- No shell execution. No external calls.
