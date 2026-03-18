---
name: mcp-integration
description: >
  Client integration phase for MCP server development. Use when connecting an MCP
  server to an MCP-compatible agent or desktop client, configuring the mcpServers
  block in settings.json, adding a server to a desktop client, testing with a real
  client, verifying tool visibility in the client UI, troubleshooting connection
  failures, or configuring environment variables for server startup. Covers
  settings.json configuration, environment variable passing, and connection
  troubleshooting.
---

# MCP Integration

Connect the server to a real client and verify tool visibility.

## Intent Router

Load reference files on demand — only when the corresponding topic is active:

- `references/client-config-patterns.md` — Load when configuring mcpServers in
  settings.json, writing Claude Desktop config, or setting environment variables
- `references/connection-troubleshooting.md` — Load when the client cannot connect,
  tools are not visible, or the connection drops intermittently

## Quick Start — Client Configuration

Add to `~/.claude/settings.json` (user scope) or `.claude/settings.json` (project scope):

```json
{
  "mcpServers": {
    "my-server": {
      "command": "node",
      "args": ["/absolute/path/to/dist/index.js"],
      "env": {}
    }
  }
}
```

For a Python server:
```json
{
  "mcpServers": {
    "my-server": {
      "command": "python",
      "args": ["/absolute/path/to/server.py"]
    }
  }
}
```

**Always use absolute paths.** Relative paths fail when the client working directory
differs from the project root.

## Verification After Configuration

After saving the config:

1. Start a new conversation in the agent
2. Ask the agent to list available tools or check connected MCP servers
3. Confirm the server name appears and tools are listed
4. Call one tool to verify end-to-end connectivity

If tools are absent, load `references/connection-troubleshooting.md`.

## Environment Variable Passing

Pass secrets and configuration via the `env` block in settings.json:

```json
{
  "mcpServers": {
    "my-server": {
      "command": "node",
      "args": ["/path/to/dist/index.js"],
      "env": {
        "API_KEY": "sk-...",
        "DATABASE_URL": "postgres://..."
      }
    }
  }
}
```

Values in settings.json are stored in plaintext. For sensitive secrets, have the
server read from a `.env` file at startup using dotenv or python-dotenv.

## SSE Server Integration

For servers using HTTP/SSE transport, use the `url` field instead of `command`:

```json
{
  "mcpServers": {
    "remote-server": {
      "url": "http://localhost:3001/sse"
    }
  }
}
```

## Gate

mcp-integration is complete when:
- The server appears in the client's connected MCP servers list
- All declared tools are visible in the client UI
- At least one tool call succeeds end-to-end through the real client

Proceed to mcp-validation only after tools are confirmed visible and callable
in the target client.

## Safety Notes

Use absolute paths in `command` and `args` — relative paths cause "spawn ENOENT"
errors when the client's working directory does not match the expected location.
After editing settings.json, start a fresh session for the new config to take effect.

## Resource Index

| Reference File | Load When |
|---|---|
| `references/client-config-patterns.md` | Initial client configuration; Claude Desktop; multiple servers |
| `references/connection-troubleshooting.md` | Any connection failure; tools not visible; parse errors |
