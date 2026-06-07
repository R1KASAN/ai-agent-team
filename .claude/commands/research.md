---
command: research
description: Optional research shortcut — Mira intake + Nova-V verified deep-source reading (notebooklm-py gated, per-command approval) → knowledge/research note.
skill: research-pipeline
version: "1.0"
entry_agents: "Mira (intake + wiki write) · Nova-V (vault check + notebooklm-py)"
context_budget: small
tier: core_flow
precondition: "notebooklm-py installed + logged in · knowledge/ folder exists"
approval_gate: per-command (notebooklm-py Controlled Operational Use)
output: "knowledge/research/[slug].md · knowledge/README.md index update"
---

# /research — Optional Research Shortcut

`/research` is an optional shortcut. `/idea-gate [source]` remains the canonical front door when the
owner is unsure which route should run.

Privacy-check a source → check existing `knowledge/` → use Nova-V verification → optionally use
NotebookLM-py only after per-command Rika-Chan approval → hand verified output to Mira for
`knowledge/` writing.

## Usage

```
/research [source]
```

**source** รับได้:
- URL บทความ / blog / เว็บ
- YouTube URL (ต้องการ `yt-dlp`)
- Path ไฟล์ PDF
- Path ไฟล์ `.md` ใน `knowledge/`

## Flow Summary

```
Mira (intake + privacy check)
  → Nova-V (knowledge/README.md check + selected source verification)
  → NotebookLM-py only if Nova-V requests and Rika-Chan approves this command
  → Nova-V verifies NotebookLM-derived claims
  → Mira (write knowledge/research/[slug].md + update README index + graph_update)
  → Tsumugi (surface related notes ถ้ามี)
```

## Precondition Check

ก่อนรัน ตรวจว่า:
1. `/opt/homebrew/bin/python3.14 -m notebooklm list` ทำงานได้ (login ยังไม่ expire)
2. `knowledge/research/` folder มีอยู่

## Stop Conditions

- privacy_level = sensitive/restricted → หยุด รอ Rika-Chan
- Source เป็น client PII / confidential / paywalled-login → ปฏิเสธทันที unless Rika-Chan explicitly approves a governed exception
- notebooklm-py login expired → แจ้งให้รัน `notebooklm login` ใหม่
- NotebookLM-py output is never truth; Nova-V must verify before Mira writes.
- Nova-V never writes to `knowledge/`; Mira is the writer.

## Output

`knowledge/research/YYYY-MM-DD-[slug].md` + index line ใน `knowledge/README.md`

> Full pipeline spec: `.claude/skills/research-pipeline/SKILL.md`
