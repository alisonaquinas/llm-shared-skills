---
name: codex-cli
description: "Use when the user wants to install, set up, update, configure, manage, or troubleshoot the OpenAI Codex CLI tool. Triggers include install codex, update codex cli, codex command not found, set OPENAI_API_KEY, configure AGENTS.md, codex login, codex mcp, set approval or sandbox policy, run codex exec, pipe to codex, codex won't start, change the model in codex, or any hands-on operational task with the codex CLI binary. For documentation lookups use codex-cli-docs."
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
| MCP servers | See [MCP](#mcp) below |
| Approval and sandbox policy | See [Approval & Sandbox](#approval--sandbox) below |
| Non-interactive / scripting | See [Scripting](#scripting) below |
| Troubleshooting | See [Troubleshooting](#troubleshooting) below |
| Advanced / docs lookup | Use the companion documentation skill |

---

## Quick Start

```bash
codex --version
codex login status
codex -a on-request -s workspace-write "summarize this repository"
codex exec -a never -s workspace-write "run tests and report failures"
```

If the task asks for exact flags, config keys, MCP behavior, or current model
availability, switch to the companion documentation skill and verify first.

---

## Install

```bash
# npm (global install)
npm install -g @openai/codex

# Homebrew
brew install --cask codex
```

First run:

```bash
cd your-project
codex "describe what this codebase does"
```

The CLI runs on macOS, Windows, and Linux. On Windows, use native PowerShell
with the Windows sandbox, or WSL2 when a Linux-native toolchain is required.

---

## Update

```bash
# npm
npm i -g @openai/codex@latest

# Homebrew
brew upgrade --cask codex

# Check version
codex --version
```

Release notes: use the companion documentation skill for the changelog URL.

---

## Auth

### ChatGPT account or API key

```bash
codex login          # opens browser for ChatGPT sign-in
codex login status   # exits 0 when credentials are present
codex logout         # remove saved credentials
```

For headless hosts:

```bash
codex login --device-auth
printenv OPENAI_API_KEY | codex login --with-api-key
```

An `OPENAI_API_KEY` environment variable can also be used by scripts and CI.
Never put real keys in `AGENTS.md`, shell history examples, or committed config.

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

Persistent CLI settings live in `~/.codex/config.toml`. Override values for one
invocation with `-c key=value`, or load a named profile with `--profile`.

```bash
codex -c model=gpt-5.4 -c sandbox_mode=workspace-write "task"
codex --profile review "review this repository"
```

---

## MCP

MCP server launchers are stored in `~/.codex/config.toml`.

```bash
codex mcp add docs -- npx -y @modelcontextprotocol/server-filesystem .
codex mcp add remote --url https://mcp.example.com/mcp
codex mcp list --json
codex mcp get docs --json
codex mcp remove docs
```

Use per-server and per-tool approval settings in config when tools can write,
mutate external systems, or call network services.

---

## Approval & Sandbox

```bash
codex -a on-request -s workspace-write "task"  # interactive default for most edits
codex -a never -s workspace-write "task"       # unattended inside a sandbox
codex --yolo "task"                            # no approvals or sandbox; only in hardened envs
```

| Control | Values | Use |
| --- | --- | --- |
| `--ask-for-approval`, `-a` | `untrusted`, `on-request`, `never` | Human approval policy |
| `--sandbox`, `-s` | `read-only`, `workspace-write`, `danger-full-access` | Shell command containment |
| `--yolo` | boolean | Bypass both controls; avoid unless an outer sandbox protects the host |

---

## Scripting

```bash
# Non-interactive run
codex exec "fix all TypeScript errors"

# Non-interactive with explicit policy
codex exec -a never -s workspace-write "run tests and fix failures"

# Set working directory
codex --cd /path/to/project "update the README"

# Pipe input
cat error.log | codex exec "what is causing these errors?"
git diff | codex exec "review these changes for issues"

# Switch model
codex --model gpt-5.4 "refactor this module"

# Resume a previous interactive session
codex resume --last
codex resume <session-id>
```

---

## Troubleshooting

| Symptom | Fix |
| --- | --- |
| CLI binary not found | Re-run the install step (see [Install](#install)); check `$PATH` |
| `OPENAI_API_KEY not set` | Use `codex login`, `codex login --with-api-key`, or export the key |
| Auth loop / browser won't open | Sign out then sign in again (see [Auth](#auth)) |
| Slow / no response | Check internet; try `--verbose` |
| Changes not applying | Check `--ask-for-approval`, `--sandbox`, and `/permissions` |
| Wrong AGENTS.md loaded | Use `/status` or `/debug-config` to inspect config and roots |
| MCP tool not available | Run `codex mcp list --json`; check per-tool approval settings |
| Model not available | Verify your OpenAI plan supports the requested model |

Inspect active settings inside the TUI:

```text
/status
/debug-config
```

For issues not covered here, use the companion documentation skill to look up the
relevant documentation page.
