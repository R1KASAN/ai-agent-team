---
version: "1.0"
maintained_by: mira_memory_librarian
status: active
last_updated: "2026-06-07"
---

# Knowledge Agent Rules

## Canonical Stack

```text
Raw input -> Mira tag/privacy -> knowledge/ LLM Wiki -> Graphify graph_update -> Obsidian backlinks/graph -> Tsumugi recall -> Nova-V uses NotebookLM-py only for approved deep source reading
```

## Ownership

| Layer | Owner | Allowed Behavior |
|-------|-------|------------------|
| Raw input intake | Mira | Tag, classify, privacy-check, and log source metadata |
| `knowledge/` wiki | Mira | Normal writer; creates and updates governed notes |
| Graphify `graph_update` | Mira | Emits entity/relation/cluster updates from governed notes |
| Obsidian backlinks/graph | Mira writes, Tsumugi reads | Backlinks support recall; never used as final evidence |
| Recall | Tsumugi | Read-only: `knowledge/README.md` first, selected notes second, graph/backlinks fallback |
| Evidence/deep source reading | Nova-V | Reads selected notes; verifies sources; may use NotebookLM-py only when approved |
| NotebookLM-py | Nova-V only | Per-command Rika-Chan approval; not memory; not truth |

## Read / Write Rules

- Mira is the only normal writer to `knowledge/`.
- Tsumugi is read-only and never writes notes, logs, or graph updates.
- Nova-V may read `knowledge/README.md` and selected relevant notes only.
- Nova-V never writes to `knowledge/`; verified research returns to Mira for writing.
- No agent may load the full vault. Start from `knowledge/README.md`, then load only targeted notes.
- Sensitive or restricted material must not be written, surfaced, graphed, or sent to tools without Rika-Chan approval.

## Privacy Levels

| Level | Meaning | Rule |
|-------|---------|------|
| `public` | Public source or safe non-sensitive note | May enter wiki/graph after metadata tagging |
| `internal` | Owner context, non-public but low risk | May enter wiki/graph if no PII/client-sensitive data |
| `sensitive` | Client, business-sensitive, private, or commercially sensitive | Stop for Rika-Chan before wiki/graph write |
| `restricted` | PII, secrets, tokens, credentials, private identity data | Hard stop; no downstream flow without explicit approval |

## NotebookLM-py Rules

- NotebookLM-py is Nova-V-only.
- Install, login, auth, add-source, query, export, or any execution requires per-command Rika-Chan approval.
- NotebookLM-py output is never treated as truth.
- Nova-V must verify NotebookLM-derived claims against approved source material.
- Mira writes `knowledge/research/[slug].md` only after Nova-V verification.
- Mira emits `graph_update.md` after the verified research note is written.
- If NotebookLM-py is unavailable, expired, or blocked, use direct source reading, prepared source packs, or manual notes.

## Graph Mapping

Mira maps note metadata into graph updates:

- `type` -> knowledge note category
- `graph_node_type` -> graph node category
- `related_entities` -> candidate nodes
- `graph_relations` -> candidate edges
- `privacy_level` -> recall and downstream access filter

Allowed node types: `Idea`, `Decision`, `Instinct`, `Source`, `Research`, `Spec`, `Risk`, `Product`, `Agent`, `Workflow`.

Allowed edge types: `relates_to`, `derived_from`, `supports`, `contradicts`, `supersedes`,
`owned_by`, `produced_by`, `consumed_by`, `blocks`, `mitigates`.

## Stop Conditions

- Full-vault request -> refuse and scope to index + selected notes.
- PII/secrets/client-sensitive data -> stop for Rika-Chan.
- NotebookLM-py requested without approval -> stop for Rika-Chan.
- Unverified source claim requested for downstream decision -> route to Nova-V.
