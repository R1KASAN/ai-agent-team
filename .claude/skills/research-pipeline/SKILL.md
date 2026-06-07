---
name: research-pipeline
slash_command: /research
version: "1.0"
created: "2026-06-06"
status: Trial
trust_gate: controlled_operational_use
owner: Nova-V (notebooklm-py step) · Mira (intake + wiki write)
approval_gate: per-command (notebooklm-py Controlled Operational Use)
notebooklm_binary: "/opt/homebrew/bin/python3.14 -m notebooklm"
---

# Skill: research-pipeline (`/research`)

Optional research shortcut. `/idea-gate [source]` remains the canonical front door when the route is
unclear. This pipeline privacy-checks a source, checks existing knowledge, verifies claims with
Nova-V, and uses NotebookLM-py only after per-command Rika-Chan approval.

## Trigger

`/research [source]`

source = URL · PDF path · YouTube URL · `.md` file path

## When to Use

- ต้องการวิเคราะห์ source ที่ privacy-cleared อย่างลึก โดยประหยัด token Claude
- ต้องการเพิ่ม knowledge ลง wiki ให้พร้อมสำหรับ Tsumugi resurface และ Nova-V vault check

## When NOT to Use

- Source มี `privacy_level: sensitive / restricted` — ต้องผ่าน Rika-Chan gate ก่อน
- Source เป็น client PII, credentials, confidential, paywalled-login content
- ต้องการ real-time data (NotebookLM ไม่ใช่ search engine)

---

## Pipeline Flow

```
/research [source]
  │
  ├─ Step 1: INTAKE (Mira)
  │   • Detect source type (URL / PDF / YouTube / Markdown)
  │   • Tag: title, topic, privacy_level, related_project
  │   • STOP if privacy_level = sensitive/restricted → Rika-Chan approval required
  │
  ├─ Step 2: PRE-PROCESS (source routing)
  │   • URL/article  → fetch text content
  │   • PDF          → use file path directly
  │   • YouTube URL  → yt-dlp --skip-download --write-auto-subs → extract transcript text
  │   • .md file     → use file path directly
  │
  ├─ Step 3: VAULT INDEX CHECK (Nova-V)
  │   • Read knowledge/README.md index
  │   • If topic already covered → surface existing note, ask if still want to re-research
  │   • If not covered → proceed
  │
  ├─ Step 4: OPTIONAL NOTEBOOKLM-PY MISSION *** per-command Rika-Chan approval gate ***
  │   • Nova-V requests approval with source scope and mission goal
  │   • notebooklm create/source add/ask only after approval
  │   • structured output goes back to Nova-V
  │
  ├─ Step 5: NOVA-V VERIFICATION
  │   • Verify NotebookLM-derived claims against approved source material
  │   • Produce verified_evidence_pack.md
  │   • Update logs/source_log.md before downstream use
  │
  └─ Step 6: WIKI + GRAPH WRITE (Mira)
      • เขียน knowledge/research/[YYYY-MM-DD]-[slug].md จาก template
      • Append index line → knowledge/README.md
      • Emit graph_update.md
      • Tsumugi can later recall through knowledge/ + graph metadata
```

---

## Source Type Routing

| Input | Detection | Pre-process |
|-------|-----------|-------------|
| `https://youtube.com/...` | URL contains youtube.com / youtu.be | `yt-dlp --skip-download --write-auto-subs --sub-lang th,en -o /tmp/yt_%(id)s %(url)s` → read `.vtt` |
| `https://...` (article/blog) | HTTP URL, non-YouTube | WebFetch → extract main text |
| `/path/to/file.pdf` | ends with .pdf | pass path directly to notebooklm source add |
| `/path/to/file.md` | ends with .md | pass path directly |
| `knowledge/...` | relative path starts with knowledge/ | expand to absolute path |

---

## notebooklm-py Commands Used Only After Approval

```bash
# binary
/opt/homebrew/bin/python3.14 -m notebooklm

# create notebook for this research session
notebooklm create "[research title]"

# add source (URL or file path)
notebooklm source add [source]

# query
notebooklm ask "สรุปประเด็นหลัก, หลักฐานสำคัญ, gaps, และสิ่งที่น่านำไปต่อยอด"

# list to verify
notebooklm list
```

> WARNING: byte-count mismatch จาก notebooklm.rpc.decoder เป็น known issue — tolerated (exit 0)

---

## Output Note Format

Saved by Mira to `knowledge/research/[YYYY-MM-DD]-[slug].md` after Nova-V verification:

```markdown
---
title: "[source title]"
summary: "[one-line summary]"
tags: [topic-tags]
source_url: "[original source]"
created: "[YYYY-MM-DD]"
updated: "[YYYY-MM-DD]"
privacy_level: public
type: research
status: verified
owner: mira_memory_librarian
source_type: ""
source_url_or_path: "[original source]"
confidence: ""
related_entities: []
graph_node_type: Research
graph_relations: []
last_verified_at: "[YYYY-MM-DD]"
related_project: ""
notebooklm_mission_ref: ""
---

# [title]

> [summary]

## Key Findings

[Nova-V verified findings, not raw NotebookLM output]

## Gaps

[gap statements]

## Related

- [[note-slug]]
```

---

## Approval Gates

- **Step 1:** privacy_level = sensitive/restricted → STOP → Rika-Chan
- **Step 4:** notebooklm-py every command → per-command Rika-Chan approval (Controlled Operational Use)
- YouTube source → yt-dlp ต้อง install (`brew install yt-dlp`)

## Constraints

- ห้ามใช้ใน automated loop (notebooklm-py ไม่ใช่ Core)
- 1 notebook ต่อ 1 research session (ไม่ reuse notebook ข้าม topics)
- NotebookLM-py output ไม่ใช่ truth → ต้อง verify ผ่าน Nova-V ก่อนใช้เป็น evidence
- Nova-V never writes to `knowledge/`; Mira writes after verification
- If NotebookLM-py is unavailable or login expired, fallback to direct source reading, prepared source pack, or manual notes
