---
artifact: evidence_questions_for_nova
agent: yuki_idea_challenger
workflow_plan: workflow_plan_20260605_003
input_from: top_riskiest_assumptions.md
context_budget: tiny
produced_at: "2026-06-05"
handoff_to: nova_evidence_scout
max_sources: 3
---

# Evidence Questions for Nova

Questions ranked by assumption priority. Nova should address A1 and A2 first given `tiny` context budget.

## Q1 — Do structured AI workflows outperform unstructured prompting for product validation?
**Maps to:** A1
Specifically: is there any research or practitioner evidence that multi-step structured AI workflows produce better validated product decisions than single-session prompting?
Suggested source domains: AI product research, HCI, LLM-assisted decision-making studies.
Source tier needed: Primary-Secondary (research or practitioner report); practitioner blogs are tertiary only.

## Q2 — What is the adoption pattern for structured AI tooling among solo founders?
**Maps to:** A1 + A2
Specifically: do solo technical founders or small startup teams (1–3 people) adopt and sustain structured AI workflow tools, or do they revert to unstructured prompting?
Suggested source domains: Product Hunt launch data, YC startup tool adoption research, indie hacker surveys.
Source tier needed: Secondary (survey, report, or practitioner data).

## Q3 — What friction points cause structured AI workflow abandonment?
**Maps to:** A2
Specifically: what artifact or process overhead has been identified as the primary abandonment trigger for AI-assisted workflow tools?
Suggested source domains: UX research, tool adoption studies, AI assistant usage patterns.
Source tier needed: Secondary or practitioner.

## Scope Constraint for Nova
- max_sources: 3 (per workflow_plan_20260605_003 test parameters)
- context_budget: tiny
- Web search = source discovery only; do not use snippets as evidence
- Produce `source_candidate_list.md` before `evidence_pack.md`
- Update `logs/source_log.md` before handoff to Vera
