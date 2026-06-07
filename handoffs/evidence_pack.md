---
artifact: evidence_pack
produced_by: Nova Evidence Scout
step: 3
workflow_id: product_idea_debate
input_artifact: handoffs/source_candidate_list.md + handoffs/top_riskiest_assumptions.md
date: "2026-06-05"
context_budget: small
status: complete — pending Vera verification
scope: R1–R4 blockers only
evidence_mode: web_search_only (no primary research, no prototype testing)
---

# Evidence Pack
## AI Assistant: Scattered Client Feedback → Clear Next Actions
### Produced by: Nova Evidence Scout

> **Important framing:** This pack contains the best available web evidence for R1–R4.
> Web evidence alone cannot fully resolve all four blockers. Each blocker section
> includes a confidence rating, a gap statement, and the minimum additional evidence
> needed before Vera or Rika-Chan can make a final call.

---

## R1 — LINE API / Manual Input Feasibility

### Finding

**The LINE Messaging API does NOT provide access to past or historical chat messages.**

Evidence from official LINE Developers documentation (S1.1, S1.2, S1.3):

- The Messaging API is a **webhook-only, real-time system**. It pushes incoming messages to a bot server as they arrive. There is no endpoint that retrieves historical messages from LINE's servers.
- The only way to access past messages is: (a) the user copies and pastes them manually, or (b) a bot was set up in advance with a webhook running continuously and stored messages on its own server.
- Message content visibility depends on **what is stored on the user's device**, not a server-side archive accessible via API.
- There is no "read history" endpoint, no chat export API, and no third-party access to personal or group chat history.

### Implication for Product

If the target user is a freelancer who receives client feedback in LINE personal or group chats:

- **No automated import is possible** without a pre-configured LINE Official Account bot that the freelancer and client have both opted into, AND that was running before the feedback was sent.
- The practical input path remains: **manual paste** (copy-paste from LINE app) or **screenshot upload** (if OCR is built in).
- This means the tool improves what happens *after* the user has already done the work of finding and selecting the relevant messages. The input fragmentation problem is **not solved at the source**.

### Verdict on R1

| Item | Status |
|------|--------|
| "LINE API can pull past chat history" | **FALSIFIED** — confirmed by official docs |
| "Manual paste is the only practical input method for existing chats" | **SUPPORTED** — consistent with API documentation |
| "A LINE OA bot workaround exists for future messages" | **SUPPORTED** — but requires: client adds freelancer's LINE OA, both parties opt in, and the bot was running before the feedback |
| "The input fragmentation problem is solved" | **NOT SUPPORTED** — manual copy step remains unavoidable for past conversations |

**Confidence: HIGH** (official source, definitive)
**Kill condition (Yuki R1):** If manual paste is the only path AND output is not dramatically better than ChatGPT → differentiation collapses. Evidence supports the first condition. Second condition still unresolved.

**Remaining gap:** How do Thai freelancers currently handle this in practice? Do they already paste into ChatGPT? Is screenshot OCR a viable workaround they'd accept? → Requires 5–10 user interviews.

---

## R2 — Willingness to Pay vs. ChatGPT Substitute Risk

### Finding

**ChatGPT is dominant in Thailand, freelancer AI adoption is high, and WTP exists — but only when ROI is clear and distinct from free alternatives.**

Key evidence:

- **ChatGPT 4× growth in Thailand** confirmed by OpenAI (S2.1, Nation Thailand). ChatGPT commands **84.3% of Thai AI user share** (S2.3).
- **Thailand leads Southeast Asia in GenAI adoption** (S2.2): 62% of Thai workers use GenAI professionally.
- **92% of Thai knowledge workers use AI at work** (PwC Thailand 2025, S2.6) — significantly above the global average of 75%.
- **84% of freelancers globally now use AI tools** (S2.4), up from 41% in 2023.
- **Freelancer WTP framing** (S2.5): Freelancers cap AI spend at 5–10% of monthly revenue. For a freelancer earning ฿30,000/month (~$830), this implies an AI budget ceiling of roughly ฿1,500–3,000/month.
- **95% of Thai executives report limited GenAI expertise** (PwC, S2.6) — skills gap creates opportunity for tools that reduce expertise barrier.

### Implication for Product

- The substitute risk is **confirmed and current**: Thai freelancers already use ChatGPT free tier at high rates.
- WTP exists for specialised tools — but requires demonstrating ROI that ChatGPT cannot deliver with a free prompt.
- The **skills gap finding** (95% of executives report limited GenAI expertise) is indirect but relevant: freelancers with low AI expertise may pay for a tool that packages the ChatGPT workflow into a simpler, purpose-built interface.
- Differentiation must be **workflow-specific** (not just "AI summarisation"), since ChatGPT performs basic summarisation at zero cost.

