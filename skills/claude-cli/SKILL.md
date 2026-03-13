---
name: claude-cli
description: "Use this skill when the user wants to install, set up, update, configure, manage, or troubleshoot the Claude Code CLI tool. Triggers: install claude code, update claude, claude command not found, set up CLAUDE.md, configure permissions, add an MCP server, claude won't start, change the model, set up hooks, run claude non-interactively, pipe to claude, resume a session, or any hands-on operational task with the claude CLI binary. For documentation lookups use claude-cli-docs."
---

# Claude CLI

Operational skill for installing, configuring, managing, and troubleshooting the
`claude` CLI binary. For deep documentation lookups, use the **claude-cli-docs** skill.

---

## Intent Router

| Task | Action |
| --- | --- |
| Install / first run | See [Install](#install) below |
| Update | See [Update](#update) below |
| Auth / login issues | See [Auth](#auth) below |
| Configure CLAUDE.md | See [Configuration](#configuration) below |
| Permissions & tools | See [Permissions](#permissions) below |
| MCP servers | See [MCP](#mcp) below |
| Non-interactive / scripting | See [Scripting](#scripting) below |
| Troubleshooting | See [Troubleshooting](#troubleshooting) below |
| Advanced / docs lookup | Use **claude-cli-docs** skill |

---

## Install

```bash
# macOS / Linux / WSL (recommended — auto-updates)
curl -fsSL https://claude.ai/install.sh | bash

# Windows PowerShell (auto-updates)
irm https://claude.ai/install.ps1 | iex

# Homebrew (does NOT auto-update)
brew install --cask claude-code

# WinGet (does NOT auto-update)
winget install Anthropic.ClaudeCode
```

Windows requires [Git for Windows](https://git-scm.com/downloads/win).

First run:

```bash
cd your-project
claude          # prompts for login on first use
```

---

## Update

Native installs (curl/PowerShell) auto-update in the background. Manual update:

```bash
# Homebrew
brew upgrade claude-code

# WinGet
winget upgrade Anthropic.ClaudeCode

# Check current version
claude --version
```

---

## Auth

Login is prompted automatically on first run. To re-authenticate:

```bash
claude auth login     # opens browser to log in
claude auth logout    # sign out
claude auth status    # show current auth state
```

For API-key or third-party provider (Bedrock, Vertex) setup, use **claude-cli-docs**.

---

## Configuration

### CLAUDE.md

`CLAUDE.md` at the project root (or `~/.claude/CLAUDE.md` for global defaults) is read
at the start of every session. Put coding standards, build commands, and conventions here.

```markdown
# My Project

## Commands
- Build: `npm run build`
- Test: `npm test`

## Conventions
- TypeScript strict mode
- Tests required for all public APIs
```

Claude walks up from the current directory to find CLAUDE.md files.

### Settings file

`~/.claude/settings.json` controls global defaults (model, permissions, hooks, etc.).
For the full settings schema, use **claude-cli-docs** or visit
`https://code.claude.com/docs/en/settings`.

---

## Permissions

```bash
claude --permission-mode acceptEdits    # auto-approve file edits, prompt for commands
claude --permission-mode bypassPermissions  # skip all prompts (use with care)
claude --permission-mode plan           # plan mode: propose changes, don't apply
```

Restrict or expand which tools are available:

```bash
claude --allowedTools Bash,Read,Write
claude --disallowedTools Bash
```

---

## MCP

Add an MCP server interactively:

```bash
claude mcp add <name> -- <command> [args...]
# Example: local stdio server
claude mcp add my-server -- node /path/to/server.js

# Add from npm
claude mcp add filesystem -- npx -y @modelcontextprotocol/server-filesystem /tmp
```

List / remove servers:

```bash
claude mcp list
claude mcp remove <name>
```

For full MCP configuration options, use **claude-cli-docs**.

---

## Scripting

Non-interactive (CI/automation) usage:

```bash
# Print mode — outputs to stdout, no interaction
claude -p "explain this function"

# Pipe input
echo "what does this do?" | claude -p
git diff main | claude -p "summarize these changes"

# Limit agentic turns
claude -p --max-turns 5 "fix the failing tests"

# Output as JSON
claude -p --output-format json "list all API endpoints"

# Resume a session
claude --continue                    # resume most recent
claude --resume <session-id>         # resume by ID
```

---

## Troubleshooting

| Symptom | Fix |
| --- | --- |
| `command not found: claude` | Re-run the install script; check `$PATH` |
| Login loop / auth fails | `claude auth logout` then `claude auth login` |
| Slow / no response | Check internet connection; try `--verbose` |
| Model not available | Verify subscription tier; use `--model` to override |
| Wrong CLAUDE.md loaded | Run `claude --verbose` to see which files are loaded |
| MCP server not connecting | `claude mcp list`; check server logs with `--verbose` |
| Permission denied on files | Check `--allowedTools` / `--disallowedTools` flags |
| Hooks not firing | Verify `~/.claude/settings.json` hook config; use `--verbose` |

Enable verbose logging for any issue:

```bash
claude --verbose "your task here"
```

Official troubleshooting page: `https://code.claude.com/docs/en/troubleshooting`

For issues not covered here, use the **claude-cli-docs** skill to look up the
relevant documentation page.
