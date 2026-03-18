# Client Compatibility

Load when the server must support a specific client other than local stdio, or
when it must support multiple clients simultaneously.

---

## Supported Clients Overview

| Client | Transport Support | Config File | Notes |
|---|---|---|---|
| Claude Code (CLI) | stdio, SSE | `~/.claude/settings.json` or `.claude/settings.json` | Most common; local stdio preferred |
| Claude Desktop | stdio, SSE | Platform-specific (see below) | GUI app; same protocol as Claude Code |
| Cursor | stdio | Cursor MCP settings UI | stdio only in most versions |
| Custom clients | Depends on SDK used | Application-defined | Must implement MCP client protocol |

---

## Claude Code Configuration

**User-scope (all projects):** `~/.claude/settings.json`
**Project-scope (this project only):** `.claude/settings.json` in project root

```json
{
  "mcpServers": {
    "server-name": {
      "command": "node",
      "args": ["/absolute/path/to/dist/index.js"],
      "env": {
        "API_KEY": "value"
      }
    }
  }
}
```

Key constraints:

- `command` must be an absolute path or a binary on the system PATH
- `args` elements must be strings
- `env` values must be strings (not numbers or booleans)
- Project-scope config is loaded on top of user-scope config (project wins on conflicts)

---

## Claude Desktop Configuration

**macOS:** `~/Library/Application Support/Claude/claude_desktop_config.json`
**Windows:** `%APPDATA%\Claude\claude_desktop_config.json`
**Linux:** `~/.config/Claude/claude_desktop_config.json`

```json
{
  "mcpServers": {
    "server-name": {
      "command": "node",
      "args": ["/absolute/path/to/dist/index.js"]
    }
  }
}
```

After editing the config, restart Claude Desktop for changes to take effect.

---

## Multi-Client Compatibility Checklist

When building a server that must work with more than one client:

- [ ] Use stdio transport (universally supported) unless remote access is required
- [ ] Avoid client-specific extensions to the MCP protocol
- [ ] Keep tool names under 64 characters (some clients truncate)
- [ ] Keep tool descriptions under 200 characters (display limits vary)
- [ ] Return string content or `{type: "text", text: "..."}` content — most compatible format
- [ ] Do not rely on client-specific session state
- [ ] Test with each target client separately — capabilities differ

---

## Custom Client Requirements

When the consuming client is custom-built (not Claude Code or Claude Desktop):

1. The client must implement the MCP client protocol (JSON-RPC 2.0 over stdio or SSE)
2. The client must send an `initialize` request before any tool calls
3. The client must respect the `capabilities` returned in the `initialize` response
4. Tool call responses follow the `content` array format:

   ```json
   {
     "content": [{"type": "text", "text": "result"}],
     "isError": false
   }
   ```

---

## Known Compatibility Constraints

| Constraint | Affected Clients | Mitigation |
|---|---|---|
| Tool name max length | Some clients truncate at 64 chars | Keep tool names ≤64 chars |
| `isError: true` handling | Older clients may not surface error flag | Include error description in text content |
| Resource subscriptions | Not supported in all clients | Treat resources as optional capability |
| Prompt templates | Not exposed by all clients | Do not rely on prompts as primary interface |
| Binary/blob resources | Limited client support | Prefer text content for maximum compatibility |
