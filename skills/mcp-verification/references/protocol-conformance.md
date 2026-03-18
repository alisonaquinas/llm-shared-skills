# Protocol Conformance

Load when debugging protocol-level failures, verifying the initialize handshake,
or inspecting JSON-RPC message flow.

---

## MCP Protocol Overview

MCP uses JSON-RPC 2.0 as its message format. All messages are JSON objects.
The protocol version as of 2024 is `2024-11-05`.

### Message Flow (stdio)

```
Client                          Server
  │                               │
  │── initialize request ────────>│
  │<─ initialize response ────────│
  │── initialized notification ──>│
  │                               │
  │── tools/list request ────────>│
  │<─ tools/list response ────────│
  │                               │
  │── tools/call request ────────>│
  │<─ tools/call response ────────│
```

---

## initialize Request Shape

```json
{
  "jsonrpc": "2.0",
  "id": 1,
  "method": "initialize",
  "params": {
    "protocolVersion": "2024-11-05",
    "capabilities": {
      "roots": {"listChanged": true},
      "sampling": {}
    },
    "clientInfo": {
      "name": "claude-code",
      "version": "1.0.0"
    }
  }
}
```

## initialize Response Shape (server must return)

```json
{
  "jsonrpc": "2.0",
  "id": 1,
  "result": {
    "protocolVersion": "2024-11-05",
    "capabilities": {
      "tools": {},
      "resources": {},
      "prompts": {}
    },
    "serverInfo": {
      "name": "my-server",
      "version": "1.0.0"
    }
  }
}
```

**Required fields in result:** `protocolVersion`, `capabilities`, `serverInfo`
**Common failure:** missing `protocolVersion` in response → client rejects the connection

## initialized Notification (client → server, after initialize)

```json
{
  "jsonrpc": "2.0",
  "method": "notifications/initialized"
}
```

No `id` field — notifications do not expect responses.

---

## tools/list Response Shape

```json
{
  "jsonrpc": "2.0",
  "id": 2,
  "result": {
    "tools": [
      {
        "name": "echo",
        "description": "Returns the input message unchanged.",
        "inputSchema": {
          "type": "object",
          "properties": {
            "message": {"type": "string", "description": "Message to echo"}
          },
          "required": ["message"]
        }
      }
    ]
  }
}
```

---

## tools/call Response Shape

### Success
```json
{
  "jsonrpc": "2.0",
  "id": 3,
  "result": {
    "content": [
      {"type": "text", "text": "hello world"}
    ],
    "isError": false
  }
}
```

### Tool-level error (handler returned an error, not a crash)
```json
{
  "jsonrpc": "2.0",
  "id": 3,
  "result": {
    "content": [
      {"type": "text", "text": "Error: file not found at /bad/path"}
    ],
    "isError": true
  }
}
```

### Protocol-level error (method not found, parse error, etc.)
```json
{
  "jsonrpc": "2.0",
  "id": 3,
  "error": {
    "code": -32601,
    "message": "Method not found"
  }
}
```

### JSON-RPC 2.0 Standard Error Codes

| Code | Meaning |
|---|---|
| -32700 | Parse error |
| -32600 | Invalid request |
| -32601 | Method not found |
| -32602 | Invalid params |
| -32603 | Internal error |

---

## Common Non-Conformance Patterns

| Symptom | Root Cause | Fix |
|---|---|---|
| Client shows "connection refused" | Server exits immediately on start | Check for startup exceptions; add try/catch in main() |
| Tools never appear in client | Server responds to initialize but tools/list fails | Check ListToolsRequestSchema handler is registered |
| "Protocol version mismatch" error | Server response missing `protocolVersion` | Ensure initialize response includes `protocolVersion: "2024-11-05"` |
| Client disconnects after first call | Uncaught exception in handler exits process | Wrap all handler code in try/catch; return error content |
| Tool registered but not callable | `CallToolRequestSchema` handler not registered | Register both `ListToolsRequestSchema` AND `CallToolRequestSchema` |
| Garbled output, connection drops | Non-JSON written to stdout | Redirect all logging to stderr |

---

## PreToolCall Hook for Debugging

Add to `.claude/settings.json` to capture raw tool call payloads:

```json
{
  "hooks": {
    "PreToolCall": [
      {
        "matcher": "mcp__*",
        "hooks": [
          {
            "type": "command",
            "command": "echo \"[$(date)] $CLAUDE_TOOL_NAME\" >> /tmp/mcp-calls.log"
          }
        ]
      }
    ]
  }
}
```

This hook fires before every MCP tool call, logging the full tool name
(`mcp__<server-name>__<tool-name>`) to a file for post-hoc inspection.
