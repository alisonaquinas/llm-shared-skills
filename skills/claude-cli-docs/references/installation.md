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

# Homebrew latest channel — does not auto-update
brew install --cask claude-code@latest

# WinGet (Windows) — does not auto-update
winget install Anthropic.ClaudeCode
```

Native Windows can run in PowerShell or CMD. Git for Windows is recommended so
the Bash tool is available; WSL2 is better for Linux-native toolchains and
sandboxed command execution.

## First Run

```bash
cd your-project
claude
```

You'll be prompted to log in with your Anthropic account on first use.

## Requirements

- A Claude subscription or Anthropic Console account
- OR: configure a third-party provider such as Bedrock, Vertex, or Microsoft Foundry:
  <https://code.claude.com/docs/en/setup>
- macOS 13+, Windows 10 1809+/Server 2019+, Ubuntu 20.04+, Debian 10+, or Alpine 3.19+
- 4 GB+ RAM, x64 or ARM64 processor, and internet access

## Update

Native installs auto-update in the background. For Homebrew:

```bash
claude update
brew upgrade claude-code
brew upgrade claude-code@latest
```

For WinGet:

```bash
winget upgrade Anthropic.ClaudeCode
```

Verify after install or update:

```bash
claude --version
claude doctor
```
