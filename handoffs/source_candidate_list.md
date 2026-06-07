---
artifact: source_candidate_list
produced_by: Nova Evidence Scout
step: 3
workflow_id: product_idea_debate
input_artifact: handoffs/top_riskiest_assumptions.md + handoffs/verification_report.md
date: "2026-06-05"
context_budget: small
status: complete
scope: R1–R4 blockers only
---

# Source Candidate List
## AI Assistant: Scattered Client Feedback → Clear Next Actions
### Produced by: Nova Evidence Scout

---

## R1 — LINE API / Manual Input Feasibility

| # | Source | URL | Type | Trust Level | Relevance |
|---|--------|-----|------|-------------|-----------|
| S1.1 | LINE Messaging API Overview — Official Docs | https://developers.line.biz/en/docs/messaging-api/overview/ | Official/Primary | HIGH | Confirms API architecture; webhook-only design |
| S1.2 | LINE Messaging API: Receiving Messages (Webhook) | https://developers.line.biz/en/docs/messaging-api/receiving-messages/ | Official/Primary | HIGH | Confirms no past history retrieval endpoint |
| S1.3 | LINE Messaging API Reference | https://developers.line.biz/en/reference/messaging-api/ | Official/Primary | HIGH | Full endpoint list — confirms absence of history retrieval |
| S1.4 | LINE Developers FAQ | https://developers.line.biz/en/faq/ | Official/Primary | HIGH | Known limitations confirmed |
| S1.5 | LINE API Essentials — Rollout.com Guide | https://rollout.com/integration-guides/line/api-essentials | Secondary/Guide | MEDIUM | Third-party summary; useful for workaround patterns |
| S1.6 | LINE API Use Case Portal | https://lineapiusecase.com/en/api/msgapi.html | Official/Secondary | HIGH | Official use-case documentation |

**Gap:** No published research on how Thai freelancers specifically work around LINE input limitations (manual paste patterns, screenshot OCR workarounds). This requires primary user research — not solvable by web evidence alone.

---

## R2 — Willingness to Pay vs. ChatGPT Substitute Risk

| # | Source | URL | Type | Trust Level | Relevance |
|---|--------|-----|------|-------------|-----------|
| S2.1 | "Thais hold AI edge as ChatGPT use jumps 4x, says OpenAI" — Nation Thailand | https://www.nationthailand.com/blogs/business/tech/40055451 | News/OpenAI Statement | HIGH | ChatGPT 4× growth claim; sourced to OpenAI |
| S2.2 | "Thailand leads Generative AI adoption across Southeast Asia" — Staffing Industry | https://www.staffingindustry.com/news/global-daily-news/thailand-leads-generative-ai-adoption-across-southeast-asia | Industry News | MEDIUM-HIGH | 62% Thai workers use GenAI; regional leadership stat |
| S2.3 | "Inside Thailand's digital life in 2025" — Nation Thailand | https://www.nationthailand.com/news/general/40058632 | News Survey | MEDIUM-HIGH | ChatGPT 84.3% share of Thai AI users; Gen-Z demographics |
| S2.4 | "84% of Freelancers Use AI" — Asrify | https://asrify.com/blog/freelancers-ai-productivity | Blog/Survey | MEDIUM | 84% freelancer AI adoption globally (up from 41% in 2023) |
| S2.5 | "AI Tools for Freelancers 2026" — Plutio | https://www.plutio.com/freelancer-magazine/ai-tools-for-freelancers-2026 | Industry Blog | MEDIUM | WTP framing: cap AI spend at 5–10% monthly revenue |
| S2.6 | PwC Thailand GenAI Survey 2025 | https://www.pwc.com/th/en/press-room/press-release/2025/press-release-31-01-25-en.html | Consulting/Survey | HIGH | 92% Thai knowledge workers use AI; 95% skills gap |
| S2.7 | Brookings — "Is generative AI a job killer?" Freelance Market | https://www.brookings.edu/articles/is-generative-ai-a-job-killer-evidence-from-the-freelance-market/ | Academic/Think Tank | HIGH | Labour market evidence on AI impact on freelance income |

**Gap:** No Thailand-specific freelancer WTP survey with dollar amounts for AI productivity tools. No data specifically on Thai creative/design freelancers vs. global averages. Primary user research (5–10 interviews) required to fill this gap.

---

## R3 — AI Accuracy on Informal Thai/English Code-Switching Text

