---
name: grill-with-docs
version: "1.0"
trust_status: Core
team: claude
invoked_by: nova_v
input: claim set + supporting documents or sources
output: document-grounded challenge (embedded in verified_evidence_pack.md)
---

# Grill With Docs Skill

Challenges claims by cross-referencing them against the provided documents. Surfaces gaps where documents do not support claims.

## Protocol

1. For each claim, locate the passage(s) in the provided documents that are cited as support.
2. Assess fit: does the passage actually support the claim, or is it tangential?
3. Label each claim-document pair:
   - `supported` — passage directly backs the claim
   - `partial` — passage is related but does not fully support
   - `unsupported` — no passage found; claim is ungrounded
   - `contradicted` — a passage in the same document contradicts the claim
4. List all `unsupported` and `contradicted` pairs as findings.

## Forbidden

- Do not infer support — require explicit textual backing.
- Do not mark a claim `supported` from memory alone; source passage must be referenced.
- No shell execution. No external calls.
