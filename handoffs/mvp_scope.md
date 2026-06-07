---
template: mvp_scope
produced_by: Poom Product Manager
workflow: product_idea_to_prd
companion_to: handoffs/prd.md (prd-20260607-001)
version: "1.0"
---

# MVP Scope — Feedback-to-Action (working title)
## AI Assistant: Scattered Client Feedback → Clear Next Actions

```yaml
scope_id: mvp-20260607-001
produced_by: Poom Product Manager
approved_brief: handoffs/product_opportunity_brief.md (pob-20260607-001)
date: "2026-06-07"
status: draft
locked_architecture: "ONE-SHOT TOOL — dec-20260607-004 (Rika-Chan). Not open for re-litigation in this scope document."
riskiest_assumption_under_test: "A1 — does a one-shot tool clear the ChatGPT-substitute test well enough that users return, with no memory layer to fall back on?"
```

---

## Purpose of This Document

This is the disciplined, numbered cut of what ships in v1 — and only what ships in v1. It exists
so that Aki and Coda have a single unambiguous list to translate into build tasks, and so that
nothing enters the build that wasn't deliberately chosen to test assumption A1. Per Poom's
persona: "Everything not in MVP is explicitly out of scope" — see companion `out_of_scope.md` for
the explicit negative list.

## MVP Feature List (numbered — matches `prd.md` §4 and `acceptance_criteria.md`)

1. **Paste-first text input**
   - What it is: one input surface; user pastes raw feedback text copied from any source (LINE,
     Messenger, email, a doc comment — source is irrelevant to the product).
   - Why it's in: lowest-friction entry point; platform-agnostic per Sora's "streaming, not
     DVD-trap" framing; immediately testable without any integration work.
   - What it is NOT: not a LINE-connected inbox, not an auto-import, not a multi-source aggregator.

2. **Screenshot / image upload input**
   - What it is: user can alternatively (or additionally) upload an image of a chat thread,
     comment section, or design-review annotation; product extracts the feedback content from it.
   - Why it's in: covers the visual-feedback case (design/UI work is a major share of the target
     persona's work); Sora flags multimodal input as a real differentiator, not a nice-to-have.
   - What it is NOT: not OCR-as-a-feature on its own — the extraction is a means to feeding
     features 3 and 4, not a standalone output.

3. **One prioritised next action (output #1)**
   - What it is: exactly one clearly-stated action — not a ranked list, not a checklist — that
     tells the user what to do first in response to the feedback just processed.
   - Why it's in: Sora names this "the single most differentiating output — reduce decision
     fatigue." It is the most direct test of whether the product does something ChatGPT's default
     behavior (which tends to produce lists/options) does not.
   - What it is NOT: not a task manager, not a multi-item to-do, not something that persists or
     gets checked off across sessions (that would require memory — locked out by architecture).

4. **One Thai-language client-update draft (output #2)**
   - What it is: exactly one ready-to-send message in professionally-toned Thai, generated from
     the same input, that the user can copy directly back to their client.
   - Why it's in: Bumi names this the "highest practical value" output; it directly removes the
     professional-writing burden that is the emotional core of the pain (reputation risk).
   - What it is NOT: not a template library, not a multi-draft "pick one," not editable-in-product
     (the product hands off a finished draft; what the user does with it after copying is theirs).

5. **Self-contained, one-shot session (zero persistent memory)**
   - What it is: every run is independent. Nothing about the pasted content, the uploaded image,
     the generated next action, or the generated draft is stored, indexed, or made retrievable
     across sessions — by the user or the product.
   - Why it's in: this is not a "feature" in the usual sense — it is the architectural spine that
     the entire MVP exists to test. `dec-20260607-004` chose this over a memory layer specifically
     to validate WTP fast and cheap. Every other item on this list is here to give that test a
     fair, honest run — nothing else props up retention so the >60% day-3 signal means what it
     should mean.
   - What it is NOT: not "memory we'll add later as a toggle" — within this MVP's scope, it is the
     decision being tested, and changing it requires a new Rika-Chan decision, not a scope-creep
     PRD edit.

## Explicit Non-Goals Baked Into This Scope (cross-reference to `out_of_scope.md`)

The following were deliberately cut by Sora's MVP analysis and are restated here because they are
the most likely scope-creep vectors during build — Aki and Coda should treat any request to add
these mid-build as requiring a return to Rika-Chan, not a quick yes:

- LINE official API / platform connector integration
- Voice or audio input
- A third output (task checklist) — original idea had three outputs, cut to two for MVP focus
- Scheduling, reminders, or any time-based automation
- Any cross-session memory, project history, or client-context accumulation

## What Success Looks Like for This Scope (not a pricing or scaling decision)

The scope above is sized to produce one clear signal: **the Day-3 manual-beta return rate among
10–20 seeded users (Bumi's >60% gate)**, plus the qualitative companion signal — can beta users
answer "what does this do in 10 seconds that ChatGPT can't do in 30" without being prompted. If
both land, the one-shot bet (and this scope) is validated as "enough" before any pricing or
build-scale conversation begins. If they don't, the team has spent the minimum to find out — which
is the entire point of cutting this aggressively.

## Carried-Forward Risk Note for Aki and Coda

**Low moat / fast-follow differentiation risk (from `pob-20260607-001` Open Risks, owner-accepted
as tracked, not blocking):** because this scope intentionally contains no memory layer and no
compounding mechanism, it is realistically reproducible by a competent prompt-engineer using a
ChatGPT custom GPT or Gemini Gem. This is a known, accepted tradeoff — not an oversight. It means:
build the five items above cleanly and fast (speed is the point of this architecture), but design
internal seams (e.g., how the "next action" and "draft" generation steps are structured) so that a
future differentiation layer — better Thai-tone calibration, faster perceived latency, sharper
prompt/output quality — can be added as a fast follow without a rebuild. Do not build in memory or
persistence "just in case" — that would violate the locked architecture and the entire point of
this test. Do design so the next layer, when it comes, is an addition, not a rewrite.

---

> Companion to: `prd.md` (prd-20260607-001) · `acceptance_criteria.md` · `out_of_scope.md`
> Status: draft — gated with `prd.md` under the same Rika-Chan approval before Aki is activated
