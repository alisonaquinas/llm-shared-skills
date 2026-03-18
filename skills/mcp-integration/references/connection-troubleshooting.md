# Connection Troubleshooting

Load when the client cannot connect, tools are not visible in the client UI,
or the connection drops intermittently.

---

## Diagnostic Flowchart

Work through these questions in order:

```
1. Does the server start without errors?
   ├── No  → Server startup failure (see below)
   └── Yes → continue

2. Does tools/list return all declared tools?
   ├── No  → Tool registration failure (see below)
   └── Yes → continue

3. Are tools visible in the client UI?
   ├── No  → Client config or restart issue (see below)
   └── Yes → Integration complete ✓
```

---

## Server Startup Failures

### Symptom: "spawn ENOENT" or "command not found"

**Cause:** The `command` in settings.json is not found on PATH or is a relative path.

**Diagnostic:**
```bash
# Verify the command resolves
which node
which python
node --version
python --version
```

**Fix:** Use absolute path to the binary:
```json
{
  "command": "/usr/local/bin/node",
  "args": ["/absolute/path/to/dist/index.js"]
}
```

Or find the absolute path:
```bash
which node   # → /usr/local/bin/node (macOS/Linux)
where node   # → C:\Program Files\nodejs\node.exe (Windows)
```

---

### Symptom: "MODULE_NOT_FOUND" or "No such file or directory" (dist/)

**Cause:** TypeScript source compiled but `dist/` not built, or wrong path in args.

**Fix:**
```bash
cd /path/to/my-server
npm run build    # or: tsc
ls dist/         # Verify dist/index.js exists
```

---

### Symptom: Server starts but immediately exits

**Cause:** Unhandled exception during startup (missing env var, bad config, etc.).

**Fix:** Run the server manually to see stderr output:
```bash
node /path/to/dist/index.js
# or
python /path/to/server.py
```

Check stderr for the error message. Common causes:
- Missing required environment variable: add it to `env` block in settings.json
- Syntax error in compiled JS: re-run `npm run build` and check TypeScript errors
- Missing dependency: run `npm install` in the server directory

---

## Tool Registration Failures

### Symptom: Server connects but shows 0 tools

**Cause:** `ListToolsRequestSchema` handler not registered, or handler returns empty array.

**Fix (TypeScript):** Verify both handlers are registered:
```typescript
server.setRequestHandler(ListToolsRequestSchema, async () => ({
  tools: [...],  // must be non-empty
}));
server.setRequestHandler(CallToolRequestSchema, async (req) => { ... });
```

**Cause (Python FastMCP):** `@mcp.tool()` decorator not applied, or function not imported.

---

### Symptom: Some tools appear, others do not

**Cause:** Tool registration is conditional or fails silently for some tools.

**Fix:** Run the Inspector to see exactly which tools are listed:
```bash
npx @modelcontextprotocol/inspector node dist/index.js
```

Open the Tools panel and compare against the expected tool list.

---

## Client UI Issues

### Symptom: Config saved but tools still not visible

**Cause:** Client has not reloaded the server config.

**Fix:**
- Claude Code: Start a new conversation (config is reloaded per session)
- Claude Desktop: Fully quit (Cmd+Q / Alt+F4) and relaunch

---

### Symptom: "JSON parse error" in client logs

**Cause:** Server writing non-JSON to stdout (logging, debug prints).

**Fix:** Redirect all output to stderr:
```typescript
// Wrong
console.log("Server ready");

// Correct
process.stderr.write("Server ready\n");
```

```python
# Wrong
print("Server ready")

# Correct
print("Server ready", file=sys.stderr)
```

---

### Symptom: Tools visible but calls hang or time out

**Cause:** Handler is async but not awaited, or external dependency (DB, API) is unreachable.

**Fix (TypeScript):** Ensure all async operations are awaited:
```typescript
// Wrong
server.setRequestHandler(CallToolRequestSchema, (req) => {
  return doAsyncWork();  // missing await
});

// Correct
server.setRequestHandler(CallToolRequestSchema, async (req) => {
  return await doAsyncWork();
});
```

---

## Reading Client Logs

### Claude Code
```bash
# macOS/Linux
tail -f ~/.claude/logs/mcp-*.log

# Windows
Get-Content "$env:USERPROFILE\.claude\logs\mcp-*.log" -Wait
```

### Claude Desktop (macOS)
```bash
tail -f ~/Library/Logs/Claude/mcp-*.log
```

### Claude Desktop (Windows)
```
%APPDATA%\Claude\logs\mcp-*.log
```

---

## SSE-Specific Issues

### Symptom: "Connection refused" for SSE server

**Cause:** HTTP server not running or listening on wrong port.

**Fix:** Start the SSE server first, then configure the client:
```bash
node dist/index.js &  # Start server in background
# Verify it's listening:
curl http://localhost:3001/sse
```

### Symptom: SSE connection drops after 30 seconds

**Cause:** Proxy or load balancer timeout on idle SSE connection.

**Fix:** Send periodic keep-alive comments from the server, or configure proxy timeout.
