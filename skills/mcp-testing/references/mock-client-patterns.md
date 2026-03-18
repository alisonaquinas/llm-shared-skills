# Mock Client Patterns

Load when writing protocol-level tests, testing the full JSON-RPC message flow,
or simulating client behavior in tests.

---

## TypeScript: In-Process MCP Client

Use `InMemoryTransport` from the SDK to test the full server without spawning a process.

```typescript
import { Client } from "@modelcontextprotocol/sdk/client/index.js";
import { Server } from "@modelcontextprotocol/sdk/server/index.js";
import { InMemoryTransport } from "@modelcontextprotocol/sdk/inMemory.js";
import { describe, it, expect, beforeEach } from "vitest";
import { createServer } from "../src/server.js"; // your server factory

describe("MCP protocol integration", () => {
  let client: Client;

  beforeEach(async () => {
    const server = createServer();
    const [clientTransport, serverTransport] = InMemoryTransport.createLinkedPair();

    client = new Client(
      { name: "test-client", version: "1.0.0" },
      { capabilities: {} }
    );

    await server.connect(serverTransport);
    await client.connect(clientTransport);
  });

  it("lists all registered tools", async () => {
    const result = await client.listTools();
    expect(result.tools).toHaveLength(1);
    expect(result.tools[0].name).toBe("echo");
  });

  it("calls echo tool and returns message", async () => {
    const result = await client.callTool({
      name: "echo",
      arguments: { message: "test" },
    });
    expect(result.content[0]).toMatchObject({ type: "text", text: "test" });
    expect(result.isError).toBe(false);
  });

  it("returns error content for unknown tool", async () => {
    const result = await client.callTool({
      name: "nonexistent",
      arguments: {},
    });
    expect(result.isError).toBe(true);
  });
});
```

### Server Factory Pattern

Export a `createServer()` function from your server module to enable test injection:

```typescript
// src/server.ts
export function createServer(): Server {
  const server = new Server(
    { name: "my-server", version: "1.0.0" },
    { capabilities: { tools: {} } }
  );
  // register handlers...
  return server;
}

// src/index.ts (entry point — not imported by tests)
import { createServer } from "./server.js";
import { StdioServerTransport } from "@modelcontextprotocol/sdk/server/stdio.js";
const server = createServer();
await server.connect(new StdioServerTransport());
```

---

## Python: In-Process Client (pytest)

```python
import pytest
import asyncio
from mcp import ClientSession
from mcp.server.fastmcp import FastMCP
from mcp.shared.memory import create_connected_server_and_client_session

from server import mcp  # your FastMCP instance

@pytest.mark.asyncio
async def test_list_tools():
    async with create_connected_server_and_client_session(mcp._mcp_server) as client:
        result = await client.list_tools()
        tool_names = [t.name for t in result.tools]
        assert "echo" in tool_names

@pytest.mark.asyncio
async def test_call_echo():
    async with create_connected_server_and_client_session(mcp._mcp_server) as client:
        result = await client.call_tool("echo", {"message": "hello"})
        assert result.content[0].text == "hello"
        assert not result.isError
```

---

## JSON-RPC Message Reference

The MCP protocol uses JSON-RPC 2.0. These are the message shapes relevant to testing:

### initialize request (client → server)
```json
{
  "jsonrpc": "2.0",
  "id": 1,
  "method": "initialize",
  "params": {
    "protocolVersion": "2024-11-05",
    "capabilities": {},
    "clientInfo": {"name": "test-client", "version": "1.0.0"}
  }
}
```

### initialize response (server → client)
```json
{
  "jsonrpc": "2.0",
  "id": 1,
  "result": {
    "protocolVersion": "2024-11-05",
    "capabilities": {"tools": {}},
    "serverInfo": {"name": "my-server", "version": "1.0.0"}
  }
}
```

### tools/call request
```json
{
  "jsonrpc": "2.0",
  "id": 2,
  "method": "tools/call",
  "params": {
    "name": "echo",
    "arguments": {"message": "hello"}
  }
}
```

### tools/call response (success)
```json
{
  "jsonrpc": "2.0",
  "id": 2,
  "result": {
    "content": [{"type": "text", "text": "hello"}],
    "isError": false
  }
}
```

### JSON-RPC error response
```json
{
  "jsonrpc": "2.0",
  "id": 2,
  "error": {
    "code": -32601,
    "message": "Method not found"
  }
}
```

---

## Claude Code PreToolCall Hook (Debugging Pattern)

Add this to `.claude/settings.json` to log every MCP tool call during development:

```json
{
  "hooks": {
    "PreToolCall": [
      {
        "matcher": "mcp__*",
        "hooks": [
          {
            "type": "command",
            "command": "echo \"MCP call: $CLAUDE_TOOL_NAME\" >> /tmp/mcp-debug.log"
          }
        ]
      }
    ]
  }
}
```

`$CLAUDE_TOOL_NAME` contains the full tool name (e.g., `mcp__my-server__echo`).
This captures all MCP invocations without modifying the server code.
