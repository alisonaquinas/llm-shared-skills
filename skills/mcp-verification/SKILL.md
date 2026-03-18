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

Run through this checklist before proceeding to mcp-integration:

```
[ ] Server starts without errors (exit code 0 on clean startup)
[ ] tools/list response contains all declared tools
[ ] Each tool has valid name, description, and inputSchema
[ ] inputSchema passes JSON Schema Draft 7 (root must be {"type": "object"})
[ ] Every property in inputSchema has a "description" field
[ ] "required" array only references properties that exist in "properties"
[ ] Server responds to tools/call with content array format
[ ] Error responses use {content: [{type:"text", text:"Error:..."}], isError:true}
[ ] SSE servers: health endpoint responds (if applicable)
[ ] stdio servers: no non-JSON output on stdout
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
