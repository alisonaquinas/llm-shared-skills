# Claude Code CLI — Installation & Setup

## Key Pages

| Page | URL |
| --- | --- |
| Overview | <https://code.claude.com/docs/en/overview> |
| Quickstart | <https://code.claude.com/docs/en/quickstart> |
| Advanced setup | <https://code.claude.com/docs/en/setup> |
| Troubleshooting | <https://code.claude.com/docs/en/troubleshooting> |

## Install

```bash
# macOS / Linux / WSL (recommended)
curl -fsSL https://claude.ai/install.sh | bash

# Windows PowerShell
irm https://claude.ai/install.ps1 | iex

# Windows CMD
curl -fsSL https://claude.ai/install.cmd -o install.cmd && install.cmd && del install.cmd

# Homebrew (macOS/Linux) — does not auto-update
brew install --cask claude-code

# WinGet (Windows) — does not auto-update
winget install Anthropic.ClaudeCode
```

Note: Windows requires [Git for Windows](https://git-scm.com/downloads/win).

## First Run

```bash
cd your-project
claude
```

You'll be prompted to log in with your Anthropic account on first use.

## Requirements

- A Claude subscription or Anthropic Console account
- OR: configure a third-party provider (Bedrock, Vertex) — see <https://code.claude.com/docs/en/third-party-integrations>

## Update

Native installs auto-update in the background. For Homebrew:

```bash
brew upgrade claude-code
```

For WinGet:

```bash
winget upgrade Anthropic.ClaudeCode
```
