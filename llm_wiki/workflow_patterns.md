---
version: "1.0"
maintained_by: llm_wiki_reference_owner
authority: Rika-Chan
---

# Workflow Patterns

Named patterns agents should recognise and apply. These are structural descriptions, not executable scripts.

---

## 1. Sequential Handoff (default)

**When:** All standard workflows.
**Pattern:** Agent A produces artifact → handoff.md → Agent B reads artifact → produces next artifact.
**Rule:** No agent starts until the previous agent's artifact exists. No parallel steps without approval.

---

## 2. Artifact Gate

**When:** Every step transition.
**Pattern:** Before an agent starts, confirm its required input artifact exists and is complete.
**Fail condition:** Input artifact missing or incomplete → stop; flag to Minori; do not proceed.

---

## 3. Jidoka Stop

**When:** Any agent encounters uncertainty, a blocked verdict, missing approval, or an out-of-scope finding.
**Pattern:** Stop immediately. Document the reason in the current artifact. Do not guess or proceed. Escalate to Minori or Rika-Chan.
**Rule:** Guessing past a Jidoka stop is a forbidden action (`governance/forbidden_actions.md`).

---

## 4. Hard Approval Gate

**When:** Poom after brief, PRD before Aki, any codex_task_packet item with auth/payment/db/infra, deployment.
**Pattern:** Agent produces artifact → stops → Rika-Chan reviews → explicit approval → workflow resumes.
**Rule:** The workflow does not auto-resume. Approval is always an explicit human action.

---

## 5. Blocked Verdict Propagation

**When:** Kyuuei security/test check returns `blocked`; Tessa returns `blocked`; Rika-Chan governance gate blocks.
**Pattern:** The verdict stops the entire current workflow. The downstream agent is not invoked. Rika-Chan is notified.
**Rule:** A blocked verdict is never downgraded by the agent that issued it.

---

## 6. Kaizen Loop

**When:** End of each workflow cycle.
**Pattern:** Owner receives artifact list (paths only) → produces `kaizen_report.md` → proposals handed to Minori or Rika-Chan → Rika-Chan decides which apply.
**Rule:** No improvement is auto-applied.

---

## 7. Memory Intake Gate

**When:** Raw input contains PII or restricted data.
**Pattern:** Mira tags `privacy_level: restricted` → hard stop → Rika-Chan approval → Mira emits scoped graph update only if approved.
**Rule:** Restricted data never flows to graph tooling without explicit approval.

---

> Full workflow definitions: `workflows/` | Token rules: `token_optimization_rules.md`