### Verdict on R2

| Item | Status |
|------|--------|
| "ChatGPT is the dominant free substitute in Thailand" | **CONFIRMED** — 84.3% share, 4× growth |
| "Freelancers are willing to pay for AI productivity tools" | **CONDITIONALLY SUPPORTED** — yes, if ROI > cost of ChatGPT Plus |
| "This product can differentiate enough to command WTP above free ChatGPT" | **UNRESOLVED** — depends on feature set; no data on this product specifically |
| ">50% of target users already find ChatGPT sufficient" (Yuki kill condition) | **UNVERIFIABLE** from web data — requires user interviews |

**Confidence: MEDIUM** (strong macro data on ChatGPT adoption; weak on specific WTP for this exact use case)
**Kill condition (Yuki R2):** >50% of target users already use ChatGPT for this use case and find it sufficient. Web evidence says ChatGPT is dominant and accessible — but "sufficient for this specific task" requires primary research.

**Remaining gap:** Thai freelancer-specific interviews to test (a) do they already paste feedback into ChatGPT, (b) what does ChatGPT miss, (c) what would they pay for a solution that fills that gap.

---

## R3 — AI Accuracy on Informal Thai/English Code-Switching Text

### Finding

**LLM accuracy on formal Thai is 60–70% (vs >80% on English). Informal, code-switched, emoji-heavy text is meaningfully harder — and no published benchmark exists for this exact use case.**

Key evidence:

- **ThaiExam benchmark (Stanford HELM, S3.2):** Top models (GPT-4o, Claude Sonnet, Gemini 1.5 Pro) achieve **60–70% accuracy on formal Thai language tasks**, compared to >80% on English-language MMLU. This gap is structural — Thai is a lower-resource language.
- **Thai dialect performance study (arXiv 2025, S3.1):** LLM performance **declines significantly on Thai dialects and local register** beyond standard Thai. Only proprietary models (GPT-4o, Gemini 2) show "some fluency."
- **Code-switching NLP challenge (arXiv S3.4, S3.5):** Manually labeled code-switched data is "extremely rare." Best monolingual methods "perform relatively poorly" on code-switched text. Synthetic augmentation improves accuracy by 1.5–7.2 percentage points across language pairs.
- **Context:** All benchmarks test formal, structured tasks (exam questions, medical licensing). No published benchmark for: informal Thai-English code-switching + emoji + ambiguous business context.
- **Counterpoint:** GPT-4o scored 88.9% on Thailand's formal Medical Licensing Exam (S3.6). Formal Thai performance is strong. The gap appears at informal/dialectal register.

### Implication for Product

- The 85% accuracy threshold Yuki set as a kill condition is **achievable on formal Thai** with GPT-4o or Claude Sonnet — but informal, emoji-heavy, mixed-register client feedback is a different domain.
- The product's hard case ("อยากให้ปรับสีให้สดขึ้นนะ แต่อย่าดูแรงเกิน ส่งมาพรุ่งนี้ได้เลย") involves colloquial Thai, implicit priority ordering, and conflicting instructions — precisely the register where current benchmarks show weakest performance.
- Accuracy on structured tasks ≠ accuracy on ambiguous, informal feedback extraction.

### Verdict on R3

| Item | Status |
|------|--------|
| "AI can reliably handle informal Thai-English mixed text" | **UNCERTAIN** — formal Thai OK; informal/code-switched performance not benchmarked |
| "85% accuracy is achievable on the target task" | **UNCERTAIN** — plausible on formal Thai; unverified for informal/code-switched register |
| "Thai is a lower-resource language with accuracy gaps" | **CONFIRMED** — 60–70% on formal benchmarks vs >80% English |
| "Informal code-switched text is harder than formal Thai" | **SUPPORTED** — consistent across multiple papers |

**Confidence: MEDIUM** (structural risk confirmed; exact product performance unverifiable without testing)
**Kill condition (Yuki R3):** Accuracy below ~85% on real samples → tool creates liability rather than value. **Cannot be resolved by web evidence alone.** Prototype testing on 10–20 real feedback samples is required.

**Remaining gap:** Test GPT-4o / Claude on 10–20 real Thai freelancer feedback samples. Measure: (a) correct next-action extraction, (b) correct priority ordering, (c) hallucination rate on ambiguous inputs.

---

## R4 — Client Privacy Consent + Thai PDPA Risk

### Finding

**Thai PDPA is in force (June 2022), applies to processing client messages, and requires explicit consent + data processor agreements. The practical adoption risk is HIGH and the legal risk is MEDIUM-HIGH.**

Key evidence:

