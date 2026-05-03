# OpenAI Codex — Configuration

## Key Pages

| Topic | URL |
| --- | --- |
| Config basics | <https://developers.openai.com/codex/config-basic> |
| Advanced config | <https://developers.openai.com/codex/config-advanced> |
| Config reference | <https://developers.openai.com/codex/config-reference> |
| Config sample | <https://developers.openai.com/codex/config-sample> |
| AGENTS.md | <https://developers.openai.com/codex/guides/agents-md> |
| Rules | <https://developers.openai.com/codex/rules> |
| Hooks | <https://developers.openai.com/codex/hooks> |
| MCP | <https://developers.openai.com/codex/mcp> |
| Skills | <https://developers.openai.com/codex/skills> |
| Subagents | <https://developers.openai.com/codex/subagents> |

## AGENTS.md

`AGENTS.md` is a markdown file at the root of your repo that Codex reads at the
start of every session. Use it to provide:

- Project architecture and conventions
- Commands to run tests, lint, build
- Off-limits files or patterns
- Style guidelines and naming conventions

Codex also reads `AGENTS.md` files in subdirectories for folder-specific context.

## MCP (Model Context Protocol)

Codex supports MCP servers for connecting external tools and data sources:

- Jira, Linear, Notion, GitHub, Slack
- Custom MCP servers you build

Configure MCP servers in `~/.codex/config.toml` or with `codex mcp`.

## Skills

Skills are packaged, reusable workflows that Codex can invoke. Configure skills
and plugins so repeatable task templates stay available across sessions.

## Config Files

The CLI reads `~/.codex/config.toml`; project instructions live in `AGENTS.md`.
Important controls include model selection, approval policy, sandbox mode, MCP
servers, hooks, plugins, and web search mode.
