# คู่มือใช้งาน AI Agent Team

## ภาพรวมในภาพเดียว

```
คุณ (CEO)
    │
    พิมพ์ command เดียว
    │
    ▼
┌─────────────────────────────────────────────────────┐
│                  MINORI  🚦 (ยาม)                    │
│         รับทุก input → จำแนก → ส่งทีมที่ใช่         │
└──────────────┬──────────────────────────────────────┘
               │
    ┌──────────┼──────────────┬───────────────┐
    ▼          ▼              ▼               ▼
💡 ไอเดีย  📰 ข่าว/trend  🔍 วิจัย     📚 เซฟ/หา
    │          │              │               │
    ▼          ▼              ▼               ▼
Yuki          Hikari        Mira            Mira
Nova-V  →  knowledge/      Nova-V   →   knowledge/
Sora                     → Tsumugi recall (wiki สะสม)
Bumi
Poom
    │
    ⛔ คุณ approve
    │
    ▼
Aki → Coda → Kyuuei
    │
    ⛔ คุณ approve
    │
    ▼
  🚀 Ship
```

**กฎเดียวที่ต้องจำ:** คุณทำแค่ "พิมพ์" กับ "approve" — AI ทำที่เหลือเอง

---

## คิดว่าระบบนี้คืออะไร

> **คุณคือ CEO บริษัท มีทีม 14 คนที่ทำงานให้**
>
> คุณพูดว่า *"อยากทำแอพนับแคล"*
> ทีมประชุมเอง วิจัยเอง เขียน brief เอง เขียนโค้ดเอง
> มาถามคุณแค่ 2 ครั้ง — "build ไหม?" และ "ship ไหม?"
> คุณตอบ "ทำเลย" → ทีมทำจนจบ

---

## ตอนนี้ระบบเป็น Multi-Agent Orchestrator แบบไหน

ระบบนี้เป็น **multi-agent orchestrator แบบ hierarchical + sequential-by-default**:

- **Minori** เป็น orchestrator กลาง: รับ input ทุกอย่าง, จำแนกงาน, เขียน `workflow_plan.md`, แล้วค่อย route
- Agent แต่ละคนมีหน้าที่เฉพาะ: Yuki challenge, Nova-V ตรวจหลักฐาน, Poom เขียน PRD, Aki แปลงเป็น task packet, Coda build, Kyuuei test
- ค่าเริ่มต้นคือ **ทำทีละลำดับ** ไม่ fan-out เอง
- งาน `dynamic_workflow` หรือ parallel/fanout ใช้ได้เฉพาะเมื่อ Rika-Chan approve ตาม gate

สรุป: เป็น multi-agent orchestrator แล้ว แต่ไม่ใช่ระบบ parallel อัตโนมัติเต็มรูปแบบ ระบบนี้ตั้งใจให้ปลอดภัยกว่าโดยมี artifact gate และ approval gate คั่นทุกช่วงสำคัญ

ดูแผนภาพ Mermaid แบบเต็มได้ที่ `AI_AGENT_TEAM_ARCHITECTURE.md`

---

## Commands ทั้งหมด — ใช้เมื่อไหร่

**ถ้าไม่แน่ใจ ใช้ `/idea-gate [อะไรก็ได้]` เสมอ** — นี่คือ front door หลักของระบบ.
คำสั่งอื่นเป็น shortcut สำหรับเวลาที่คุณรู้ route แล้วเท่านั้น.

