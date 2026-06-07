---
version: "1.0"
maintained_by: mira_memory_librarian
wiki_layer: karpathy
last_updated: "2026-06-06"
---

# Knowledge Wiki

Claude-queryable wiki layer. Plain markdown — no external tool required.

Maintained by **Mira** on every `/memory` run. Read by **Tsumugi** and Claude Code directly.

---

## Folders

| Folder | What goes here | Written by |
|--------|----------------|-----------|
| `inbox/` | Raw captures before filing — links, notes, screenshots | Mira (on `/memory`) |
| `ideas/` | Product opportunity briefs approved by Rika-Chan | Mira (after Poom → Rika-Chan gate) |
| `research/` | Verified evidence packs from Nova-V | Mira (after `/evidence-crosscheck`) |
| `market/` | Daily signals from Hikari | Mira (after `/scout`) |
| `reference/` | General reference — frameworks, definitions, how-tos | Mira (manual or on `/memory`) |

---

## Note Index

> Mira appends one line per note when written.
> Format: `- [title](folder/slug.md) — summary · tags · date`

<!-- INDEX START -->
<!-- INDEX END -->

---

## How to Query

Ask Claude Code in natural language:
- "สรุปทุกอย่างใน knowledge/research/"
- "มี note เกี่ยวกับ [topic] ไหม?"
- "เชื่อม ideas ทั้งหมดกับ market signals ที่เกี่ยวข้อง"

---

## Template

All notes follow `_templates/note.md` — title · summary · tags · source · content · [[related]].
The `summary` field (one line) allows Claude to filter relevance without reading the full note.

---

## Rules

- **Mira writes, Tsumugi reads** — no other agent writes here directly
- `privacy_level: sensitive / restricted` items → do not land in `inbox/` without Rika-Chan approval
- One note per distinct concept/source — avoid sprawling notes
- Update `summary` and `updated` on every edit
- `[[related]]` links are Obsidian-compatible — wiki stays in sync with the graph layer
