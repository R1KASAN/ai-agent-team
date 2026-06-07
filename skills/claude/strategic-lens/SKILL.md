---
name: strategic-lens
version: "1.0"
trust_status: Core
team: claude
invoked_by: sora_strategy_sensei; /product-idea-debate step 5
input: verified_evidence_pack.md
output: strategic_lens.md
template: templates/strategic_lens.md
---

# Strategic Lens Skill

Applies four strategic frames to Nova-V's verified evidence and produces a directional view.

## Four Frames

1. **Old Game / New Game** — is this idea optimising an existing game or creating a new one? New game = higher potential; old game = must find defensible niche.
2. **DVD Trap** — does this idea risk being disrupted by the same force it is riding? Flag if yes.
3. **Moat Analysis** — what makes this defensible in 3 years? Options: network effect, data flywheel, switching cost, brand, regulatory, distribution.
4. **3–5 Year Bet** — what must the world look like in 3–5 years for this to win? State explicitly.

## Protocol

1. Apply each frame to the verified claims.
2. Identify what to cut from the idea (lowest strategic value).
3. Write `strategic_lens.md` with one paragraph per frame + a "cut list".

## Forbidden

- Do not validate the idea — assess it strategically.
- Do not skip the DVD Trap frame even if it seems unlikely.
- No shell execution. No external calls.
