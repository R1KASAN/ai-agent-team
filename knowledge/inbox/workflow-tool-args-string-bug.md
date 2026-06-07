---
title: "Workflow tool delivers `args` as a JSON-encoded string, not an object — idea-stresstest.js hard-guard abort"
summary: "Workflow tool top-level `args` arrives in-script as a JSON string, not a real object — `args.rika_dynamic_approved` reads `undefined` and the hard guard in idea-stresstest.js aborts instantly; confirmed 2x as a tool-level limitation, with an unproven workaround pending a 3rd confirmation."
type: lesson
status: confirmed_2x_pending_3rd_confirmation
owner: mira_memory_librarian
tags: [workflow-tool, bug, idea-stresstest, args-serialization, lesson, instinct-candidate]
source_type: note
source_url: ""
source_url_or_path: ".claude/workflows/idea-stresstest.js:32-48"
created: "2026-06-07"
updated: "2026-06-07"
privacy_level: internal
confidence: high
related_project: "Phase 1 e2e proof — Workflow tool diagnosis"
related_entities: [idea-stresstest.js, Workflow tool, Mira, Minori]
graph_node_type: Instinct
graph_relations: [derived_from, relates_to]
last_verified_at: "2026-06-07"
---

# Workflow tool delivers `args` as a JSON-encoded string, not an object — idea-stresstest.js hard-guard abort

> Workflow tool top-level `args` arrives in-script as a JSON string, not a real object — `args.rika_dynamic_approved` reads `undefined` and the hard guard in idea-stresstest.js aborts instantly; confirmed 2x as a tool-level limitation, with an unproven workaround pending a 3rd confirmation.

## Content

**Bug:** The Workflow tool passes top-level `args` into the script as a **JSON-encoded string**,
not a JS object. As a result `args.rika_dynamic_approved` evaluates to `undefined`, and the hard
guard in `.claude/workflows/idea-stresstest.js:32-48` fires immediately, aborting before any
fan-out (`{"error":"dynamic_not_approved","fanout_started":false}`).

**Diagnosis status:** Confirmed as a **tool-level limitation**, not a problem on our side —
verified independently 2 times (`confirm_count: 2` in `knowledge/reference/lessons_ledger.md`).
Promotion to instinct requires `confirm_count >= 3`.

**Unproven workaround (needs Test 4 verification → would be the 3rd confirmation):**
Use an inline launcher pattern — `workflow({scriptPath}, realArgsObject)` — that passes `args` as
a real in-process JS object instead of a serialized string, bypassing the stringification entirely.

**Why it matters:** Any workflow script that gates on boolean approval flags inside `args`
(e.g. `rika_dynamic_approved`, `notebooklm_approved`) will silently fail the same way until either
the tool is fixed upstream or every script adopts the inline-launcher workaround.

## Related

- [[knowledge/reference/lessons_ledger.md]] — row: "Phase 1 idea-stresstest.js proof run" (confirm_count: 2)
- [[handoffs/graph_update_20260607_003.md]] — prior graph entry reconfirming this instinct candidate
- [[.claude/workflows/idea-stresstest.js]] — source location (lines 32-48)

## Graph

```yaml
graph_node_type: Instinct
graph_relations:
  - type: derived_from
    target: "[[knowledge/reference/lessons_ledger.md#2026-06-07-phase-1-idea-stresstest-js-proof-run]]"
  - type: relates_to
    target: "[[handoffs/graph_update_20260607_003.md]]"
related_entities: [idea-stresstest.js, Workflow tool, Mira, Minori]
```
