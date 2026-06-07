---
template: daily_signal_brief
output_code: ds
produced_by: hikari_intelligence_scout
route: Mi→Hi
version: "1.0"
---

# Daily Signal Brief Template

Canonical shape for `/scout` output. Hard cap: **≤3 signals per session** (anti-overwhelm, Job 3).
Each signal is a **lead, not a verified fact** — anything that becomes a claim must pass Nova-V.

---

```markdown
---
type: signal_brief
date: YYYY-MM-DD
source: Hikari Intelligence Scout
signals_count: 1-3
related_ideas: []   # knowledge/ idea slugs if any already exist
---

# Daily Signal Brief — [Date]

## Signal 1: [Short name]
- **What:** [the event / trend, one line]
- **Why it matters:** [relevance to the owner's product space]
- **Confidence:** high | medium | low
- **Opportunity Angle:** [what you could build off it]
- **Source:** [link]

## Signal 2: [Short name]
- **What:** …
- **Why it matters:** …
- **Confidence:** …
- **Opportunity Angle:** …
- **Source:** …

## Signal 3: [Short name]
- **What:** …
- **Why it matters:** …
- **Confidence:** …
- **Opportunity Angle:** …
- **Source:** …

## Next Steps (owner chooses per signal)
- **Research deeper** → `/research [signal]`
- **Promote to idea pipeline** → `/idea [angle]` (gated)
- **Skip / Defer** → log the reason

> After deciding, log each signal + decision in `logs/signal_log.md`
> (BUILD / SKIP / DEFER / RESEARCH). Phase 1 pattern tracking — no approval needed.
```
