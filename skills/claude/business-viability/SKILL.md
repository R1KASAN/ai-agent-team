---
name: business-viability
version: "1.0"
trust_status: Core
team: claude
invoked_by: bumi_business_analyst
input: strategic_lens.md + verified_evidence_pack.md
output: business_analysis_brief.md
template: templates/business_analysis_brief.md
---

# Business Viability Skill

Produces a business analysis brief. Output is incomplete without a WTP signal.

## Protocol

1. **Target user** — describe the specific person with this problem (role, context, frequency).
2. **Pain severity** — rate 1–5 and justify with evidence from `verified_evidence_pack.md`.
3. **WTP signal** — find at least one signal that users pay (or would pay) for this. Accepted signals: existing spend, stated willingness, proxy products, interview quotes. If no signal found → flag as `wtp_unknown` and stop.
4. **Business model** — identify the most viable monetisation path (subscription, usage, marketplace, services, other).
5. **Revenue path** — how does this reach $1k MRR? $10k? Name the first paying customer archetype.
6. Write `business_analysis_brief.md`.

## Forbidden

- Do not complete the brief without a WTP signal or explicit `wtp_unknown` flag.
- Do not invent WTP evidence — cite sources from `verified_evidence_pack.md`.
- No shell execution. No external calls.
