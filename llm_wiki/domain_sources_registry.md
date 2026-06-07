---
version: "1.0"
maintained_by: llm_wiki_reference_owner
authority: Rika-Chan
used_by: nova_v; rika_chan_decision_gate
status: active_reference_registry
captured_at: "2026-06-05"
note: "Named trusted sources per domain for evidence discovery. Reference for source SELECTION only — not factual evidence and not an install/scrape permission. Web search remains discovery-only; every source must still pass the source-quality-rubric."
---

# Domain Sources Registry

Implements Prompt Requirement §13 ("domain source registry" + "dataset/source registry lookup").
Pairs with `llm_wiki/evidence_source_rules.md` (which defines the **tiers**); this file lists the **named sources** Nova-V should reach for first, per domain.

## How Nova-V Uses This

1. Identify the domain(s) of the research question.
2. Prefer the named Tier-1/Tier-2 sources below as discovery starting points.
3. Score every source with `source-quality-rubric` regardless of its listing here.
4. High-stakes domains (legal, privacy, finance, health, security) → if named sources conflict or confidence is low, escalate to Rika-Chan before the evidence pack is finalized.
5. Listing here is **not** approval to install, scrape, or call an API — only to read/cite.

---

## Legal / Privacy / PDPA (high-stakes)

| Source | Type | Tier | Notes |
|--------|------|------|-------|
| Thailand PDPC (Personal Data Protection Committee) official site | Official regulator | Primary | Authoritative for Thai PDPA |
| DLA Piper Data Protection Laws of the World | Law-firm reference | Primary | Per-jurisdiction summaries |
| Chambers / Practice Guides — Data Protection & Privacy | Legal reference | Primary | Annual jurisdiction guides |
| Lexology (signed legal commentary) | Legal commentary | Secondary | Corroborate against a primary source |
| Vendor PDPA guides (Securiti, OneTrust, Cookie Information) | Compliance vendor | Secondary | Useful framing; vendor bias — never sole source |

> Rule: any PDPA/legal claim that drives a product decision needs a Primary source + Rika-Chan governance review. Vendor blogs are never primary.

## Market / Adoption / Willingness-to-Pay

| Source | Type | Tier | Notes |
|--------|------|------|-------|
| PwC / Deloitte / McKinsey regional reports | Consulting research | Primary-Secondary | Cite report name + year |
| OpenAI / Anthropic / Google official adoption statements | Vendor primary | Secondary | Vendor-reported; label as such |
| Reputable national press (e.g., Nation Thailand, Bangkok Post) | Journalism | Secondary | Corroborate statistics |
| Statista / official statistics offices | Dataset | Primary | Check methodology + date |
| Practitioner blogs / Medium | Practitioner writing | Tertiary | Discovery only; never primary |

## Technical / AI Benchmarks / NLP

| Source | Type | Tier | Notes |
|--------|------|------|-------|
| arXiv (peer-review pending) | Research preprint | Primary-Secondary | Note "preprint"; prefer published versions |
| Stanford HELM / official model leaderboards | Benchmark | Primary | Method visible |
| ACL Anthology / published NLP venues | Peer-reviewed | Primary | Strongest for accuracy claims |
| Official model/API docs (Anthropic, OpenAI, Google) | Vendor primary | Primary | Authoritative for capabilities/limits |
| Vendor benchmark blog posts | Vendor writing | Secondary | Corroborate independently |

## Platform / API Feasibility

| Source | Type | Tier | Notes |
|--------|------|------|-------|
| Official platform developer docs (e.g., LINE Developers, Meta for Developers) | Official primary | Primary | Authoritative for API limits |
| Official platform FAQ / changelog | Official primary | Primary | For deprecations and constraints |
| Third-party integration guides (Rollout, etc.) | Practitioner | Secondary | Useful for workarounds; verify vs official |

## Health / Safety (high-stakes)

| Source | Type | Tier | Notes |
|--------|------|------|-------|
| WHO / national health authorities | Official | Primary | Authoritative |
| Peer-reviewed journals (PubMed-indexed) | Research | Primary | Strongest |
| medRxiv / preprints | Preprint | Secondary | Label "preprint"; corroborate |

---

## Maintenance

- Add a domain or source only via `/llm-wiki-update` with a source artifact and approval.
- This registry is a **selection aid**, not a whitelist that bypasses the quality rubric.
- Tier definitions live in `evidence_source_rules.md`; keep the two files consistent.

> Tiers: `llm_wiki/evidence_source_rules.md` · Rubric: `skills/claude/source-quality-rubric/SKILL.md` · External source map: `llm_wiki/source_context_map.md`
