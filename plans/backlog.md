# Backlog / Deferred Enhancements

> Source: Phase 7 of `plans/ai_agent_team_memory_evidence_full_alignment_plan.md`.
> Every item here is **deferred, optional, and not part of Phase 1 canonical alignment**.
> Each requires a new workflow plan and Rika-Chan approval before implementation.

## Status legend

`Deferred` = recorded, not scheduled, not approved for build.

All items below are `Deferred`.

## Items

### 1. Graph-assisted routing — `Deferred`

Use `knowledge/` graph metadata (`graph_node_type`, `related_entities`, `graph_relations`)
to help Minori suggest a route. Must **preserve `/idea-gate` as the single canonical front
door** — graph signals advise classification only, never replace the gate.
Risk: added complexity; routing must stay deterministic and explainable.

### 2. Richer `/ask` citations by heading — `Deferred`

Extend the proposed read-only `/ask` (Tsumugi) so citations resolve to note path **and
the specific heading/anchor**, not just the file. Depends on the Phase 2 `/ask` proposal
being approved first. Read-only; no new write paths.

### 3. Run dashboard — `Deferred`

Summarize `logs/agent_runs/*` into a concise run overview (command, agent, mode, artifacts,
approval gates hit). Read-only over logs.
Risk: must not expose sensitive/restricted metadata; redaction rules from Phase 3 apply.

### 4. Knowledge health report — `Deferred`

Periodic read-only report over `knowledge/`: schema-completeness of frontmatter, orphan
notes, missing `last_verified_at`, privacy-level coverage. Output is a draft report only;
no auto-edits to notes.

### 5. Stale note detector — `Deferred`

Flag `knowledge/` notes whose `last_verified_at` is beyond a threshold or whose sources are
outdated. Produces a candidate list for Mira/Nova-V review. Detection only — never
auto-rewrites or auto-archives notes.

### 6. Decision/lesson promotion automation — `Deferred`

Assist promoting recurring decisions/lessons into `knowledge/reference/decision_ledger.md`
and `lessons_ledger.md`. Mira remains the only normal writer; any write uses the
No-Overwrite Rule and Rika-Chan approval.

### 7. Integration tests for command docs — `Deferred`

Static/integration checks that every active command doc routes to active agents only and
references existing artifacts. Extends `scripts/validate_active_alignment.sh`. Read-only;
any file-editing test harness is out of scope without separate approval.

## Approval gate

Do not implement any item above without:
1. A new dedicated workflow plan, and
2. Rika-Chan approval.

Graph-assisted routing, run dashboards, and automation may touch routing logic, logs, or
privacy-sensitive metadata and therefore carry hard gates.
