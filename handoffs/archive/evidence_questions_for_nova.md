---
artifact: evidence_questions_for_nova
produced_by: Yuki Idea Challenger
step: 2
input_artifact: handoffs/workflow_plan_001.md
workflow_id: product_idea_debate
date: "2026-06-05"
context_budget: small
status: complete
note: "Nova must NOT begin research until Rika-Chan approves Step 3."
scope_correction: "LINE/OA/API questions are evidence research only. No ingestion architecture is implied or selected. Findings inform Rika-Chan's product direction decision."
---

# Evidence Questions for Nova
## AI Feedback-to-Action Assistant for Freelancers

Research agenda for Nova Evidence Scout (Step 3). Questions are ranked by blocker risk.

---

## Priority 1 — Input Method & LINE API (R1)

These questions resolve the most critical unknown: how does feedback enter the tool?

1. What LINE API capabilities exist for reading message history in personal/group chats? Are there any official or unofficial methods beyond the LINE Messaging API (which is for bots, not chat reading)?
2. What workarounds do Thai freelancers currently use to extract LINE messages for other purposes (e.g., record-keeping, contracts)? Any third-party tools?
3. Is there evidence of other products that use LINE as an input source (not just a notification output)? How did they solve the ingestion problem?
4. What is the LINE "Keep" feature's data accessibility? Can users export Keep content programmatically?
5. Are there Thai freelancer communities (Facebook groups, forums) where users discuss tools for managing client feedback? What tools are mentioned?

---

## Priority 2 — WTP Signal & ChatGPT Substitution (R3)

These questions resolve whether freelancers pay vs. improvise.

6. What is the current ChatGPT adoption rate among Thai freelancers? Any surveys or reports on AI tool usage in the Thai freelance/SME market?
7. Are there existing tools with paying users that solve adjacent problems (feedback management, client communication, freelance project management)? Examples: Bonsai, HoneyBook, Notion, Trello — do Thai freelancers pay for these?
8. What do Thai freelancers spend per month on productivity/work tools? Any data on tool budget for independent workers in Thailand or SE Asia?
9. Are there any products specifically targeting Thai freelancers with AI features? What is their pricing and reported traction?
10. Is there evidence of freelancers paying for prompt templates, ChatGPT plugins, or AI workflow tools rather than using base ChatGPT? Any niche tools in this space?

---

## Priority 3 — AI Accuracy on Thai/Multilingual Feedback (R2)

These questions resolve the technical feasibility of the core AI feature.

11. What is the current state of Thai language NLP/LLM performance? How well do major models (Claude, GPT-4o, Gemini) handle informal Thai text with code-switching (Thai + English)?
12. Is there evidence of multimodal AI (screenshot understanding) being used in feedback or design review workflows? What is the reported accuracy?
13. Are there any published benchmarks or user reports on AI performance for extracting action items from informal conversational text vs. structured documents?
14. What are known failure modes when AI extracts "one next action" from feedback containing multiple, contradictory requests?

---

## Priority 4 — Market Size & User Archetype (for Bumi's use)

These questions feed Bumi's business analysis (Step 6) — lower priority for Nova but valuable to gather now.

15. How large is the Thai freelance market? Any data on number of active freelancers, categories, and income levels?
16. Which freelancer categories (design, dev, content, other) are most active on LINE for client communication? Any data on communication tool usage by freelancer type?
17. Are there reports on the cost of scope creep or miscommunication for freelancers? Quantified pain would support Bumi's WTP analysis.

---

## Source Quality Instructions for Nova

Per `llm_wiki/evidence_source_rules.md`:
- Questions 1–5 (LINE API): prefer official LINE developer documentation and technical community sources over blog posts.
- Questions 6–10 (WTP/market): prefer survey data, industry reports, or product pricing pages over opinion pieces.
- Questions 11–14 (AI accuracy): prefer published benchmarks, academic papers, or documented product tests over marketing claims.
- All sources must pass source-quality-rubric before entering evidence_pack.md.
- Mark all market-size figures with their publication date; flag if older than 18 months.
- **Web search = discovery only.** All claims route to Vera for FACT / ASSUMPTION / OPINION labelling.

---

## Privacy Note for Nova

If research involves Thai freelancer community forums or social media:
- Do not collect or record personal information about individual freelancers.
- If a source contains identifiable personal data, flag it for Gina before including in evidence_pack.md.
- Client message content from any source = `privacy_level: sensitive` minimum; do not include as evidence.

---

> Nova is NOT activated. This file is a planning artifact for Step 3.
> Status: AWAITING_RIKA_CHAN_APPROVAL
> Handoff to: Nova Evidence Scout — only after Rika-Chan approves Step 3.
