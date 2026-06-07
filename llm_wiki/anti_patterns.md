---
version: "1.0"
maintained_by: llm_wiki_reference_owner
authority: Rika-Chan
---

# Anti-Patterns

Common failure modes in this system. Every agent should recognise these and stop when they appear.

---

## Context Anti-Patterns

| Anti-Pattern | Description | Correct Behaviour |
|-------------|-------------|-------------------|
| **Context flooding** | Loading the full codebase or all artifacts for a small task | Load only files in `files_likely_affected.md` or declared in `workflow_plan.md` |
| **Budget creep** | Gradually expanding context scope without re-approval | Stop; request budget re-assignment from Minori |
| **Stale context pack** | Using a `current_context_pack.md` from a prior session | Re-read `last_checkpoint.md` and `project_state.md` at session start |
| **Handoff bloat** | Passing full artifact content in `handoff.md` instead of paths | Pass artifact path only; next agent loads it if needed |

---

## Workflow Anti-Patterns

| Anti-Pattern | Description | Correct Behaviour |
|-------------|-------------|-------------------|
| **Skipping the gate** | Starting a workflow step without confirming the input artifact exists | Apply Artifact Gate pattern; stop if artifact is missing |
| **Auto-resuming after stop** | Continuing a workflow after a Jidoka stop without Rika-Chan signal | Wait for explicit approval or instruction |
| **Compressing approval gates** | Treating "probably approved" as approved | Approval is always explicit; no inference allowed |
| **Parallel by default** | Running agents in parallel without meeting all 6 fanout conditions | Default to sequential; fanout requires all 6 conditions + Rika-Chan approval |
| **Stub activation** | Attempting to run a `stub_only` workflow | Stub workflows must be designed and approved before activation |

---

## Evidence Anti-Patterns

| Anti-Pattern | Description | Correct Behaviour |
|-------------|-------------|-------------------|
| **Skipping Nova-V verification** | Using raw source claims downstream without `verified_evidence_pack.md` labels | All claims must pass through Nova-V claim verification before use |
| **Tertiary as primary** | Citing blog posts or social media as FACT | Tertiary sources are discovery only; never FACT |
| **Hallucination laundering** | Restating a HALLUCINATION_RISK claim in a downstream artifact without the label | The label travels with the claim until it is verified or removed |

---

## Skill Anti-Patterns

| Anti-Pattern | Description | Correct Behaviour |
|-------------|-------------|-------------------|
| **Trust inflation** | Using a `Reference Only` skill as if it were `Core` | Reference Only = judgement guide only; not an automated step |
| **Unapproved install** | Installing or cloning a skill from an external repo without trust gate evaluation | All external skills must pass `skill_trust_gate.md` before any use |
| **Auto-promoting status** | Changing a skill's `trust_status` without trust gate + Rika-Chan approval | Status changes require the full gate process |

---

> Forbidden actions: `governance/forbidden_actions.md` | Skill gate: `skill_trust_gate.md`
