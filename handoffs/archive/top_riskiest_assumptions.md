---
artifact: top_riskiest_assumptions
produced_by: Yuki Idea Challenger
step: 2
input_artifact: handoffs/workflow_plan_001.md
workflow_id: product_idea_debate
date: "2026-06-05"
context_budget: small
status: complete
scope_correction: "LINE/OA/API treated as unresolved assumption only. No input architecture selected. Product direction pending Rika-Chan approval."
---

# Top Riskiest Assumptions
## AI Feedback-to-Action Assistant for Freelancers

---

## Assumption Map (2×2)

```
                    IMPORTANT            LESS IMPORTANT
                ┌─────────────────┬─────────────────────┐
   UNKNOWN      │  🔴 BLOCKERS    │  🟡 DEFER           │
                │  R1, R2, R3     │  D1, D2             │
                ├─────────────────┼─────────────────────┤
   KNOWN        │  ✅ VALIDATED   │  ℹ️  NOTE           │
                │  K1, K2         │  N1                 │
                └─────────────────┴─────────────────────┘
```

---

## 🔴 Blockers — Unknown + Important

### R1 — INPUT METHOD (NEW RISK — not in workflow_plan_001.md)
**Assumption:** LINE feedback can reach the tool without significant manual friction.
**Reality:** LINE has no open API for reading personal or group chat history. The user must manually copy-paste text or upload screenshots.
**Why it matters:** If input is always manual, the product is a prompt template with a UI — not a differentiated AI product. The "messy LINE chats → structured output" value proposition relies on seamless ingestion. Manual copy-paste means the user has already done the hardest cognitive step (reading and selecting the relevant feedback) before the AI helps.
**Kill condition:** If manual input is the only viable method AND users compare it to "paste into ChatGPT," differentiation collapses.
**What would resolve it:** Nova to research and document official LINE platform constraints (what ingestion paths are technically available). All findings are inputs to Rika-Chan's product direction decision — no architecture is selected here. Input method remains an unresolved assumption.

---

### R2 — AI ACCURACY ON INFORMAL MULTILINGUAL FEEDBACK
**Assumption (A3 from wp-001):** AI can reliably extract ONE clear next action from informal, emoji-heavy, contradictory, multilingual (Thai + English mix) feedback.
**Why it matters:** The core product promise is "one clear next action." If the AI produces the wrong action, the freelancer wastes time, misses a deliverable, or damages the client relationship. The failure mode is worse than no tool.
**Specific challenge vectors:**
- Client says: "อยากให้ปรับสีให้สดขึ้น แต่ก็อย่าให้ดูแรงเกินไปนะ" ("Make it more vibrant but not too loud") — what is the one next action?
- Feedback includes both a critical blocker and a nice-to-have in the same message — which does AI choose?
- Screenshots of designs: does multimodal AI understand "move this button to the right" from a screenshot with no labels?
**Kill condition:** If accuracy in real Thai freelancer feedback scenarios is below ~85%, the tool creates liability rather than value.
**What would resolve it:** Prototype test with 10–20 real feedback samples from Thai freelancers; measure accuracy of extracted next action.

---

### R3 — WTP SIGNAL VS. CHATGPT SUBSTITUTE
**Assumption (A2 from wp-001):** Pain is severe enough that freelancers pay for a dedicated subscription rather than use free/existing tools.
**The substitute problem:** Thai freelancers who are already ChatGPT users can paste feedback and prompt "summarise this as: next action, client message, checklist." Cost: $0 (free tier) or shared with other use cases ($20/month ChatGPT Plus).
**Why this is the real threat:** Not a competitor building the same product — it's the user's own improvised workflow being good enough.
**Discriminating questions:**
- Do freelancers currently use ChatGPT for this? If yes, what's missing?
- Would a specialized tool (faster, template-aware, project-memory) command $5–10/month on top of ChatGPT?
- Or is the real market freelancers who have NOT adopted ChatGPT yet and need a simpler entry point?
**Kill condition:** If >60% of target users already use ChatGPT for this, the WTP ceiling is very low unless the product offers clear differentiation.
**What would resolve it:** 5–10 freelancer interviews asking about current workflow + tool spend.

---

## 🟡 Defer — Unknown + Less Important

### D1 — Exact monetization model
**Assumption:** Subscription is viable.
**Why deferrable:** Model can be validated after WTP signal is confirmed. Per-use pricing, freemium, or bundling are alternatives.

### D2 — Output format preference
**Assumption:** Three-output format (next action + update message + checklist) is what freelancers want.
**Why deferrable:** Format is testable cheaply via prototype. The core value (structured extraction from messy input) doesn't depend on exact output format.

---

## ✅ Validated — Known + Important

### K1 — Problem exists
Freelancers receiving fragmented client feedback and struggling to prioritise is a real, documented pain point across the freelance community globally. Not disputed.

### K2 — LINE dominance in Thai market
LINE is the dominant communication platform in Thailand for both personal and professional use. Thai freelancers routinely conduct client relationships over LINE. This is well-established.

---

## ℹ️  Note — Known + Less Important

### N1 — Multiple output types exist
The three proposed outputs (next action, update message, checklist) are real outputs that freelancers produce manually today. They exist and are needed.

---

## Priority for Nova's Evidence Gathering

Nova should prioritise evidence for R1, R2, and R3 in that order.

| Rank | Assumption | Evidence type needed |
|------|-----------|---------------------|
| 1 | R1 — Input method | Technical: LINE API capabilities; existing workarounds |
| 2 | R3 — WTP vs ChatGPT | Market: freelancer tool spend; ChatGPT adoption among Thai freelancers |
| 3 | R2 — AI accuracy | Technical + market: multimodal AI performance; Thai NLP tools |

> See `evidence_questions_for_nova.md` for specific research questions.
> Status: AWAITING_RIKA_CHAN_APPROVAL before Nova proceeds.
