---
name: debug-mantra
version: "1.0"
trust_status: Reference Only
team: codex
invoked_by: reference use only — principles applied by kyuuei_test_debug
input: n/a
output: n/a
source: internal debugging protocol; no external repo installed or cloned
---

# Debug Mantra — Reference Only

A four-step debugging protocol applied by Kyuuei as a reasoning guide, not as an automated step.

## Trust Status

`Reference Only` — Kyuuei applies this protocol by judgement during `/codex-debug`. This skill is never invoked as an automated step. No external repository has been installed, cloned, or approved.

> To promote to Trial or Core: apply `llm_wiki/skill_trust_gate.md` (all 10 criteria) and obtain Rika-Chan approval.

## The Four Steps (for reference)

1. **Reproduce** — confirm the failure is reproducible. If not reproducible, do not guess.
2. **Trace** — follow the code path. Load only the files relevant to the failure. Do not load broadly.
3. **Hypothesize** — form 2–3 candidate causes ranked by likelihood. Write them down before touching code.
4. **Fix minimally** — implement the fix for the top hypothesis only. One fix per debug cycle.

## Why This Order Matters

Skipping reproduction wastes fix attempts on non-deterministic failures. Skipping tracing leads to fixing symptoms. Skipping hypotheses leads to trial-and-error changes that obscure the root cause.

## Forbidden

- Do not invoke this skill as an automated workflow step.
- Do not install, clone, or import any external repository to use this protocol.
- No shell execution. No external calls.
