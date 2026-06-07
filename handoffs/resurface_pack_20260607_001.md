---
artifact: resurface_pack
code: rp
produced_by: Tsumugi Second Brain [Ts]
mode: reactive ("มีอะไรเกี่ยวกับ...")
created_at: 2026-06-07
read_order_followed:
  - knowledge/README.md (index scan — match found, stopped here before opening note)
  - knowledge/inbox/workflow-tool-args-string-bug.md (selected note only)
  - handoffs/graph_update_20260607_004.md (graph connection check)
context_budget: small
privacy_level: internal (no owner confirmation required)
---

# Resurface Pack — 20260607-001

[Ts] เจอแล้วค่ะ — มีของที่คุณเซฟไว้เมื่อกี้พอดีเลย 🌙

CURRENT TOPIC: Workflow tool `args` bug — ก่อนเริ่ม "Test 4" ของ Workstream B (ลองวิธีแก้แบบ inline launcher)

SAVED ITEM: "Workflow tool delivers `args` as a JSON-encoded string, not an object — idea-stresstest.js hard-guard abort"
— filed today (2026-06-07) · `knowledge/inbox/workflow-tool-args-string-bug.md`
— graph connection: `[[knowledge/reference/lessons_ledger.md]]` (confirm_count: 2) ·
  `[[handoffs/graph_update_20260607_004.md]]` → cluster `phase1_e2e_proof_20260607`

WHY RELEVANT NOW: คุณกำลังจะรัน Test 4 เพื่อลอง workaround ที่ note นี้พูดถึงพอดี — note บอกไว้ว่า
`args` ที่ Workflow tool ส่งมาเป็น JSON string ไม่ใช่ object จริง ทำให้ `args.rika_dynamic_approved`
อ่านได้ `undefined` แล้ว hard guard ใน `idea-stresstest.js:32-48` ก็ abort ทันที. ยืนยันแล้วว่าเป็น
tool-level limitation 2 ครั้ง (ไม่ใช่ปัญหาฝั่งเรา) — และ note นี้ก็บันทึก "unproven workaround"
ไว้ตรงๆ เลย: ใช้ inline launcher pattern `workflow({scriptPath}, realArgsObject)` เพื่อส่ง `args`
เป็น JS object จริงแทนการ serialize เป็น string. ถ้า Test 4 ของคุณยืนยัน workaround นี้ได้สำเร็จ
นั่นจะเป็น **confirmation ครั้งที่ 3** พอดี — ถึง threshold ที่จะ promote ขึ้นเป็น instinct
(`promotion_threshold: 3`, ปัจจุบัน `confirm_count: 2`).

PAST DECISION: (ไม่พบแถวที่ตรงกันใน decision_ledger สำหรับหัวข้อนี้ — มีแต่ lessons_ledger row
"Phase 1 idea-stresstest.js proof run" ที่อ้างถึงใน note และ graph update)

INSTINCT: "Workflow tool stringifies top-level args — boolean approval flags evaluate falsy
in-script" — `instinct_candidate_workflow_args_typed_launcher` (status: `lesson_staged`,
priority: `high_value_candidate`) — ยังไม่ promote เป็น instinct จริง รอผล Test 4 ยืนยันครั้งที่ 3
ก่อน · path อ้างอิง: `handoffs/graph_update_20260607_004.md`

---

[Ts] แค่เอามาวางไว้ตรงนี้เผื่อมีประโยชน์ตอนรัน Test 4 — ไม่ต้องทำอะไรต่อจาก resurface นี้ค่ะ
ถ้า test ผ่านแล้วอยากให้ Mira อัปเดต confirm_count บอกได้เลยนะคะ 🌙
