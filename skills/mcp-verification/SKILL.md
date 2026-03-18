---
name: mcp-verification
description: >
  Structural and protocol verification phase for MCP server development. Use when
  verifying MCP protocol conformance, validating tool schema correctness, checking
  transport compliance, running the MCP Inspector to inspect wire protocol,
  confirming correct server initialization, or catching protocol-level errors before
  client integration. Covers JSON Schema validation, Inspector usage, and
  initialize handshake verification.
---

# MCP Verification

Protocol conformance and schema validation before client integration.

## Intent Router

Load reference files on demand — only when the corresponding topic is active:

- `references/protocol-conformance.md` — Load when debugging protocol-level failures,
  verifying the initialize handshake, or inspecting JSON-RPC message flow
- `references/schema-validation-checks.md` — Load when tool registration fails,
  clients show malformed schema errors, or inputSchema needs Draft 7 validation

## Quick Start — Verification Checklist

Run through this checklist before proceeding to mcp-integration.
Items marked **(static)** can be checked by reading source code.
Items marked **(Inspector)** require a running server and the MCP Inspector.

```
Static checks (source code only):
[ ] (static)    Each tool has valid name, description, and inputSchema
[ ] (static)    inputSchema root is {"type": "object"}
[ ] (static)    Every property in inputSchema has a "description" field
[ ] (static)    "required" array only references properties in "properties"
[ ] (static)    stdio servers: no print()/console.log() writing to stdout

Live checks (run Inspector first):
[ ] (Inspector) Server starts without errors
[ ] (Inspector) tools/list returns all declared tools
[ ] (Inspector) tools/call returns content array format
[ ] (Inspector) Error inputs return isError:true with descriptive message
[ ] (Inspector) SSE servers: health endpoint responds (if applicable)
```

Gate: all items PASS before moving to mcp-integration.

## Inspector-Based Verification

The MCP Inspector provides a browser UI for interactive protocol inspection:

```bash
# TypeScript server (build first: npm run build)
npx @modelcontextprotocol/inspector node dist/index.js

# Python server
npx @modelcontextprotocol/inspector python server.py
```

In the Inspector:
1. **Tools tab** — verify all declared tools appear; check name and description
2. **Call a tool** — verify content array returned; check `isError` field
3. **Console tab** — inspect raw JSON-RPC messages; verify initialize handshake

## Schema Validation

Validate tool `inputSchema` definitions before connecting to a real client:

```bash
# TypeScript (ajv)
npx ajv validate -s schema.json -d '{"message":"test"}' --spec=draft7

# Python (jsonschema)
python -m jsonschema -i data.json schema.json
```

Load `references/schema-validation-checks.md` for common errors and fix recipes.

## Protocol Handshake Verification

A valid initialize exchange confirms the server speaks the MCP protocol.
The `initialize` response must include:

```json
{
  "protocolVersion": "2024-11-05",
  "capabilities": {"tools": {}},
  "serverInfo": {"name": "my-server", "version": "1.0.0"}
}
```

Missing `protocolVersion` is the most common handshake failure — the client
rejects the connection before any tool calls can be made.

Load `references/protocol-conformance.md` for the full message reference and
common non-conformance patterns.

## Safety Notes

Verification runs against a locally running server only. Never run verification
commands against production or shared server instances — Inspector spawns the
server as a subprocess and controls its lifecycle.

## Resource Index

| Reference File | Load When |
|---|---|
| `references/protocol-conformance.md` | Debugging protocol failures; inspecting initialize handshake |
| `references/schema-validation-checks.md` | Tool registration fails; schema validation errors |