| รู้สึกแบบนี้ | พิมพ์ |
|---|---|
| มีไอเดีย อยากทำ | `/idea [ไอเดีย]` |
| มีไอเดีย ยังไม่แน่ใจ อยากถกก่อน | `/idea-pipeline [ไอเดีย]` |
| เจอบทความ/PDF/YouTube น่าสนใจ | `/research [link]` |
| อยากเซฟความคิดไว้ | `/memory [note]` |
| อยากหาของที่เคยเซฟ | `/recall [topic]` |
| อยากรู้ข่าว/trend วันนี้ | `/scout` |
| เจอลิงก์น่าสนใจ อยากให้สรุป + คิดไอเดียให้ | `/scout [link]` |
| ไม่รู้จะทำอะไรดี | `/next` |
| ไม่รู้ว่าควรใช้ command อะไร | `/idea-gate [อะไรก็ได้]` |
| มี brief/task พร้อมแล้ว อยากให้ build | `/build [task]` |

---

## Workflow จริง — วันในชีวิต

```
เช้า          → /scout          "มีข่าวอะไรน่าสนใจ?"
เจอลิงก์ ครุ่นคิดไอเดีย → /scout [url]   "สรุปลิงก์นี้ให้ + คิดไอเดียโปรดักต์ 2-3 มุม (เร็ว, ไม่ verify)"
เจอบทความ ต้องวิเคราะห์ลึก/เก็บถาวร → /research [url] "ตรวจสอบหลักฐาน + เซฟลง knowledge/ (ลึกกว่า, ผ่าน Nova-V)"
มีไอเดีย      → /idea [ไอเดีย]  "ทำจนจบเลย"
ลืมอะไร      → /recall [topic]  "หาของที่เคยเซฟ"
```

> **`/scout [url]` vs `/research [url]` ต่างกันตรงไหน?**
> `/scout [url]` = เร็ว, สรุป+ไอเดียทันที, log ไว้เป็น lead รอตัดสินใจ (ยังไม่ verify)
> `/research [url]` = ลึก, Nova-V ตรวจสอบหลักฐาน, เก็บถาวรใน `knowledge/research/` แบบมี governance metadata เต็ม

---

## ทีม 14 คน — แต่ละคนทำอะไร ใช้อะไร

### 🚦 Minori — ยามประตู
> *"ก่อนใครเริ่มทำงาน ต้องผ่านฉันก่อน"*

รับ input ทุกอย่าง → อ่านว่าคืออะไร → เขียนแผนงาน → ส่งให้คนที่ใช่
ถ้าเส้นทางมีโอกาสไปถึง Aki/build, Minori ต้องเพิ่ม **Expected Gates + Pre-Decide vs Defer** ลงใน `workflow_plan.md` ก่อนเสมอ
**เครื่องมือ:** อ่าน workflow files เท่านั้น ไม่มี external tool
**output:** `workflow_plan.md` — แผนที่บอกว่าใครทำอะไรต่อ

---

### 🔥 Yuki — นักโต้แย้ง
> *"ฉันจะหาทุกเหตุผลที่ไอเดียนี้จะล้มเหลว"*

ถามคำถาม Socratic — "ทำไมคนถึงจ่าย?", "มีคนทำแล้วไหม?", "สมมติฐานอะไรที่เสี่ยงสุด?"
ไม่ได้โจมตีเพื่อทำลาย แต่โจมตีเพื่อ **ทำให้ไอเดียแข็งแกร่งขึ้น**
**เครื่องมือ:** ไม่มี external tool — ใช้แค่ logic และ Socratic method
**output:** `idea_challenge_brief.md` — รายการสมมติฐานเสี่ยงที่ต้องพิสูจน์

---

### 🔬 Nova-V — นักสืบ + ผู้พิพากษา (2 คนรวมเป็น 1)
> *"ฉันหาหลักฐาน แล้วตัดสินเองว่าน่าเชื่อแค่ไหน"*

ค้นหาหลักฐานจากโลกจริง → ตรวจว่าหลักฐานนั้น **สนับสนุนหรือหักล้าง** claim จริงๆ
ถ้าหลักฐานอ่อน → วนหาใหม่ได้อีก 1 รอบ (max 2 รอบ)
**เครื่องมือ:**
- WebSearch + WebFetch (ค้นเว็บ)
- `knowledge/README.md` (เช็คก่อนว่าเคยวิจัยเรื่องนี้แล้วไหม)
- **NotebookLM-py** (Nova-V เท่านั้น; ใช้ได้เฉพาะ source ลึกที่ Rika-Chan approve ต่อ command)
**output:** `verified_evidence_pack.md` — หลักฐานพร้อม label: FACT / ASSUMPTION / UNSUPPORTED