- **PDPA is in effect** since June 1, 2022, and modelled on GDPR (S4.1, S4.2). Enforcement has been building since 2022.
- **Consent requirement:** Data controllers must obtain explicit, informed, purpose-specific consent before processing personal data (S4.4). Client messages contain personal data (S4.2).
- **Third-party message upload scenario:** When a freelancer uploads a client's messages to an AI SaaS tool:
  - The client's words = personal data of the client (the data subject).
  - The freelancer = data controller (deciding what to do with the data).
  - The AI SaaS platform = data processor (processing on the controller's behalf).
  - The freelancer must have the client's consent to upload their messages to a third-party processor (S4.2, S4.4).
- **Data processor agreement:** A written agreement between the freelancer (controller) and AI SaaS (processor) specifying scope, purpose, and security measures is required (S4.2, S4.8).
- **Cross-border transfer risk (Section 28 PDPA):** If the AI SaaS server is outside Thailand and the destination country lacks adequate data protection, transfers may be blocked or require additional safeguards (S4.2).
- **No AI-specific exemption:** PDPA contains no detailed rules for AI/automated processing, but general consent and purpose limitation rules apply (first search result batch).
- **Practical reality:** Thai freelancers operating informally (no contract, no formal privacy policy) are likely not obtaining explicit consent from clients before uploading their messages anywhere. This is a **de facto non-compliance posture** that creates risk as PDPA enforcement matures.

### Implication for Product

- A product that requires uploading client messages needs either: (a) a **consent mechanism built into the product**, or (b) clear disclaimers and user responsibility framing, or (c) a **local-processing option** (no data leaves the device/browser).
- The friction of asking clients for consent before uploading their messages may reduce adoption significantly — this is the adoption risk Yuki flagged.
- The AI SaaS itself (if non-Thai hosted) needs to provide PDPA-compliant data processing terms for Thai users.

### Verdict on R4

| Item | Status |
|------|--------|
| "Thai PDPA is in effect and applies to client messages" | **CONFIRMED** — enforceable since June 2022 |
| "Client consent is required before uploading their messages to an AI tool" | **CONFIRMED** — under PDPA consent + purpose limitation rules |
| "A data processor agreement with the AI SaaS is required" | **CONFIRMED** — written agreement required by PDPA |
| "Cross-border data transfer adds additional risk" | **CONFIRMED** — Section 28 applies if SaaS is hosted outside Thailand |
| "PDPA enforcement will affect individual freelancers operating informally" | **UNCERTAIN** — enforcement posture for SME/freelance tier not yet established in case law |

**Confidence: HIGH on legal framework; MEDIUM on practical enforcement risk**
**Kill condition (Yuki R4):** Privacy friction blocks user adoption. Evidence strongly suggests consent friction is real. Severity of enforcement risk requires Gina legal review.

**Remaining gap:** Gina governance review for product-specific legal interpretation. User interviews on comfort level with AI data upload (adoption risk). Legal review of whether a "user is responsible for obtaining client consent" disclaimer is sufficient.

---

## Cross-Blocker Summary

| Blocker | Web Evidence Verdict | Confidence | Kill Condition Status | Remaining Evidence Needed |
|---------|---------------------|------------|----------------------|--------------------------|
| R1 — LINE API | Manual paste confirmed; no API workaround for past chats | HIGH | Condition 1 met; condition 2 open | User interviews (5–10) |
| R2 — WTP vs ChatGPT | ChatGPT dominant; WTP conditional on clear ROI | MEDIUM | Cannot confirm kill condition without interviews | User interviews (5–10) + WTP test |
| R3 — AI Thai accuracy | Structural risk confirmed; informal accuracy unverified | MEDIUM | Cannot confirm without prototype testing | Prototype test (10–20 samples) |
| R4 — Thai PDPA | Legal framework confirmed; consent required | HIGH (legal) | Adoption risk real; enforcement severity unclear | Gina review + user interviews |

---

## What This Evidence Pack Can and Cannot Support

### CAN support:
- Vera re-classifying "LINE API can pull past chats" from ASSUMPTION → FALSIFIED
- Vera upgrading "Thai PDPA applies" from ASSUMPTION → CONFIRMED
- Vera confirming "ChatGPT is the dominant substitute" as FACT with source
- Sora/Bumi using macro data for market sizing and competitive positioning analysis
- Rika-Chan making a go/no-go decision on whether to proceed to primary research

### CANNOT support:
- Final product decision (primary research still required for R1 user behaviour, R2 WTP, R3 accuracy)
- Legal sign-off on PDPA compliance (requires Gina + legal counsel)
- Architecture decisions (LINE OA bot vs. paste-only vs. OCR)
- Pricing decisions
- Any claim that R3 accuracy meets the 85% threshold

---

> Next agent: Vera Critical Verifier
> Vera should: re-run claim classification table against this evidence, upgrade/downgrade labels, and flag what is now resolved vs. still open.
> Status: COMPLETE — awaiting Rika-Chan approval before handoff to Vera
