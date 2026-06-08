# Runtime Artifacts

This directory holds lightweight runtime artifacts that are safe to persist in the repo.

- `queue/` — Telegram Gateway v1 queue items, one file per request.

Runtime files are artifact pointers and compact payloads only. They are not a scheduler, not a memory
layer, and not a place for full chat history, source bodies, secrets, tokens, or PII.
