---
template: product_scout_brief
output_code: ps
produced_by: hikari_intelligence_scout
route: Mi→Hi
trigger: /scout <URL>
version: "1.0"
---

# Product Scout Brief Template

Canonical shape for `/scout <URL>` (link-driven Product Scout mode). The owner pastes one link;
Hikari fetches it, summarizes, and frames 2–3 product opportunity angles.

The summary + angles are **leads, not verified facts** — anything that becomes a claim must pass
Nova-V; deeper validation → `/idea` (Yuki). Hikari does **not** verify or strategize here; this is
fast opportunity-framing only. **One brief per URL** (separate from the ≤3-signals discovery cap).

> Sensitive-domain URLs (health / finance / legal / auth / payment / government-ID) → **STOP**:
> do not fetch, do not auto-write, flag Rika-Chan (`governance/privacy_rules.md` §5).

---

```markdown
---
type: product_scout_brief
date: YYYY-MM-DD
source: Hikari Intelligence Scout (link-driven)
source_url: <the URL>
privacy_level: public      # sensitive/restricted → STOP, do not auto-write (flag Rika-Chan)
related_ideas: []          # knowledge/ idea slugs if any already exist
---

# Product Scout Brief — [Date]

**Source:** [URL]

## Summary (key takeaways)
- [3–5 bullets — the gist, not a raw dump]

## Opportunity Angles (2–3)

### Angle 1: [short name]
- **What you could build:** …
- **Why it fits your product space:** …
- **Confidence:** high | medium | low

### Angle 2: [short name]
- **What you could build:** …
- **Why it fits your product space:** …
- **Confidence:** high | medium | low

### Angle 3: [short name]   <!-- optional -->
- **What you could build:** …
- **Why it fits your product space:** …
- **Confidence:** high | medium | low

## Suggested Next Step (owner chooses)
- **Validate the idea** → `/idea [angle]` (Yuki, gated)
- **Verify the source / claims** → `/research [URL]` (Nova-V)
- **Skip / Defer** → log the reason

> After this brief, Hikari auto-appends ONE tracking row to `logs/signal_log.md`
> (`Signal Type = link-scout: …`, strongest angle, Decision suggested) — owner accepts or edits.
> Leads-not-facts: promoting any angle to a claim still requires Nova-V.
```
