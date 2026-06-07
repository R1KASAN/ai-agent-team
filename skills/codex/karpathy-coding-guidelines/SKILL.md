---
name: karpathy-coding-guidelines
version: "1.0"
trust_status: Reference Only
team: codex
invoked_by: reference use only — not directly invoked as an automated step
input: n/a
output: n/a
source: internal principles distilled from public writing; no external repo installed or cloned
---

# Karpathy Coding Guidelines — Reference Only

High-signal coding principles applied by agent judgement, not automation.

## Trust Status

`Reference Only` — these principles may inform how Coda, Kyuuei, and Tessa reason about code quality, but this skill is never invoked as an automated step. No external repository has been installed, cloned, or approved.

> To promote to Trial or Core: apply `llm_wiki/skill_trust_gate.md` (all 10 criteria) and obtain Rika-Chan approval.

## Principles (for reference)

- Prefer simple, readable code over clever code.
- Minimise abstraction layers until complexity genuinely demands them.
- A function should do one thing and do it clearly.
- Avoid premature optimisation; measure before you optimise.
- Tests are documentation; write them to reveal intent.
- When in doubt, delete code — less is more maintainable.

## Forbidden

- Do not invoke this skill as an automated workflow step.
- Do not install, clone, or import any external repository to use these guidelines.
- No shell execution. No external calls.
