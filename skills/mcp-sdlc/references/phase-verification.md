# Phase 5: Verification

Gate-focused reference for the MCP SDLC verification phase. Load when entering
or reviewing Phase 5.

---

## Pre-Entry Checklist

Before starting Phase 5:
- [ ] Phase 4 gate passed: unit tests pass, Inspector shows all tools
- [ ] Build is current (run `npm run build` if TypeScript)
- [ ] No pending changes to tool schemas or handler logic

---

## Phase 5 Deliverables

Produce all before moving to Phase 6:

1. **Completed verification checklist** — All 10 items PASS
2. **Schema validation result** — Each tool's inputSchema passes Draft 7 validation
3. **Inspector run log** — Tools listed, at least one tool called successfully

---

## Verification Checklist

```
[ ] Server starts without errors (exit code 0 on clean startup)
[ ] tools/list returns all declared tools
[ ] Each tool has valid name, description, and inputSchema
[ ] inputSchema root is {"type": "object", ...}
[ ] Every property has a "description" field
[ ] "required" array entries all exist in "properties"
[ ] Server responds to tools/call with content array format
[ ] Error responses include isError: true and descriptive message
[ ] stdio servers: no non-JSON output on stdout
[ ] initialize response includes protocolVersion field
```

## Key Commands

```bash
# Run Inspector
npx @modelcontextprotocol/inspector node dist/index.js  # TypeScript
npx @modelcontextprotocol/inspector python server.py    # Python

# Validate a schema
npx ajv validate -s schema.json -d test-data.json --spec=draft7  # TypeScript
python -m jsonschema -i test-data.json schema.json               # Python
```

---

## Gate Criterion

Phase 5 is complete when all 10 checklist items are PASS.
Any FAIL item blocks progression to Phase 6 — fix in Phase 3 and re-verify.

---

## Common Failures

1. **Missing `protocolVersion` in initialize response** — Client rejects the
   connection before any tool calls. Fix: SDK handles this automatically; verify
   the SDK version is current (`npm update @modelcontextprotocol/sdk`).

2. **Wrong error code format** — Custom error handlers returning non-JSON-RPC
   error codes confuse some clients. Fix: use the standard `{content: [...], isError: true}`
   pattern for tool-level errors.

3. **inputSchema missing `"type": "object"` at root** — Caught during schema
   validation. Fix: add `"type": "object"` at the root of every inputSchema.
