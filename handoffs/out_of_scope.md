---
template: out_of_scope
produced_by: Poom Product Manager
workflow: product_idea_to_prd
companion_to: handoffs/prd.md (prd-20260607-001)
version: "1.0"
---

# Out of Scope — Feedback-to-Action (working title)
## AI Assistant: Scattered Client Feedback → Clear Next Actions

```yaml
oos_id: oos-20260607-001
produced_by: Poom Product Manager
companion_to: handoffs/prd.md (prd-20260607-001), handoffs/mvp_scope.md (mvp-20260607-001)
date: "2026-06-07"
status: draft
rule: "Explicit. Everything not in mvp_scope.md is assumed out of scope. This document exists so nothing is implied — every cut item is named and reasoned."
```

---

## Purpose

Per Poom's persona ("does not let scope creep in through the back door... everything not in MVP
is explicitly out of scope") and the PRD structure's requirement for an explicit out-of-scope
list, this document names every major item that was considered and deliberately cut, with the
reasoning, so that:

- Aki and Coda know what *not* to build, and why, so they don't quietly re-add it
- Future scope-expansion requests can be checked against a documented decision rather than
  re-litigated from scratch
- The owner (Rika-Chan) can see at a glance what tradeoffs were accepted in exchange for a lean,
  fast-to-validate MVP

---

## 1. Platform / Channel Integrations

| Cut item | Why it's out |
|---|---|
| LINE official API integration | Sora: "unvalidated feasibility; paste-first removes this dependency entirely." Bumi independently flags "LINE API constraints forcing manual input" as a high-severity, unresolved business risk. Building toward an unvalidated API is the textbook DVD-trap Sora warns against — a platform bet that inherits LINE's technical constraints permanently. |
| Messenger / Google Drive / Notion connectors | Sora's MVP cut list: "adds API complexity, ToS risk, and scope — not required to validate core value." Paste-first already covers the platform-agnostic case these would address, at zero integration cost. |
| Any future platform connector (WhatsApp, Telegram, etc.) | Same reasoning — the product's bet is "any feedback from any source → structured output," and paste already satisfies that without per-platform engineering. LINE remains a *marketing* hook for Thai acquisition, never a technical dependency (Sora's explicit strategic recommendation). |

## 2. Input Modes Beyond Text + Screenshot

| Cut item | Why it's out |
|---|---|
| Voice / audio input | Sora's MVP cut list: "high technical complexity; paste text is sufficient for MVP validation." Adds a transcription dependency and quality-variance risk that doesn't serve the core test (does one-shot output beat ChatGPT). |

## 3. Output Surface

| Cut item | Why it's out |
|---|---|
| Task-checklist as a third output | Sora: "the original idea had 3 outputs; cut to 2 (next action + client draft) for MVP focus." A checklist implies persistence/tracking across time — which conflicts with the locked one-shot architecture — and dilutes the "exactly one prioritised action" differentiation that Sora names as the single most valuable output. |
| Multiple draft options / "pick one" client-message variants | Not in Sora's keep list; adds decision fatigue back into the product at exactly the point it's meant to be removed. One clear draft is the value; multiple options reintroduce the "mental prioritisation" burden the product exists to eliminate. |
| In-product editing of generated drafts | The product's job ends at "ready-to-send draft the user can copy." Building an editor duplicates functionality the user's existing tools (LINE, notes apps, etc.) already provide, and adds surface area unrelated to testing A1. |

## 4. Automation / Time-Based Features

| Cut item | Why it's out |
|---|---|
| Automated scheduling or reminders | Sora's MVP cut list: "out of scope for feedback-processing core." This is a different job (time management) bolted onto a feedback-processing tool; it would also imply state that persists across sessions — conflicting with the locked architecture. |

## 5. Memory, History, and Persistence (the architectural boundary — not a deferred feature)

| Cut item | Why it's out |
|---|---|
| Project memory / per-client history / accumulating context | This is the **other side of the strategic fork Rika-Chan resolved in `dec-20260607-004`** — the "memory layer" path was explicitly not chosen for this MVP. It is not a feature awaiting prioritisation; it is the architecture that was *not* selected, in favour of one-shot speed-to-validation. Re-adding it requires a new Rika-Chan strategic decision, not a PRD scope edit. Sora's own analysis frames this as the long-term "3–5 year bet" — real, but explicitly not this product's MVP. |
| Cross-session "remembers your preferences" behavior | Same boundary as above — any mechanism that lets session N know about session N-1 violates Feature 5 of the MVP scope (the architecture being tested) and would invalidate the >60% return-rate signal by propping up retention with something other than output quality. |

## 6. User Segments and Surfaces

| Cut item | Why it's out |
|---|---|
| Small-agency / multi-seat / team routing and assignment | Bumi's secondary archetype. Per the approved brief: "explicitly out of scope for this MVP; it requires a different product surface and is noted only as a future expansion path." Building for it now would mean designing two products at once and serving neither well. |
| Per-seat or team pricing surfaces | Falls out of the above — no team surface, no team pricing surface needed at MVP. |

## 7. Commercial / Infrastructure Layer (flagged separately — not Poom's call)

| Cut item | Why it's out |
|---|---|
| Pricing and billing | Poom is explicitly forbidden from setting pricing in the PRD (per `agents/claude_team/poom_product_manager.md` Forbidden Actions). The approved brief's "$5–8/month" figure is an unsourced ASSUMPTION-level hypothesis (Bumi, confirmed in `pob-20260607-001` Open Risks) — no pricing decision should be made before the Phase-1 manual-beta WTP signal lands, per Bumi's own gate. |
| Payment integration / subscription system | Follows directly from "no pricing decision yet" — there is nothing to integrate toward until a pricing model is chosen, and that choice sits with Rika-Chan post-beta. |
| Account / authentication system | Not named anywhere in the approved brief's MVP hypothesis ("paste-first... zero persistent storage... each session is self-contained"). An account system implies persistence across sessions — in tension with the locked one-shot architecture. If Aki's technical translation later determines some minimal access gate is needed for the manual beta (e.g., to manage the 10–20 seeded users), **that decision returns to Rika-Chan** before being treated as in-scope — per the workflow's explicit rule: "any auth/payments/database/infra items in PRD → flagged for Rika-Chan before Aki runs." |
| Database / persistent infrastructure beyond what a stateless one-shot tool requires | Same boundary as memory/history above — flagged for Rika-Chan if Aki's translation surfaces any requirement here, not assumed approved by this document. |

---

## What This List Does Not Cover

This list names *product-feature* cuts. It does not resolve the open *risk* items carried forward
in `prd.md` §7 (low moat, Thai-NLP accuracy, PDPA/privacy, unsourced WTP, sample-corpus sourcing) —
those are open questions requiring action from other owners (Aki/Coda, governance review,
Rika-Chan), not scope decisions Poom can close by listing them here.

---

> Companion to: `prd.md` (prd-20260607-001) · `mvp_scope.md` · `acceptance_criteria.md`
> Status: draft — gated with `prd.md` under the same Rika-Chan approval before Aki is activated
