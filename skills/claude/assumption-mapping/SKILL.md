---
name: assumption-mapping
version: "1.0"
trust_status: Core
team: claude
invoked_by: yuki_idea_challenger; nova_v
input: claim set or idea_challenge_brief.md
output: assumption map (embedded in calling artifact)
---

# Assumption Mapping Skill

Classifies each claim on two axes to surface which assumptions are load-bearing.

## Protocol

1. List every assumption in the input.
2. For each, assign:
   - **Known / Unknown** — do we have evidence or not?
   - **Important / Less Important** — does the idea fail if this is wrong?
3. Produce a 2×2 grid:
   - **Known + Important** → validate with evidence (Nova)
   - **Unknown + Important** → highest risk; challenge first
   - **Unknown + Less Important** → defer
   - **Known + Less Important** → document, move on
4. Flag the top 1–3 unknown+important assumptions as blockers.

## Required Fields in Output

- `assumption`, `known_unknown`, `importance`, `quadrant`, `blocker` (bool)

## Forbidden

- Do not resolve assumptions — map them only.
- No shell execution. No external calls.
