---
approval_request_id: approval_request_20260607_002
created_by: Aki System Architect [Ak]
created_at: 2026-06-07
related_workflow: prd_to_codex_tasks (workflow_plan step 2 — Aki technical translation)
related_packet: handoffs/technical_task_packet.md (ttp-20260607-001)
related_prd: handoffs/prd.md (prd-20260607-001) — approved dec-20260607-006
status: RESOLVED — see dec-20260607-007 (logs/decision_log.md). Ruling: (Q1) Beta access = Shape A — single shared invite link/password known only to the 10-20 seeded testers; no accounts, no user table, no persistent per-user state. (Q2) Shape A ruled NOT a full "auth system" — stays inside the locked one-shot architecture (dec-20260607-004) and out_of_scope.md's boundary; no separate auth-gate review required. (Q3) Paid model-API provider/spend ceiling DEFERRED to Coda — Coda researches and proposes provider options + cost estimates at build time; Rika-Chan approves the specific choice then (spend-approval gate stays open for that follow-up). Aki cleared to complete codex_task_packet.md — see handoffs/codex_task_packet.md (ctp-20260607-001).
---

# Approval Request — 20260607-002

`[Ak]` Aki halts here. Per `workflows/prd_to_codex_tasks.md` Step 2 ("Any task touching auth /
payments / database / infra → Aki must stop and produce `approval_request.md` before writing
Codex task packet") and Aki's own spec (`agents/codex_team/aki_system_architect.md` § Approval
Gates: "Any task touching auth / payments / database / infra / production → stop and produce
`approval_request.md` before writing Codex task packet"), this artifact states which gate(s) are
triggered, why, the proposed action, risk level, and what happens if denied — per
`governance/approval_gates.md` § How to Request Approval.

**`codex_task_packet.md` is intentionally NOT written.** `technical_task_packet.md`, `test_plan.md`,
and `files_likely_affected.md` ARE written (they contain analysis and test design, not build
authorization) and are referenced below so Rika-Chan has full context for this decision.

---

## 1. Which gate(s) are triggered

Three related items surfaced during technical translation of the approved PRD
(`prd.md` prd-20260607-001, `dec-20260607-006`). Each maps to a named gate in
`governance/approval_gates.md`:

1. **"Auth system changes" / "Infrastructure changes"** (Production and Infrastructure) —
   triggered by the question of whether a hosted manual-beta tool needs ANY minimal access
   control mechanism.
2. **"Paid API or paid tool usage" / "Any spend or subscription commitment"** (Financial and
   Commercial) — triggered by the fact that every run of the approved MVP feature set requires
   at least one, likely two-to-three, calls to a paid external model API.
3. **"Infrastructure changes (cloud, servers, containers)"** (Production and Infrastructure) —
   triggered by the basic fact that a tool used by 10–20 real beta users has to be hosted
   somewhere reachable.

This is also the literal scenario the PRD itself pre-named and asked Aki to independently verify
rather than assume resolved: `prd.md` §6 states *"if Aki's technical translation requires any of
[pricing/billing/auth/database] to exist even minimally — e.g., a beta-access gate — that
requirement must return to Rika-Chan before being treated as in-scope."* `out_of_scope.md` §7
restates the same rule for "Account / authentication system" and "Database / persistent
infrastructure," explicitly: *"that decision returns to Rika-Chan... not assumed approved by
this document."*

**Aki is not silently deciding either way.** That is the literal instruction this request exists
to honor.

## 2. Why triggered — the technical reasoning that surfaced each item

**(a) Beta-access control.** The approved MVP (`mvp_scope.md` Feature 5, locked by
`dec-20260607-004`) is explicitly architected as a *stateless, account-free, one-shot tool* — and
that part of the architecture is not in question; it is locked and Aki has designed
`technical_task_packet.md` around it faithfully. But §3 of the PRD names the validation mechanism
as "the Day-3 manual-beta return rate among **10–20 seeded users**." A tool that is hosted and
reachable by *anyone* who finds the URL is a different thing — technically and in terms of risk
exposure — than a tool reachable only by the 10–20 seeded users the beta is designed around:

- If the tool is **fully open** (no gate at all): it becomes a public, unauthenticated surface
  that processes pasted client feedback and uploaded screenshots — i.e., real client-identifying
  content — through external paid model APIs, for anyone on the internet, not just the 10–20
  seeded testers. This directly intensifies the **already-named, already-unresolved PDPA/privacy
  risk** (`prd.md` §7 item 3: *"Privacy/PDPA exposure from client message and screenshot upload is
  unresolved... requires legal/governance review before any beta with real client data"*). An open
  tool makes that review's scope larger and its timing more urgent, not smaller.
- If the tool needs **any** gate — even something as minimal as a shared invite link, a single
  shared password, or a hand-managed allowlist of 10–20 names — that is, technically, an access-
  control mechanism. Whether the right word for it is "auth" in the heavyweight sense the
  out-of-scope document was clearly trying to keep out (accounts, persistent user state, login
  systems) is genuinely ambiguous, and Aki is not the right authority to resolve that ambiguity by
  picking a side.

**This is precisely the "minimal access gate" scenario `prd.md` §6 named by example** — Aki's
technical translation surfaced it as a real, unavoidable question (not a hypothetical), exactly as
the PRD anticipated it might.

**(b) Paid API usage.** `technical_task_packet.md` §1–3 establishes that the approved feature set
(Features 1–4: paste input, image input, one next action, one Thai draft) cannot function without
calling at least one external vision/extraction-capable model API (image path) and a text-
generation model API (twice — once per output). This is not a Coda implementation choice Aki is
second-guessing; it is a direct, structural consequence of the MVP scope as approved. But
`governance/approval_gates.md` names "Paid API or paid tool usage" and "Any spend or subscription
commitment" as standing Rika-Chan gates regardless of how the need arose.

**(c) Hosting / infrastructure.** A "stateless one-shot tool" still needs to run somewhere that
10–20 real people can reach over the internet during the beta window. Naming *that hosting must
exist* is an unavoidable consequence of the approved scope; *which* hosting, how it is provisioned,
and what its data-handling posture is are squarely "Infrastructure changes" per the named gate —
and also bear directly on the PDPA/privacy review already pending (governance review step,
`prd.md` §7 item 3).

## 3. Proposed action (what Aki recommends, and will NOT do unilaterally)

Aki proposes — **subject to Rika-Chan's actual decision, not as a pre-made call** — that these
three items be resolved together as a single "minimal beta-operations" decision, because they are
technically entangled (you cannot choose a hosting answer without it implying an access-control
answer, and you cannot choose either without committing to at least one paid API). Aki names two
illustrative shapes the resolution could take — **not as a recommendation for one over the other**,
only so Rika-Chan has concrete texture to react to or replace entirely:

- **Shape A — "narrowest possible gate":** a single shared, hand-rotated invite link or password
  known only to the 10–20 seeded testers, no account system, no user table, no persistent
  per-user state — i.e., the absolute minimum that keeps the tool out of public reach without
  building anything that resembles an account system. Hosting would be the smallest viable
  managed surface; one paid model-API relationship chosen and capped.
- **Shape B — "no gate, accept the exposure consciously":** ship it reachable by URL only (an
  "unlisted" link), accept that this technically means anyone with the link (or who finds it) can
  use it, and treat that as a deliberately bounded risk for a short beta window — paired with
  explicit owner sign-off that this is acceptable given the PDPA review is already pending anyway.

Aki will **not** build either shape, choose between them, or treat either as approved. Whichever
shape (or a third Rika-Chan prefers) is chosen becomes the input that lets Aki finish
`codex_task_packet.md` — at that point the gate is closed and the translation can complete in a
single short follow-up pass (the technical packet, test plan, and file list already account for
this and would need only the access-control detail layered in).

## 4. Open questions for Rika-Chan (≤3, per the dispatcher's "high-risk → ask" rule)

1. **Does the 10–20-person manual beta need ANY access gate, or is an unlisted-link / fully-open
   approach acceptable for this short, bounded validation window?** (This is the crux — everything
   else in this request is downstream of this one answer.)
2. **If a gate is needed, is a non-account, non-persistent mechanism (shared link/password,
   hand-managed allowlist) acceptable as "not really an auth system" for MVP purposes — or does
   Rika-Chan want to treat any access-control mechanism as a full "auth system changes" gate
   requiring its own separate, fuller review later?**
3. **Is there an existing or preferred paid-model-API relationship / spend ceiling Rika-Chan wants
   named now** (so Coda scopes to it directly), **or should Coda propose options for Rika-Chan to
   approve at build time?** (This determines whether the spend-commitment gate closes now or is
   deferred to a Coda-proposal-then-approval cycle — either is fine; Aki needs to know which.)

## 5. Risk level

**High** — for two independent reasons:

- It compounds with the **already-open, already-named PDPA/privacy risk** (`prd.md` §7 item 3),
  which is itself flagged for governance review before any beta with real client data. A wrong or
  premature call here (in either direction — too open, or building more "auth" than intended)
  could either (a) widen the privacy exposure the governance review is meant to catch before it
  happens, or (b) cause Coda to over-build an account system that violates the locked one-shot
  architecture (`dec-20260607-004`) and the explicit out-of-scope boundary (`out_of_scope.md` §7).
- It is a **named hard-gate category** (auth/infra/paid-spend) compounded with a live, scheduled
  beta — meaning the cost of getting this wrong is not abstract; it would land on real people's
  real client data within the validation window the PRD describes.

## 6. What happens if denied / not yet approved

- The workflow **stays at `technical_task_packet.md` (ttp-20260607-001), HALTED**. No
  `codex_task_packet.md` is produced, no Codex Team activation occurs, and no build begins.
- This is the **safe default**, not a failure state — it is exactly the stop condition
  `workflows/prd_to_codex_tasks.md` Step 2 and Aki's own spec describe, and exactly the scenario
  `prd.md` §6 and `out_of_scope.md` §7 pre-named and asked Aki to surface honestly rather than
  resolve unilaterally.
- `test_plan.md` (tp-20260607-001) and `files_likely_affected.md` (fla-20260607-001) remain valid
  and reusable once the gate clears — they do not need to be rewritten, only activated alongside
  the (currently unwritten) Codex packet.
- If Rika-Chan wants a **lighter-weight clarification first** (e.g., confirming with Bumi whether
  the 10–20 seeded testers are already a known, named group that makes "Shape A" trivial, or
  checking with the governance step on whether it would rather see the access-gate question folded
  into its own pending PDPA review), Aki can wait for that without re-running any analysis — the
  technical packet does not change based on who answers first, only based on what the answer is.

---

## Aki Stop Declaration

`[Ak]` Aki halted here per `workflows/prd_to_codex_tasks.md` Step 2's explicit stop condition and
Aki's own Approval Gates clause, having independently verified — as instructed — that the PRD's
"no auth/payments/DB/infra in MVP scope" claim (`prd.md` §6, confirmed in `out_of_scope.md` §7)
holds at the *product-feature* level but surfaces a real, unavoidable *technical-translation*
question at the *operational* level (how does a hosted, account-free tool reach 10–20 real beta
users without becoming either a public PDPA-exposure surface or an accidental account system).
Awaiting Rika-Chan's decision on the three open questions in §4 (answer or explicitly waive), the
named gates in §1, and which shape (if any, per §3) the resolution should take. `codex_task_packet.md`
will be written as the immediate next step once this resolves — no other part of the translation
needs to be redone.

---

## Resolution — `dec-20260607-007` (2026-06-07, Rika-Chan)

`[Ak]` This request is **RESOLVED**. Rika-Chan's verbatim ruling is recorded at
`logs/decision_log.md#dec-20260607-007`. Summary, mapped back to §4's three questions:

1. **Q1 (does the beta need any access gate) → Shape A.** A single shared invite link/password
   known only to the 10–20 seeded testers. No accounts, no user table, no persistent per-user
   state. (Shape B — no gate — was not chosen; the ruling's rationale notes Shape B would have
   widened the pending PDPA/privacy review's scope, which Shape A does not.)
2. **Q2 (is a minimal mechanism "not really an auth system") → Yes, ruled NOT a full auth system.**
   Shape A stays inside the locked one-shot architecture (`dec-20260607-004`) and
   `out_of_scope.md`'s boundary. Coda may build it without triggering a separate auth-gate review.
3. **Q3 (name a provider/ceiling now, or defer) → DEFERRED to Coda.** Coda researches and proposes
   provider options with cost estimates when it reaches that part of the build; Rika-Chan approves
   the specific choice at that point. The spend-commitment gate stays open for that follow-up
   checkpoint — it is not closed blindly now, and it is not a silent pick by Aki or Coda.

**Effect:** The halt is lifted. Aki proceeds to write `codex_task_packet.md` (now produced as
`ctp-20260607-001`, see `handoffs/codex_task_packet.md`), incorporating Shape A as the named
minimal access mechanism and flagging the Q3 paid-API choice as an explicit
"Coda proposes → Rika-Chan approves" in-build checkpoint. `technical_task_packet.md`,
`test_plan.md`, and `files_likely_affected.md` were reviewed against Shape A's specifics per
Aki's own prediction in §6 above ("they do not need to be rewritten, only activated") — that
prediction holds; no rework was required (see `codex_task_packet.md`'s closing note for the small
deltas, if any, layered in alongside activation).
