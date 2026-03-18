# Transport Selection

Load when choosing between stdio and SSE transport, or when the target client
environment is unclear or involves remote deployment.

---

## Transport Comparison

| Dimension | stdio | SSE (Server-Sent Events) |
|---|---|---|
| Startup model | Spawned as a subprocess by the client | Runs as a persistent HTTP server |
| Connection lifecycle | One process per client session | Persistent HTTP connection; multiple clients possible |
| Client support | Claude Code, Claude Desktop, Cursor, any stdio-capable host | Clients that support URL-based MCP config |
| Infrastructure required | None — just a runnable binary | HTTP server, port, optional TLS |
| Authentication | Inherits parent process environment | Must implement auth in HTTP layer |
| Latency | Near-zero (in-process pipe) | Network round-trip |
| Deployment | Local machine only | Local or remote |
| Debugging | Stderr visible in client logs | HTTP logs, network inspection |

---

## Decision Flowchart

Answer these questions in order:

1. **Will the server run on the same machine as the client?**
   - Yes → Use **stdio** (simpler, no infrastructure needed)
   - No → Use **SSE** (required for remote deployment)

2. **Does the client support SSE transport?**
   - Unsure → Default to **stdio** (universally supported)
   - Confirmed yes → Either transport works; prefer stdio unless remote is required

3. **Will multiple clients connect to the same server instance simultaneously?**
   - Yes → Use **SSE** (stdio is one process per client)
   - No → Use **stdio**

4. **Is the server a long-lived persistent service (daemon, cloud function, hosted API)?**
   - Yes → Use **SSE**
   - No → Use **stdio**

**Default choice:** stdio. Only choose SSE when at least one of questions 2, 3, or 4 is yes.

---

## stdio Configuration (Claude Code settings.json)

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

For Python:

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

## SSE Configuration (Claude Code settings.json)

```json
{
  "mcpServers": {
    "my-server": {
      "url": "http://localhost:3001/sse"
    }
  }
}
```

---

## stdio Startup Pattern (TypeScript)

```typescript
import { StdioServerTransport } from "@modelcontextprotocol/sdk/server/stdio.js";
const transport = new StdioServerTransport();
await server.connect(transport);
```

## SSE Startup Pattern (TypeScript)

```typescript
import { SSEServerTransport } from "@modelcontextprotocol/sdk/server/sse.js";
import express from "express";
const app = express();
app.get("/sse", async (req, res) => {
  const transport = new SSEServerTransport("/message", res);
  await server.connect(transport);
});
app.post("/message", express.json(), async (req, res) => {
  await transport.handlePostMessage(req, res);
});
app.listen(3001);
```

---

## Common Transport Mistakes

| Mistake | Effect | Fix |
|---|---|---|
| Writing to stdout in a stdio server | Corrupts JSON-RPC stream | Use stderr for all logging |
| Using relative path in stdio `command` | Server fails to start (path not found) | Use absolute paths always |
| Choosing SSE for a local-only server | Unnecessary complexity | Switch to stdio |
| Not handling SIGINT in SSE server | Port remains bound after crash | Add `process.on("SIGINT", ...)` handler |