| # | Source | URL | Type | Trust Level | Relevance |
|---|--------|-----|------|-------------|-----------|
| S3.1 | "Assessing Thai Dialect Performance in LLMs" — arXiv 2025 | https://arxiv.org/pdf/2504.05898 | Peer-reviewed paper | HIGH | Direct: LLM performance on Thai dialects; GPT-4o/Gemini2 only models with some fluency |
| S3.2 | ThaiExam Leaderboard — Stanford HELM | https://crfm.stanford.edu/2024/09/04/thaiexam.html | Academic Benchmark | HIGH | Top models score 60–70% on Thai vs >80% on English MMLU |
| S3.3 | "Representing the Under-Represented: Thai LLM Benchmarks" — arXiv 2024 | https://arxiv.org/html/2410.04795v1 | Peer-reviewed paper | HIGH | Cultural/capability benchmarks; confirms Thai as lower-resource language |
| S3.4 | "Adapting Deep Learning for Code-Switched Informal Short Text" — arXiv | https://arxiv.org/pdf/2001.01047 | Peer-reviewed paper | HIGH | Code-switching NLP challenge; manual labeled data is scarce |
| S3.5 | "Improved Sentiment Detection via Label Transfer: Code-Switched Text" — arXiv | https://arxiv.org/pdf/1906.05725 | Peer-reviewed paper | MEDIUM-HIGH | Accuracy improvements via synthetic augmentation for code-switched text |
| S3.6 | Thailand Medical Licensing Exam LLM Evaluation — medRxiv 2024 | https://www.medrxiv.org/content/10.1101/2024.12.20.24319441.full.pdf | Preprint/Medical | MEDIUM | GPT-4o 88.9% on formal Thai exam — context: formal, not informal/mixed |

**Gap:** No published benchmark specifically for informal Thai-English code-switched business/client feedback text. No test dataset for emoji-heavy, contradictory, mixed-register Thai messages. R3 cannot be fully resolved by web evidence — requires prototype testing on real samples (as Yuki stated).

---

## R4 — Client Privacy Consent + Thai PDPA Risk

| # | Source | URL | Type | Trust Level | Relevance |
|---|--------|-----|------|-------------|-----------|
| S4.1 | "What is the Thailand PDPA? 2026 guide" — Cookie Information | https://cookieinformation.com/blog/what-is-the-thailand-pdpa/ | Legal Guide | HIGH | Comprehensive 2026-updated guide; consent requirements |
| S4.2 | Thailand PDPA Ultimate Guide — Securiti.ai | https://securiti.ai/thailand-personal-data-protection-act-pdpa/ | Legal/Compliance | HIGH | PDPA scope, data controller vs processor roles, consent rules |
| S4.3 | "How Private AI Can Help Comply with Thailand PDPA" — Private AI | https://www.private-ai.com/en/blog/thailand-pdpa | Tech/Legal | MEDIUM-HIGH | AI-specific PDPA guidance; de-identification options |
| S4.4 | Thailand PDPA Consent Article — Lexology | https://www.lexology.com/library/detail.aspx?g=aad7855f-9557-4a41-9a72-443a84a9c109 | Legal Commentary | HIGH | Consent formality requirements; purpose limitation |
| S4.5 | DLA Piper: Data Protection Laws Thailand | https://www.dlapiperdataprotection.com/index.html?t=law&c=TH | Law Firm Reference | HIGH | Authoritative legal summary; controller/processor obligations |
| S4.6 | Chambers Data Protection & Privacy 2026 — Thailand | https://practiceguides.chambers.com/practice-guides/data-protection-privacy-2026/thailand/trends-and-developments | Legal Reference | HIGH | 2026 trends; current enforcement posture |
| S4.7 | AI in HR: Legal Boundaries Thailand — PIM Legal | https://www.pimlegal.com/2026/06/04/ai-tools-in-hr-legal-boundaries-around-automated-hiring-in-thailand/ | Legal/AI | MEDIUM-HIGH | AI + data subject rights; automated processing requirements |
| S4.8 | OneTrust Thai PDPA Compliance Guide | https://www.onetrust.com/blog/the-ultimate-guide-to-thai-pdpa-compliance/ | Compliance Vendor | MEDIUM | Practical compliance steps; processor agreement requirements |

**Gap:** No published legal opinion specifically on: a freelancer uploading client LINE messages to an AI SaaS tool. No PDPA enforcement case law yet (law is recent). Gina governance review required for product-specific legal interpretation.

---

## Source Quality Summary

| Blocker | Primary Sources Available | Gap Type | Gap Fillable by Web? |
|---------|--------------------------|----------|----------------------|
| R1 | Official LINE docs — definitive on API limits | Workaround patterns; user behaviour | No — needs user interviews |
| R2 | PwC survey; OpenAI statement; global freelancer data | Thai freelancer-specific WTP data | No — needs primary research |
| R3 | Academic benchmarks on Thai LLM performance | Informal code-switched test data | No — needs prototype testing |
| R4 | PDPA official law + legal guides | Product-specific legal opinion | No — needs Gina + legal review |
