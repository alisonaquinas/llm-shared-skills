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
| Command-line flags and options | `references/cli-reference.md` | user asks about specific flags, options, or invocations |
| Slash commands | `references/slash-commands.md` | user asks about in-session slash commands |

---

## Key URLs at a Glance

```text
CLI root           https://developers.openai.com/codex/cli
Features           https://developers.openai.com/codex/cli/features
CLI reference      https://developers.openai.com/codex/cli/reference
Slash commands     https://developers.openai.com/codex/cli/slash-commands
Authentication     https://developers.openai.com/codex/auth
IDE extension      https://developers.openai.com/codex/ide
GitHub README      https://github.com/openai/codex/blob/main/README.md
GitHub releases    https://github.com/openai/codex/releases
```

---

## Quick Install

```bash
# npm (global)
npm install -g @openai/codex

# Homebrew (macOS/Linux)
brew install codex
```

Then authenticate:

```bash
codex auth login
```

or set `OPENAI_API_KEY` in your environment.
