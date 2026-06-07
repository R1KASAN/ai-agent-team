---
title: Clone Quickstart
version: "1.0"
last_updated: "2026-06-08"
---

# Clone Quickstart

Use this checklist when a new person clones the AI Agent Team repo.

## What Works Immediately

After cloning, the repo includes the active operating contract, agents, commands, workflows,
templates, architecture docs, and Level 1 Runtime status files.

The first safe command is always:

```text
/idea-gate [anything]
```

## Requirements

- GitHub access to this private repo.
- Claude Code or a compatible Claude runtime opened from the repo root.
- `bash` and `rg` (`ripgrep`) for local validation scripts.
- No `.env` or local secrets are required for the basic workflow docs and routing rules.

Optional tools such as NotebookLM-py, Obsidian, Graphify, external APIs, deploy targets, and payment
providers are not required for first use. They remain approval-gated and must be configured per
machine if needed.

## First-Time Setup

```bash
git clone https://github.com/R1KASAN/ai-agent-team.git
cd ai-agent-team
bash scripts/clone_ready_check.sh
```

Then open the folder in Claude Code and start with:

```text
/idea-gate [your idea, question, note, link, or task]
```

## Local-Only Files

These files are intentionally not committed:

- `.claude/settings.local.json`
- `.env`
- `.env.*`
- `.serena/`

If a workflow needs local credentials or tool auth, configure them on that machine only. Do not
commit secrets.

## Expected Result

`scripts/clone_ready_check.sh` should report:

```text
Clone-ready check passed.
```

If it fails, fix the missing file/tool first, then run:

```bash
bash scripts/validate_active_alignment.sh
```

## Operating Rules To Remember

- Minori starts every workflow.
- Sequential handoff is the default.
- Level 1 Runtime is status-only; it does not schedule agents or enable fanout.
- Aki/build routes require Expected Gates + Pre-Decide vs Defer before Aki starts.
- Rika-Chan approval is required for strategic, financial, legal, privacy, security, production,
  database, auth, payment, deployment, infrastructure, and dynamic/parallel decisions.
