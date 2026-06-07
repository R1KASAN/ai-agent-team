# Continuation Prompt — Workflow Drift Fix (Task 2)

## Token rules (apply entire session)
- อ่านเฉพาะไฟล์ที่จำเป็น
- ต้องการ context เพิ่ม → ถามชื่อไฟล์ก่อน
- ห้ามสรุปยาว · ตอบเฉพาะสิ่งที่เกี่ยวกับ task
- แสดงเฉพาะ diff หรือไฟล์ที่แก้
- จบงาน → สรุปสั้น 1 บรรทัด: แก้อะไร ทำไม

## Context (already done — do NOT redo)
Task 1 drift check complete. 4 workflow files scanned. Archived-agent references confirmed:

- **governance_check.md** — L4 Gina entry · L26/38/53 Gina steps · L29/39 Kai · L49 "Gina proceeds"
- **llm_wiki_update.md** — L4 Lexi entry · L27/41 Kai · L29/33/42/43 Lexi
- **kaizen_review.md** — L4 Kai entry · L25/36/47/55-57 Kai · L28/37/51 Lexi
- **qa_review.md** — L1 slash mismatch (/codex-test) · L33/48/49/55 Gina · L34/43 Kai
  - L4 Tessa = ACTIVE conditional agent → KEEP, do not change

Replacement map (per CLAUDE.md archive table):
- Gina → Rika-Chan hard gate + `governance/` docs (no active agent)
- Kai → shared token convention (not an agent step)
- Lexi → `llm_wiki/` passive reference (owner/Rika-Chan-driven)
- Tessa → keep (not archived)

## Task 2 — Draft fixes (No-Overwrite Rule)
For each of the 4 files:
1. Create `<file>.draft.md` with corrected agent references per map above.
   - Remove archived agents from `entry_agent`, Flow blocks, Agent Sequence tables, Stop/Embedded sections.
   - Re-sequence steps after removal (governance step → Rika-Chan gate; drop standalone Kai/Lexi steps or fold into convention note).
   - Fix qa_review.md slash_command mismatch if confirmed by owner.
2. Report diff only. STOP.
3. Wait for Rika-Chan approve → then swap draft → live.

## Deferred (do NOT touch without separate approve)
- Orphaned .agents/ dir deletion (44 files)
- caveman skill install