---

### 🌍 Sora — นักวางกลยุทธ์ระยะยาว
> *"ไอเดียนี้มีอนาคต 5 ปีไหม หรือแค่กำลัง 'ปรับปรุง CD player' ในยุค Spotify?"*

มองว่าตลาดกำลังเปลี่ยนไปทางไหน → ไอเดียนี้อยู่ฝั่งอนาคตหรือฝั่งที่กำลังตาย
ระบุว่า "moat" คืออะไร — สิ่งที่ทำให้คู่แข่งเลียนแบบยาก
**เครื่องมือ:** อ่าน evidence pack → วิเคราะห์ด้วย strategic frameworks
**output:** `strategic_lens.md` — bet 3-5 ปี + moat + สัญญาณอันตราย

---

### 💰 Bumi — นักวิเคราะห์ธุรกิจ
> *"คนจะจ่ายเงินจริงไหม และมากพอที่จะอยู่รอดไหม?"*

ประเมิน: กลุ่มเป้าหมายคือใคร, เจ็บปวดแค่ไหน, ยินดีจ่ายเท่าไหร่, รายได้เข้ามายังไง
**เครื่องมือ:** อ่าน strategic lens → วิเคราะห์ business model
**output:** `business_analysis_brief.md` — WTP signal + revenue path + ความเสี่ยงหลัก

---

### 📋 Poom — Product Manager
> *"เอาทุกอย่างมาเขียนเป็น brief ที่ build ได้จริง"*

รวมผลจากทุกคน → เขียน Product Opportunity Brief → ถ้า approve แล้วเขียน PRD + MVP scope
**เครื่องมือ:** synthesis จาก business brief → เขียน document
**output:** `product_opportunity_brief.md` → `prd.md` + `mvp_scope.md`

---

### ⛔ Rika-Chan — คุณเอง (Decision Gate)
> *"ฉันไม่ทำงาน ฉันแค่ตัดสินใจ"*

จุด checkpoint ที่ AI **ต้องหยุดและรอคำตอบจากคุณ** ก่อนทำต่อ
ทำหน้าที่ป้องกันไม่ให้ AI ตัดสินใจเรื่องสำคัญแทนคุณ
**ไม่มีเครื่องมือ** — แค่ approve / stop / hold

---

### 🗂️ Aki — สถาปนิกงาน
> *"เอา PRD มาแปลงเป็นรายการงานที่ programmer เข้าใจ"*

อ่าน PRD → เขียน task packet บอกว่าต้องแก้ไฟล์ไหน ทำอะไรบ้าง เทสยังไง
ก่อน Aki เริ่ม ต้องมี Gate Scope Pre-Clarification ใน `workflow_plan.md` แล้ว ถ้า gate เรื่อง auth/payment/database/infra/paid API/hosting/privacy ยังไม่ถูก mark เป็น `Pre-Decide` หรือ `Defer`, Aki ต้องหยุด
**เครื่องมือ:** Read files → วิเคราะห์โค้ดที่มีอยู่
**output:** `codex_task_packet.md` — รายการงานพร้อม test plan

---

### 💻 Coda — programmer
> *"ฉันเขียนเฉพาะสิ่งที่ task packet บอก ไม่เพิ่ม ไม่ลด"*

เขียนโค้ดตาม spec ที่ Aki กำหนด อย่างแม่นยำ ไม่แตะโค้ดที่ไม่เกี่ยว
**เครื่องมือ:** Read + Edit + Write files + Bash
**output:** `build_report.md` + โค้ดที่เขียนจริง

---

