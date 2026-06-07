# HOW_TO_USE — Phase 1 append section (DRAFT)

> **Instruction for owner:** This is a draft of ONE new section to **append** to the existing
> `HOW_TO_USE.md` (after the "Commands ทั้งหมด" table). It does not replace any existing content.
> Approve → append → delete this draft.

---

## พิมพ์ `/idea-gate` อย่างเดียวก็พอ (ประตูเดียว)

ไม่แน่ใจว่าจะใช้ command ไหน? **พิมพ์ `/idea-gate [อะไรก็ได้]`** — Minori อ่านเอง แล้วจัดการให้

```
/idea-gate เคยเซฟอะไรเรื่อง pricing ไหม      → หา (recall)
/idea-gate อยากทำแอพนับแคลอรี่               → validate ไอเดีย
/idea-gate ควร pivot ไป B2B ไหม              → งานใหญ่ → ขอ approve ก่อน
/idea-gate มีข่าว AI อะไรน่าสนใจ             → scout
```

Command เดิม (`/scout`, `/recall`, `/next`, `/idea`, `/memory`, `/research`, `/build`) **ยังใช้ได้
ปกติ** ถ้ารู้อยู่แล้วว่าต้องการอะไร — `/idea-gate` ไว้สำหรับตอน "เอาไปคิดให้หน่อย"

### Minori เลือก "ขนาดงาน" ให้อัตโนมัติ (ประหยัด token)

| ขนาด | ตัวอย่าง | ทีมทำยังไง | ราคา |
|------|---------|-----------|------|
| จิ๋ว/เล็ก | หาของที่เซฟ, `/next`, scout | 1 คนทำ | ถูกสุด |
| กลาง | validate 1 ไอเดียที่ชัด | pipeline ปกติ (`/idea`) | กลาง |
| ใหญ่/ยุทธศาสตร์ | ไอเดียที่ต้องเช็คหลักฐานหนัก, pivot, kill/bet | **Dynamic Workflow** (`idea-stresstest`) | แพง → **ต้อง approve ก่อน** |

**กฎสำคัญ:** งานใหญ่ (Dynamic Workflow) จะ **ไม่เริ่มเอง** — Minori เขียนแผน + `approval_request.md`
แล้ว **หยุดรอคุณ approve** `dynamic` budget ก่อนเสมอ งานเล็กไม่มีวันลากไปทางแพง

### ยิ่งใช้ยิ่งฉลาด (memory loop)

ทุกครั้งที่คุณตัดสินใจ (approve/stop) → บันทึกลง `knowledge/reference/decision_ledger.md`
บทเรียนที่เจอซ้ำ ≥ 3 ครั้ง → กลายเป็น "instinct" ใน `knowledge/instincts/` ที่ Minori อ่านก่อนจัดงาน
และก่อนงานใหญ่ Tsumugi จะ **ดึงของเก่าที่เกี่ยวข้องมาให้เอง** (จาก knowledge/ + Obsidian graph)
— เฉพาะที่เกี่ยวกับงานนั้น ไม่เท condition ทั้งหมด

> Backend: **Obsidian** = graph/`[[backlinks]]` · **NotebookLM-py** = อ่าน source ลึก (Nova-V เท่านั้น,
> ขอ approve ทุกครั้ง) · **Graphify** = knowledge graph (Mira สร้าง) — ใช้แบบ Just-in-Time ไม่ load ทั้งก้อน
