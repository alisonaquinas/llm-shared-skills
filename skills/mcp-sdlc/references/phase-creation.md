# Phase 3: Creation

Gate-focused reference for the MCP SDLC creation phase. Load when entering
or reviewing Phase 3.

---

## Pre-Entry Checklist

Before starting Phase 3:

- [ ] All tool schemas validated (Phase 2 gate passed)
- [ ] Runtime chosen: TypeScript or Python
- [ ] Transport decided: stdio or SSE

---

## Phase 3 Deliverables

Produce all before moving to Phase 4:

1. **Project scaffold** — package.json/pyproject.toml, source files, tsconfig.json
2. **Tool handlers** — Implementation for every tool in the capability inventory
3. **Server startup** — Transport wired and server running without errors
4. **Build artifact** — `dist/index.js` (TypeScript) or `server.py` (Python) runnable

---

## Key Commands

```bash
# TypeScript: scaffold
npm create @modelcontextprotocol/server@latest my-server
cd my-server && npm install

# Python: scaffold
pip install mcp
# or: uv init my-server && cd my-server && uv add mcp

# TypeScript: build
npm run build

# TypeScript: dev (hot reload)
npm run dev

# Verify server starts
node dist/index.js   # should not exit immediately
python server.py     # should not exit immediately
```

---

## Handler Contract

Every tool handler must:

- Catch all exceptions and return `{content: [{type:"text", text:"Error: ..."}], isError:true}`
- Write all diagnostic output to stderr only
- Never write non-JSON to stdout (stdio servers)

---

## Gate Criterion

Phase 3 is complete when the server starts, `tools/list` returns all declared
tools without errors, and each tool can be called and returns a response.
Use the MCP Inspector to verify: `npx @modelcontextprotocol/inspector node dist/index.js`

---

## Common Failures

1. **stdout pollution** — `console.log()` or `print()` in stdio server body corrupts
   the JSON-RPC stream. Fix: use `process.stderr.write()` (TypeScript) or
   `print(..., file=sys.stderr)` (Python) for all diagnostic output.

2. **Uncaught exceptions in handlers** — Handler throws → server process exits →
   client disconnects. Fix: wrap every handler body in try/catch.

3. **Missing build step** — Running `node src/index.ts` instead of
   `node dist/index.js` causes import errors. Fix: run `npm run build` before
   connecting any client.
