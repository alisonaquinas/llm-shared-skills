---
name: claude-cli-docs
description: "Use this skill to look up official Claude Code documentation at code.claude.com/docs. Trigger when the user asks about Claude Code CLI flags, CLAUDE.md, MCP servers, Claude Code hooks, Claude Code skills, sub-agents, Claude Code settings, routines / scheduled jobs, remote dispatch / cross-device handoff, channels (Telegram / Discord / iMessage webhooks), GitHub Actions with Claude Code, GitLab CI/CD, or any Claude Code developer reference."
---

# Coding CLI Docs

Reference skill for navigating official coding CLI documentation at
**<https://code.claude.com/docs/en/>**

Full page index: <https://code.claude.com/docs/llms.txt>

---

## Intent Router

| Topic | Reference file | Load when... |
| --- | --- | --- |
| Install, setup, first run | `references/installation.md` | user needs to install the CLI or get started |
| CLI flags, commands, options | `references/cli-reference.md` | user asks about `claude` command flags, `-p`, `--model`, etc. |
| CLAUDE.md, auto memory | `references/memory.md` | user asks about persistent instructions or memory |
| MCP servers | `references/mcp.md` | user asks about MCP configuration or server setup |
| Custom skills/slash commands | `references/skills.md` | user asks about creating or using custom `/commands` |
| Hooks | `references/hooks.md` | user asks about pre/post hooks on tool actions |
| Workflows, sub-agents, best practices | `references/workflows.md` | user asks about patterns, common tasks, or parallel agents |
| Routines, scheduling, remote dispatch | `references/routines-and-dispatch.md` | user asks about `/schedule`, `/loop`, cron routines, cross-device handoff, or desktop scheduled tasks |
| CI/CD, Slack, Chrome, IDE integrations | `references/integrations.md` | user asks about non-terminal surfaces or automation |

---

## Key URLs at a Glance

```text
Root              https://code.claude.com/docs/en/overview
Quickstart        https://code.claude.com/docs/en/quickstart
CLI reference     https://code.claude.com/docs/en/cli-reference
Memory / CLAUDE.md https://code.claude.com/docs/en/memory
MCP               https://code.claude.com/docs/en/mcp
Skills            https://code.claude.com/docs/en/skills
Hooks             https://code.claude.com/docs/en/hooks
Sub-agents        https://code.claude.com/docs/en/sub-agents
Settings          https://code.claude.com/docs/en/settings
Plugins           https://code.claude.com/docs/en/plugins
Worktrees         https://code.claude.com/docs/en/worktrees
Common workflows  https://code.claude.com/docs/en/common-workflows
Best practices    https://code.claude.com/docs/en/best-practices
Routines          https://code.claude.com/docs/en/routines
GitHub Actions    https://code.claude.com/docs/en/github-actions
GitLab CI/CD      https://code.claude.com/docs/en/gitlab-ci-cd
VS Code           https://code.claude.com/docs/en/vs-code
JetBrains         https://code.claude.com/docs/en/jetbrains
Desktop app       https://code.claude.com/docs/en/desktop
Web               https://code.claude.com/docs/en/claude-code-on-the-web
Remote control    https://code.claude.com/docs/en/remote-control
Slack             https://code.claude.com/docs/en/slack
Chrome            https://code.claude.com/docs/en/chrome
Troubleshooting   https://code.claude.com/docs/en/troubleshooting
Setup (advanced)  https://code.claude.com/docs/en/setup
Agent SDK         https://platform.claude.com/docs/en/agent-sdk/overview
```

---

## Quick Start

```text
Need install/update/auth? Load references/installation.md.
Need flags, print mode, permissions, or resume? Load references/cli-reference.md.
Need hooks, MCP, skills, or subagents? Load the matching reference file first.
```

For facts that may have changed, fetch the page listed in the reference before
answering.

---

## Installation (quick reference)

```bash
# macOS / Linux / WSL
curl -fsSL https://claude.ai/install.sh | bash

# Windows PowerShell
irm https://claude.ai/install.ps1 | iex

# Windows CMD
curl -fsSL https://claude.ai/install.cmd -o install.cmd && install.cmd && del install.cmd

# Homebrew
brew install --cask claude-code

# Homebrew latest channel
brew install --cask claude-code@latest

# WinGet
winget install Anthropic.ClaudeCode
```
