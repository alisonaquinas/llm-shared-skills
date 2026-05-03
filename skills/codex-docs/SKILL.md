---
name: codex-docs
description: "Use this skill to look up official OpenAI Codex documentation at developers.openai.com/codex. Trigger when the user asks about Codex features, Codex concepts, AGENTS.md, Codex MCP, Codex SDK, Codex GitHub Action, Codex automation, or any OpenAI Codex reference. For CLI-specific help, use codex-cli-docs."
---

# OpenAI Coding Agent Docs

Reference skill for navigating official OpenAI coding agent documentation.
Root URL and full page index are in the Key URLs section below.

---

## Intent Router

| Topic | Reference file | Load when... |
| --- | --- | --- |
| Overview, quickstart, plans | `references/overview.md` | user needs intro, what the agent is, pricing, getting started |
| Concepts: prompting, sandboxing, agents | `references/concepts.md` | user asks about how the agent works conceptually |
| Configuration: AGENTS.md, MCP, skills | `references/configuration.md` | user asks about configuring the agent's behavior |
| Interfaces: app, IDE, CLI, web, integrations | `references/interfaces.md` | user asks about which surface to use or how integrations work |
| Automation: SDK, non-interactive, GitHub Action | `references/automation.md` | user asks about running the agent in CI/CD or programmatically |

---

## Key URLs at a Glance

```text
Root                https://developers.openai.com/codex
Quickstart          https://developers.openai.com/codex/quickstart
Pricing / Plans     https://developers.openai.com/codex/pricing
Concepts            https://developers.openai.com/codex/concepts
AGENTS.md           https://developers.openai.com/codex/guides/agents-md
Configuration       https://developers.openai.com/codex/config-basic
Config reference    https://developers.openai.com/codex/config-reference
MCP                 https://developers.openai.com/codex/mcp
Skills              https://developers.openai.com/codex/skills
Subagents           https://developers.openai.com/codex/subagents
CLI docs            https://developers.openai.com/codex/cli
IDE Extension       https://developers.openai.com/codex/ide
App                 https://developers.openai.com/codex/app
Web / cloud         https://developers.openai.com/codex/cloud
GitHub integration  https://developers.openai.com/codex/integrations/github
Slack integration   https://developers.openai.com/codex/integrations/slack
GitHub Action       https://developers.openai.com/codex/github-action
Non-interactive     https://developers.openai.com/codex/noninteractive
SDK                 https://developers.openai.com/codex/sdk
App server          https://developers.openai.com/codex/app-server
Security            https://developers.openai.com/codex/security
```

---

## What is the OpenAI Coding Agent?

The OpenAI coding agent is available in ChatGPT and via API. It can read,
write, test, and debug code autonomously across a codebase. Available as
a web app, IDE extension, terminal CLI, and GitHub integration.

## Quick Start

```text
Need setup or plans? Load references/overview.md.
Need AGENTS.md, MCP, hooks, skills, or subagents? Load references/configuration.md.
Need non-interactive, SDK, app-server, or GitHub Action? Load references/automation.md.
```

```bash
codex exec "summarize this repository and identify the main test command"
```
