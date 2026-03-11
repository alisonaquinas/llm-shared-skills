# Claude Code CLI — MCP (Model Context Protocol)

## Reference Page

<https://code.claude.com/docs/en/mcp>

## What is MCP?

MCP (Model Context Protocol) is an open standard for connecting AI tools to external
data sources and services. With MCP, Claude Code can read Google Drive, update Jira
tickets, pull from Slack, query databases, and use custom tooling.

## Configure MCP Servers

MCP servers are configured in `~/.claude/settings.json` or project-level settings:

```json
{
  "mcpServers": {
    "my-server": {
      "command": "npx",
      "args": ["-y", "@my-org/my-mcp-server"],
      "env": {
        "API_KEY": "your-key"
      }
    }
  }
}
```

## Transport Types

| Transport | When to use |
| --- | --- |
| `stdio` | Local process (most common) |
| `sse` | Remote server over HTTP |

## Official MCP Registry

Browse community and official MCP servers:
<https://github.com/modelcontextprotocol/servers>

## MCP in Claude Code Settings

Claude Code supports enabling/disabling MCP servers per project or globally.
Configure via `~/.claude/settings.json` under `"mcpServers"`.

## Related

- MCP spec: <https://modelcontextprotocol.io/>
- Claude Code MCP docs: <https://code.claude.com/docs/en/mcp>
