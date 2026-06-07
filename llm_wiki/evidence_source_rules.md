---
version: "1.1"
maintained_by: llm_wiki_reference_owner
authority: Rika-Chan
last_updated: "2026-06-06"
changelog: "v1.2 — Nova-V owns merged evidence discovery + verification; internal loop cap remains 2 hops."
---

# Evidence Source Rules

Standards for what counts as valid evidence and how sources are handled. Enforced by Nova-V.

---

## Source Tiers

| Tier | Type | Usage |
|------|------|-------|
| **Primary** | Peer-reviewed research, official docs, direct interviews, verified datasets | Acceptable as FACT with corroboration |
| **Secondary** | Reputable journalism, industry reports, practitioner writing | Acceptable as ASSUMPTION or FACT if corroborated |
| **Tertiary** | Blog posts, forum posts, social media, anonymous sources | Discovery only; never primary evidence |
| **Internal** | Rika-Chan notes, prior artifacts, session context | High trust; flag if stale |

---

## Minimum Evidence Standards

- A FACT claim requires: Tier 1 or Tier 2 source + at least one independent corroboration.
- A single Tier 3 source is never sufficient for a FACT label.
- No source with unknown origin passes into `verified_evidence_pack.md` as primary evidence.
- Time-sensitive claims (market data, product status) require `last_verified_at` within 90 days.

---

## High-Risk Domain Rule

For finance, legal, health, security, or privacy claims:

- Must use domain-specific Tier 1 sources (not generic web search).
- Conflicting sources in same domain → flag as `CONTRADICTION`; escalate to Rika-Chan.
- Low-confidence domain claims → always `ASSUMPTION` or `UNSUPPORTED`; never `FACT`.

---

## Discovery vs Verification

- **Discovery** (Nova-V): find sources, extract claims, apply source-quality-rubric. Owns all
  trusted-source connectivity (registry, tiers, web, notebooklm-py).
- **Verification** (Nova-V): **textual entailment (NLI)** between each claim and prepared evidence —
  Supported → FACT · Refuted/Conflicting → CONTRADICTION · Not Enough Evidence → UNSUPPORTED
  (full label set: FACT / ASSUMPTION / OPINION / UNSUPPORTED / CONTRADICTION / HALLUCINATION_RISK).
  Plus **citation faithfulness**: a citation that is *attached but not genuinely supporting*
  (post-rationalized) is not proof → downgrade to UNSUPPORTED.

These are internal Nova-V steps. Source discovery and claim verification stay separated inside the
artifact, but there is no active Nova→Vera handoff.

## Multi-Hop Evidence Loop

When evidence is **weak / missing / overclaimed / post-rationalized**, Nova-V records
`follow_up_research_questions` and re-retrieves the gaps inside `verified_evidence_pack.md`.
**Loop cap = 2 hops**; beyond → escalate to Rika-Chan.

---

> Source quality rubric: `skills/claude/source-quality-rubric/SKILL.md` | Checklist: `governance/data_governance_checklist.md`