### 🧪 Kyuuei — QA + Debugger (2 คนรวมเป็น 1)
> *"ฉันเทสจนผ่าน ถ้าไม่ผ่านฉัน debug เองแล้วเทสใหม่"*

เขียน test → รัน test → ถ้า fail หา root cause แก้ → รัน test อีกรอบ (loop จนผ่าน)
**เครื่องมือ:** Bash (รัน test) + Read/Edit (แก้บัค)
**output:** `test_report.md` — ผลเทสพร้อม coverage

---

### 👁️ Tessa — UX Inspector (เรียกเฉพาะถ้ามี UI)
> *"โค้ดผ่านเทสแล้ว แต่คนใช้จริงงงไหม?"*

ตรวจ user flow ว่า UX สมเหตุสมผลไหม edge case ครบไหม
**เครื่องมือ:** อ่าน build report + ตรวจ acceptance criteria
**output:** `qa_ux_report.md`

---

### 📚 Mira — บรรณารักษ์
> *"ทุกอย่างที่เข้ามาต้องถูก tag ก่อน แล้วเก็บให้ถูกที่"*

รับ note/link/ไฟล์ → ติด metadata (หัวข้อ, วันที่, ความเป็นส่วนตัว) → เขียนลง `knowledge/` wiki
**เครื่องมือ:** Write files → `knowledge/inbox/` + `knowledge/README.md` index
**output:** `knowledge_intake_note.md` + note ใน `knowledge/`

---

### 🧠 Tsumugi — ความจำระยะยาว
> *"คุณลืม แต่ฉันไม่ลืม — ถ้าเรื่องนี้เกี่ยวกับอะไรที่เคยเซฟไว้ ฉันจะบอก"*

เมื่อคุณทำงานเรื่องอะไร → Tsumugi scan `knowledge/` ดูว่ามีของเก่าที่เกี่ยวข้องไหม → surface ให้เบาๆ
**เครื่องมือ:** อ่าน `knowledge/README.md` ก่อน (เร็ว) → fallback Obsidian graph
**output:** `resurface_pack.md` — "คุณเคยเซฟเรื่องนี้ไว้ เมื่อ X — อยากดูไหม?"

---

### 📰 Hikari — นักข่าว (2 โหมด)
> *"ทุกเช้าฉันส่อง 3 signal ที่น่าสนใจที่สุดสำหรับ product ของคุณ — หรือถ้าคุณโยนลิงก์มา ฉันสรุป + คิดไอเดียให้เลย"*

**โหมด 1 — Discovery (`/scout`):** ค้นหาข่าว/trend ใหม่เอง → กรองเฉพาะที่เกี่ยวกับ space ของคุณ → ส่อง 3 signals
**โหมด 2 — Product Scout (`/scout [link]`):** วางลิงก์ที่คุณเจอเอง → Hikari ดึงเนื้อหามาสรุป (3-5 bullet) + คิด "โอกาสสร้างโปรดักต์" ให้ 2-3 มุม พร้อม confidence — ลิงก์ที่อ่อนไหว (สุขภาพ/การเงิน/กฎหมาย) จะหยุดและถามคุณก่อนเสมอ

ทั้งสองโหมด **auto-append แถวลงใน `logs/signal_log.md` ให้เอง** (เสนอ Decision ให้ด้วย คุณแค่ accept/แก้)
**เครื่องมือ:** WebSearch + WebFetch
**output:** `daily_signal_brief.md` (โหมด 1 — 3 signals) · `product_scout_brief.md` (โหมด 2 — สรุป + ไอเดียจากลิงก์)

---

### ⚡ Ichika — โค้ชชีวิต
> *"บอกฉันทีเดียว — ทำอะไรก่อนดีที่สุดตอนนี้?"*

ดู context ทั้งหมดที่มี → เสนอ **1 action เดียว** ที่ชัดที่สุด ไม่ให้ list ยาว
**เครื่องมือ:** อ่าน project_state + context_pack
**output:** 1 ประโยค — next action

