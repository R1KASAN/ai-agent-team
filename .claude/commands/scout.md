---
command: scout
description: Surface the daily signal feed — news + trends → product opportunities (max 3 signals).
entry_agent: minori_lead_conductor
executing_agent: hikari_intelligence_scout
route: Mi→Hi
context_budget: small
core_flow: true
required_input: none (Discovery mode), OR a single URL (Product Scout mode); optional focus area / domain from Rika-Chan
optional_input: domain filter, time window, supporting artifact paths; never full chat history
forbidden_actions: bypassing Minori, raw info dump, exceeding 3 signals/session, starting downstream workflows automatically, using large/dynamic context without approval, overwriting existing files without approval, fetching/auto-writing a sensitive-domain URL
produces: daily_signal_brief.md (ds) [Discovery] — shape in templates/daily_signal_brief.md; product_scout_brief.md (ps) [Product Scout] — shape in templates/product_scout_brief.md
approval_gate: none for surfacing; any signal escalated into a product workflow requires Rika-Chan approval
stop_condition: ≤3 signals surfaced with WHY-IT-MATTERS framing; no product workflow starts automatically
logging: "After surfacing, Hikari AUTO-APPENDS one row per signal to logs/signal_log.md (append-only, Decision/Reasoning=pending) under standing approval dec-20260607-001. Owner fills only Decision (BUILD/SKIP/DEFER/RESEARCH) + Reasoning on pending rows. sensitive/restricted signals are NOT auto-written."
ref: system_prompt_v1.md  (Hikari persona + Quick Trigger Cheatsheet)
---

Triggered by "สวัสดีตอนเช้า" / "what's new" / `/scout`. Minori gates, Hikari executes.

## Two modes (Minori detects from input)

- **Discovery** — `/scout` with no argument (or a focus/domain). Hikari web-searches and surfaces
  at most 3 signals per session, each framed as `SIGNAL → WHY IT MATTERS → opportunity`. Output
  `daily_signal_brief.md`. **Unchanged.**
- **Product Scout (link-driven)** — `/scout <URL>`. Hikari WebFetches the single link, summarizes
  it (3–5 bullets), and frames **2–3 product opportunity angles**. Output `product_scout_brief.md`.
  One brief per URL (separate from the ≤3-signals discovery cap — the owner explicitly chose this link).

No raw info dump in either mode. Surfacing/framing only — turning an angle into a build is a
separate, gated decision (`/idea` Yuki, or `/research` Nova-V for verification).

### Product Scout flow
1. **Privacy pre-check:** if the URL is a sensitive domain (health / finance / legal / auth /
   payment / government-ID) → **STOP**, flag Rika-Chan, do NOT fetch or auto-write
   (`governance/privacy_rules.md` §5).
2. **WebFetch** the URL → extract main text.
3. **Summary:** 3–5 bullet key takeaways (not a raw dump).
4. **Ideation:** 2–3 opportunity angles (angle + why-it-fits-your-product-space + confidence).
   Lightweight framing only — NOT validated strategy (that is Sora) and NOT verified (that is Nova-V).
5. Write `product_scout_brief.md`.
6. Auto-append **one** tracking row to `logs/signal_log.md` (`Signal Type = link-scout: <topic>`,
   strongest angle, suggested Decision + Reasoning, `Status = open`). Append-only.

## Governance
- Privacy: external news/trend sources only; no client or personal data in the feed.
  Product Scout fetches **public** URLs only; sensitive-domain links STOP (see flow step 1).
- Trust Gate: any tool/skill used for scouting must pass `llm_wiki/skill_trust_gate.md`.
  **WebFetch** (Product Scout mode) is registered there — public URLs, leads-not-facts, no PII/restricted.
- Standing approval: Product Scout WebFetch + brief/log writes run unattended under
  `dec-20260607-002` (mirrors discovery's `dec-20260607-001`). No per-run gate for public links.
- Anti-overwhelm: hard cap of 3 signals enforced in Discovery (Job 3 of the OS).

## Signal Tracking (Phase 1b-Enhanced — auto-append + suggest)
After the brief, **Hikari auto-appends** one row per signal to `logs/signal_log.md` under standing
approval `dec-20260607-001` (no per-run gate):
`Date | Signal Type | Confidence | Opportunity Angle | Decision | Reasoning | Status`, with
**suggested Decision + Reasoning** (based on signal confidence + opportunity angle clarity) and
`Status = open`. **Append-only** — new rows at the table bottom only; never edit/delete existing rows,
never touch frontmatter/header or any other file; if the file is missing, STOP and ask (do not recreate).
`sensitive/restricted` signals (legal/privacy/finance/health) are NOT auto-written — flag to Rika-Chan instead.

**Owner** reviews each row: accepts the suggested Decision + Reasoning, or edits to fit their judgment.
Owner can also set `Status` if desired. Minori adds one non-blocking closing reminder. Rows are leads,
not facts: promoting a signal to a claim still requires Nova-V. A real strategic/financial/build commitment
ALSO goes in `logs/decision_log.md`; Mira mirrors gate outcomes into `knowledge/reference/decision_ledger.md`.
Phase 2 (after first ship) adds an `Outcome` column linking signal → product.
