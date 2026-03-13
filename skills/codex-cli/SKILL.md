---
name: codex-cli
description: "Use this skill when the user wants to install, set up, update, configure, manage, or troubleshoot the OpenAI Codex CLI tool. Triggers: install codex, update codex cli, codex command not found, set OPENAI_API_KEY, configure AGENTS.md, codex auth login, set approval mode, run codex non-interactively, pipe to codex, codex won't start, change the model in codex, or any hands-on operational task with the codex CLI binary. For documentation lookups use codex-cli-docs."
---

# OpenAI Coding CLI

Operational skill for installing, configuring, managing, and troubleshooting the
coding CLI binary. For deep documentation lookups, use the companion documentation skill.

---

## Intent Router

| Task | Action |
| --- | --- |
| Install / first run | See [Install](#install) below |
| Update | See [Update](#update) below |
| Auth / API key setup | See [Auth](#auth) below |
| Configure AGENTS.md | See [Configuration](#configuration) below |
| Approval modes | See [Approval Modes](#approval-modes) below |
| Non-interactive / scripting | See [Scripting](#scripting) below |
| Troubleshooting | See [Troubleshooting](#troubleshooting) below |
| Advanced / docs lookup | Use the companion documentation skill |

---

## Install

```bash
# npm (global install) — requires Node.js 18+
npm install -g @openai/codex

# Homebrew (macOS/Linux)
brew install codex
```

First run:

```bash
cd your-project
codex "describe what this codebase does"
```

System requirements: Node.js 18+, macOS/Linux or WSL on Windows.

---

## Update

```bash
# npm
npm update -g @openai/codex

# Homebrew
brew upgrade codex

# Check version
codex --version
```

Release notes: use the companion documentation skill for the changelog URL.

---

## Auth

### ChatGPT account (Plus/Pro/Team/Edu/Enterprise)

```bash
codex auth login    # opens browser — sign in with OpenAI account
codex auth logout
codex auth status
```

### API key

```bash
export OPENAI_API_KEY=sk-...        # set in shell profile for persistence
codex --api-key sk-... "your task"  # pass per-invocation
```

Store the key in your shell profile to persist across sessions:

```bash
echo 'export OPENAI_API_KEY=sk-...' >> ~/.bashrc
source ~/.bashrc
```

---

## Configuration

### AGENTS.md

`AGENTS.md` at the project root is read at the start of every session. Use it for
project-specific instructions, coding conventions, and build commands.

```markdown
# My Project

## Build & Test
- Build: `npm run build`
- Test: `npm test`

## Conventions
- TypeScript strict mode
- All new functions need JSDoc comments
```

For the full AGENTS.md spec, use the companion documentation skill.

### Config file

Pass a custom config path with `--config <path>`. For the full config schema, use
the companion documentation skill.

---

## Approval Modes

```bash
codex "task"                              # suggest (default): proposes, asks before applying
codex --approval-mode auto "task"         # auto-approves safe file edits; prompts for shell commands
codex --approval-mode full-auto "task"    # applies all changes and runs commands without asking
```

| Mode | Safe for | Caution |
| --- | --- | --- |
| `suggest` | Any task | Slowest; requires manual approval |
| `auto` | Trusted projects | Still prompts for shell commands |
| `full-auto` | CI / trusted automation only | Runs shell commands unattended |

---

## Scripting

```bash
# Non-interactive run
codex --non-interactive "fix all TypeScript errors"

# Quiet output (suppress progress noise)
codex --quiet "run the tests and report failures"

# Set working directory
codex --cwd /path/to/project "update the README"

# Pipe input
cat error.log | codex "what is causing these errors?"
git diff | codex "review these changes for issues"

# Switch model
codex --model o3 "refactor this module"
```

---

## Troubleshooting

| Symptom | Fix |
| --- | --- |
| CLI binary not found | Re-run the install step (see [Install](#install)); check `$PATH` |
| `OPENAI_API_KEY not set` | Export the key or authenticate via browser (see [Auth](#auth)) |
| Auth loop / browser won't open | Sign out then sign in again (see [Auth](#auth)) |
| Node.js version error | Upgrade to Node.js 18+ (`node --version`) |
| Slow / no response | Check internet; try `--verbose` |
| Changes not applying | Check approval mode; ensure `--non-interactive` isn't blocking |
| Wrong AGENTS.md loaded | Run with `--verbose` to see which config files are loaded |
| Model not available | Verify your OpenAI plan supports the requested model |

Enable verbose logging:

```bash
codex --verbose "your task here"
```

For issues not covered here, use the companion documentation skill to look up the
relevant documentation page.