---

## ยิ่งใช้ยิ่งฉลาด

```
ทุกอย่างที่บันทึกไป → เก็บลง knowledge/
                              ↓
              ครั้งหน้า AI อ่านของเดิมก่อนวิจัยใหม่
              ครั้งต่อไป Tsumugi surface ของเก่ามาให้เอง
              ยิ่งนาน → AI รู้จักคุณมากขึ้นเรื่อยๆ
```

> เหมือนพนักงานที่ทำงานกับคุณนาน — ไม่ต้องอธิบายซ้ำ

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
ปกติในฐานะ optional shortcuts/utilities** ถ้ารู้อยู่แล้วว่าต้องการอะไร — `/idea-gate` คือ canonical
front door สำหรับตอน "เอาไปคิดให้หน่อย"

### Minori เลือก "ขนาดงาน" ให้อัตโนมัติ (ประหยัด token)

| ขนาด | ตัวอย่าง | ทีมทำยังไง | ราคา |
|------|---------|-----------|------|
| จิ๋ว/เล็ก | หาของที่เซฟ, `/next`, scout | 1 คนทำ | ถูกสุด |
| กลาง | validate 1 ไอเดียที่ชัด | pipeline ปกติ (`/idea`) | กลาง |
| ใหญ่/ยุทธศาสตร์ | ไอเดียที่ต้องเช็คหลักฐานหนัก, pivot, kill/bet | **Dynamic Workflow** (`idea-stresstest`) | แพง → **ต้อง approve ก่อน** |

**กฎสำคัญ:** งานใหญ่ (Dynamic Workflow) จะ **ไม่เริ่มเอง** — Minori เขียนแผน + `approval_request.md`
แล้ว **หยุดรอคุณ approve** `dynamic` budget ก่อนเสมอ งานเล็กไม่มีวันลากไปทางแพง

### ก่อนเข้า Aki ต้องมี Expected Gates + Pre-Decide vs Defer

ถ้า workflow มีโอกาสไปถึง build หรือ Aki, `workflow_plan.md` ต้องมี:

- `expected_gates` — gate ที่คาดว่าจะเจอ เช่น auth, payment, database, infra, hosting, paid API, privacy
- `gate_decisions` — แต่ละ gate ต้องถูก mark เป็น `Pre-Decide` หรือ `Defer`

ความหมาย:

- `Pre-Decide` = Rika-Chan ตัดสินใจก่อน Aki เริ่ม
- `Defer` = ยังไม่ตัดสินตอนนี้ได้ แต่ต้องระบุ checkpoint เช่น `Coda proposes options + Rika-Chan approves before implementation/spend/deploy`

ถ้า gate ถูกตรวจพบแต่ยังไม่ clarified → Aki ห้ามเริ่ม

### ยิ่งใช้ยิ่งฉลาด (memory loop)

ทุกครั้งที่คุณตัดสินใจ (approve/stop) → บันทึกลง `knowledge/reference/decision_ledger.md`
บทเรียนที่เจอซ้ำ ≥ 3 ครั้ง → กลายเป็น "instinct" ใน `knowledge/instincts/` ที่ Minori อ่านก่อนจัดงาน
และก่อนงานใหญ่ Tsumugi จะ **ดึงของเก่าที่เกี่ยวข้องมาให้เอง** (จาก knowledge/ + Obsidian graph)
— เฉพาะที่เกี่ยวกับงานนั้น ไม่เท condition ทั้งหมด

> Backend: **Obsidian** = graph/`[[backlinks]]` · **NotebookLM-py** = อ่าน source ลึก (Nova-V เท่านั้น,
> ขอ approve ทุกครั้ง; ไม่ใช่ memory layer และไม่ใช่ truth source) · **Graphify** = knowledge graph
> (Mira สร้าง) — ใช้แบบ Just-in-Time ไม่ load ทั้งก้อน
