---
artifact: handoff_to_vera
produced_by: Nova Evidence Scout
step: 3 → 4
workflow_id: product_idea_debate
from_agent: Nova Evidence Scout
to_agent: Vera Critical Verifier
date: "2026-06-05"
status: PENDING — awaiting Rika-Chan approval before Vera activation
input_artifacts:
  - handoffs/top_riskiest_assumptions.md
  - handoffs/verification_report.md
  - handoffs/source_candidate_list.md
  - handoffs/evidence_pack.md
output_expected: verification_report_v2.md (or appended section to verification_report.md)
context_budget: small
---

# Handoff to Vera Critical Verifier
## From: Nova Evidence Scout → To: Vera Critical Verifier

---

## What Nova Did

Nova conducted scoped web research for the four R1–R4 blockers identified by Yuki and flagged by Vera in the first verification pass. Nova:

1. Searched official LINE Developers documentation to confirm API limitations (R1)
2. Gathered macro data on ChatGPT adoption in Thailand and freelancer WTP patterns (R2)
3. Retrieved academic benchmarks on LLM performance for Thai language and code-switched text (R3)
4. Gathered Thai PDPA legal framework and consent requirements from authoritative sources (R4)

All sources are listed in `handoffs/source_candidate_list.md`. Evidence summaries and verdicts are in `handoffs/evidence_pack.md`.

---

## What Vera Must Do

Vera is asked to perform a **verification pass on the evidence Nova collected**. This is not a new round of research — Vera should use only the artifacts Nova produced and the original artifacts from Steps 1–2.

### Specific tasks for Vera:

1. **Re-classify claims in `verification_report.md`** that were previously labelled ASSUMPTION — NEEDS NOVA, using the new evidence in `evidence_pack.md`. Options: upgrade to CONFIRMED FACT, FALSIFIED, PARTIALLY SUPPORTED, or retain as ASSUMPTION with a note that web evidence is insufficient.

2. **Validate Nova's source quality assessments** in `source_candidate_list.md`. Flag any sources Nova rated MEDIUM or MEDIUM-HIGH where Vera disagrees.

3. **Flag hallucination risks** in the evidence pack. Nova synthesised search results — Vera should check whether any claim in `evidence_pack.md` overstates what the underlying sources actually say.

4. **Map remaining gaps** — for each R1–R4 item that Nova could not fully resolve via web evidence, Vera should confirm the gap description and state the minimum evidence required before Rika-Chan can make a go/no-go decision.

5. **Do NOT** conduct new web searches. **Do NOT** produce a product strategy. **Do NOT** make architecture or pricing recommendations. Vera's role is verification only.

---

## Key Evidence Delivered by Nova — Summary for Vera

### R1 — LINE API
- **Finding:** LINE Messaging API is webhook-only; no past chat history retrieval endpoint exists.
- **Source quality:** HIGH — official LINE Developers documentation (primary source).
- **Claim status change:** "LINE has no open API for reading personal chat history" → upgrade from ASSUMPTION to **CONFIRMED FACT** (officially documented).
- **Remaining gap:** How Thai freelancers handle this in practice — web evidence cannot answer this.

### R2 — WTP vs ChatGPT
- **Finding:** ChatGPT holds 84.3% of Thai AI user share; 4× growth confirmed by OpenAI; 92% Thai knowledge workers use AI (PwC). Freelancer WTP exists but is conditional on clear ROI vs. free ChatGPT.
- **Source quality:** MEDIUM-HIGH — PwC survey + OpenAI statement are reliable; blogosphere data is weaker.
- **Claim status change:** "ChatGPT is accessible and used in Thailand" → already FACT in verification_report.md; strengthen with quantitative citations. "ChatGPT adoption is 4× in Thailand" → previously listed as UNSUPPORTED in verification_report.md → **now SUPPORTABLE** with Nation Thailand / OpenAI source (S2.1).
- **Remaining gap:** Thai freelancer-specific WTP data for this use case — still requires primary research.

### R3 — AI Thai Accuracy
- **Finding:** Top LLMs (GPT-4o, Claude Sonnet) score 60–70% on formal Thai benchmarks vs >80% on English. Informal/code-switched Thai is structurally harder with no published benchmark.
- **Source quality:** HIGH for academic papers (arXiv, Stanford HELM).
- **Claim status change:** "AI accuracy on Thai-English code-switching is uncertain" → upgrade from ASSUMPTION to **CONFIRMED STRUCTURAL RISK** (academic consensus). The 85% kill condition threshold remains unverifiable without prototype testing.
- **Remaining gap:** Prototype testing on 10–20 real informal Thai feedback samples — web evidence cannot fill this.

### R4 — Thai PDPA
- **Finding:** PDPA in force since June 2022; explicit consent required before uploading client messages to third-party AI SaaS; written data processor agreement required; cross-border transfers face additional restrictions.
- **Source quality:** HIGH — multiple legal authorities and official guides.
- **Claim status change:** "Thai PDPA applies to this use case" → upgrade from ASSUMPTION — NEEDS NOVA/GINA to **CONFIRMED LEGAL FRAMEWORK**. Product-specific compliance interpretation still requires Gina review.
- **Remaining gap:** Gina governance review + legal counsel for product-specific PDPA compliance strategy.

---

## Hard Limits Vera Must Respect

- Do NOT start Poom
- Do NOT create product_opportunity_brief
- Do NOT create PRD
- Do NOT make final pricing / roadmap / business model decisions
- Do NOT select architecture
- Do NOT recommend LINE OA Bot as a final solution
- Do NOT start Codex
- Do NOT run Dynamic Workflow

---

## Stop Condition for Vera

After Vera produces `verification_report_v2.md` (or an appended section to `verification_report.md`), stop and wait for Rika-Chan approval before any further handoff.

---

## Context Budget

**small** — Vera should load only:
- `handoffs/evidence_pack.md` (Nova's primary output)
- `handoffs/source_candidate_list.md` (source quality)
- `handoffs/verification_report.md` (original Vera pass — for comparison)
- `handoffs/top_riskiest_assumptions.md` (Yuki's original blocker definitions)

Do not load: idea_challenge_brief.md, workflow_plan files, or other context unless needed to resolve a specific contradiction.

---

> Approval gate: Rika-Chan must approve this handoff before Vera is activated.
> Nova output is complete. Nova stops here.
