---
type: instinct
status: active
confidence: high
derived_from: ["lessons_ledger.md 2026-06-07 (idea-stresstest.js proof run, confirm_count 3)"]
graph_node_type: Instinct
---
# Run JS Dynamic Workflows through an inline `workflow()` launcher, never the top-level Workflow tool's `args`

**Pattern:** The Workflow tool's top-level `args` parameter arrives inside a script as a
**JSON-encoded string**, not an object — even when passed as a proper JSON object value in the tool
call. So `args.<anyKey>` is `undefined` and boolean approval flags (e.g. `rika_dynamic_approved`)
silently evaluate falsy, tripping any hard guard. Confirmed **3×** (2026-06-07), including a direct
A/B probe:
- Top-level Workflow tool, `args` = real JSON object → child sees `typeof args === "string"`, guard **aborts**.
- Inline `workflow({scriptPath}, obj)` → child sees `typeof args === "object"`, flags resolve correctly, guard **passes**.

**Apply when:** launching ANY JS Dynamic Workflow that reads structured `args` — especially
`idea-stresstest.js` or any script with a runtime precondition guard keyed on an `args.*` flag
(weight=heavy|strategic, `rika_dynamic_approved`, `notebooklm_approved`, etc.).

**Action:** Do **not** invoke the target script directly via the top-level Workflow tool with an
`args` object. Instead launch a tiny parent workflow whose only job is:
`await workflow({ scriptPath: '<abs path to target>.js' }, { idea, weight, rika_dynamic_approved: true, notebooklm_approved: <owner call> })`
— the in-process `workflow()` hook passes a genuine JS object, so the child's guard reads the flags
correctly. (One level of nesting only; the child must not itself call `workflow()`.)

[[workflow-tool-args-string-bug]] · [[lessons_ledger]] · [[decision_ledger]]
