---
name: codex-cli-docs
description: "Use this skill to look up official OpenAI Codex CLI documentation at developers.openai.com/codex/cli. Trigger when the user asks about installing the Codex CLI, Codex CLI commands and flags, Codex CLI slash commands, Codex CLI features, running Codex in the terminal, or any Codex CLI-specific reference. For general Codex agent concepts, use codex-docs."
---

# OpenAI Coding CLI Docs

Reference skill for navigating the official coding CLI documentation.
Root URL and full page index are in the Key URLs section below.

---

## Intent Router

| Topic | Reference file | Load when... |
| --- | --- | --- |
| Install, auth, first run | `references/installation.md` | user needs to install or authenticate the CLI |
| Features and capabilities | `references/features.md` | user asks what the CLI can do |
| Command-line flags, subcommands, config | `references/cli-reference.md` | user asks about flags, `codex exec`, `codex mcp`, profiles, or invocations |
| Slash commands | `references/slash-commands.md` | user asks about in-session slash commands |

---

## Key URLs at a Glance

```text
CLI root            https://developers.openai.com/codex/cli
Features            https://developers.openai.com/codex/cli/features
Command options     https://developers.openai.com/codex/cli/reference
Slash commands      https://developers.openai.com/codex/cli/slash-commands
Config reference    https://developers.openai.com/codex/config-reference
MCP                 https://developers.openai.com/codex/mcp
Non-interactive     https://developers.openai.com/codex/noninteractive
IDE extension       https://developers.openai.com/codex/ide
GitHub README       https://github.com/openai/codex/blob/main/README.md
GitHub releases     https://github.com/openai/codex/releases
```

---

## Quick Start

```text
Need install/update/auth? Load references/installation.md.
Need flags, config, exec, MCP, or resume? Load references/cli-reference.md.
Need slash commands? Load references/slash-commands.md.
```

For facts that may have changed, fetch the official page listed in the reference
before answering.

---

## Quick Install

```bash
# npm (global)
npm install -g @openai/codex

# Homebrew
brew install --cask codex
```

Then authenticate:

```bash
codex login
```

or pipe an API key into `codex login --with-api-key`.
