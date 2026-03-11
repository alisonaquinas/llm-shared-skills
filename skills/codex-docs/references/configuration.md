# OpenAI Codex — Configuration

## Key Pages

| Topic | URL |
| --- | --- |
| Config overview | <https://developers.openai.com/codex/config> |
| AGENTS.md | <https://developers.openai.com/codex/config/agents-md> |
| Config files | <https://developers.openai.com/codex/config/config-files> |
| Rules | <https://developers.openai.com/codex/config/rules> |
| MCP | <https://developers.openai.com/codex/config/mcp> |
| Skills | <https://developers.openai.com/codex/config/skills> |
| Speed | <https://developers.openai.com/codex/config/speed> |
| Multi-agents config | <https://developers.openai.com/codex/config/multi-agents> |

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

Configure MCP servers in your Codex settings or config file.

## Skills

Skills are packaged, reusable workflows that Codex can invoke. Similar to Claude
Code's custom commands. Configure skills in your Codex config to give Codex
repeatable task templates.

## Config Files

Codex can be configured via a config file (YAML or JSON) at the repo root or in
the Codex app settings. Controls: model selection, sandbox settings, allowed
domains, MCP servers, and more.
