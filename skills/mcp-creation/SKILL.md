---
name: mcp-creation
description: >
  Scaffolding and implementation phase for MCP server development. Use when
  creating an MCP server from scratch, scaffolding a TypeScript or Python project,
  implementing tool handlers, wiring server startup, configuring package.json or
  pyproject.toml, or writing the main server entry point. Covers project
  initialization, SDK usage, tool handler implementation, and server lifecycle
  setup for both TypeScript and Python runtimes.
---

# MCP Creation

Scaffold, implement tool handlers, and wire server startup for MCP servers.

## Intent Router

Load reference files on demand — only when the corresponding runtime is in scope:

- `references/typescript-scaffold.md` — Load when building with TypeScript,
  using npm create, or wiring @modelcontextprotocol/sdk
- `references/python-scaffold.md` — Load when building with Python,
  using the mcp package, or using mcp.server.fastmcp.FastMCP

## Quick Start — Runtime Selection

| Runtime | Init Command | SDK Package | Entry Point |
|---|---|---|---|
| TypeScript | `npm create @modelcontextprotocol/server@latest my-server` | `@modelcontextprotocol/sdk` | `src/index.ts` |
| Python | `pip install mcp` | `mcp` (PyPI) | `server.py` |

Load the matching scaffold reference for full templates, build commands, and
error handling patterns.

## TypeScript Implementation Pattern

Minimal server with one tool:

```typescript
import { Server } from "@modelcontextprotocol/sdk/server/index.js";
import { StdioServerTransport } from "@modelcontextprotocol/sdk/server/stdio.js";
import { CallToolRequestSchema, ListToolsRequestSchema } from "@modelcontextprotocol/sdk/types.js";

const server = new Server(
  { name: "my-server", version: "1.0.0" },
  { capabilities: { tools: {} } }
);

server.setRequestHandler(ListToolsRequestSchema, async () => ({
  tools: [{ name: "echo", description: "Return input unchanged.", inputSchema: { type: "object", properties: { message: { type: "string", description: "Message to echo" } }, required: ["message"] } }],
}));

server.setRequestHandler(CallToolRequestSchema, async (req) => {
  if (req.params.name === "echo") {
    return { content: [{ type: "text", text: req.params.arguments?.message as string }], isError: false };
  }
  return { content: [{ type: "text", text: `Unknown tool: ${req.params.name}` }], isError: true };
});

await server.connect(new StdioServerTransport());
```

## Python Implementation Pattern

Minimal FastMCP server:

```python
from mcp.server.fastmcp import FastMCP

mcp = FastMCP("my-server")

@mcp.tool()
def echo(message: str) -> str:
    """Return the input message unchanged."""
    return message

if __name__ == "__main__":
    mcp.run()
```

## Tool Handler Contract

Every tool handler must follow these rules:

- Return a string or a content array — never return `None` or `undefined`
- Never throw uncaught exceptions — catch all errors and return error content
- Validate all inputs before processing — do not trust that required params are present
- Handle missing optional parameters with documented defaults
- Log to stderr only — never write to stdout in stdio servers

## Server Lifecycle

**stdio:** The process is spawned by the client; it runs until the client disconnects.
Handle SIGINT for clean shutdown. Never exit on a tool error — only exit on fatal startup failure.

**SSE:** Bind to an HTTP port; accept connections from clients; handle SIGINT to release the port.

## Safety Notes

**Critical:** In stdio servers, stdout is the JSON-RPC protocol channel. Any non-JSON
output on stdout — including `console.log()` in TypeScript or plain `print()` in
Python — corrupts the protocol stream and causes the client to disconnect with a
parse error. Use `process.stderr.write()` (TypeScript) or `print(..., file=sys.stderr)`
(Python) for all diagnostic logging.

## Resource Index

| Reference File | Load When |
|---|---|
| `references/typescript-scaffold.md` | Building a TypeScript MCP server |
| `references/python-scaffold.md` | Building a Python MCP server |
