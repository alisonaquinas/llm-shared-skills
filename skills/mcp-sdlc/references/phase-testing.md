# Phase 4: Testing

Gate-focused reference for the MCP SDLC testing phase. Load when entering
or reviewing Phase 4.

---

## Pre-Entry Checklist

Before starting Phase 4:

- [ ] Phase 3 gate passed: server starts, tools/list returns all tools
- [ ] Handler functions are separated from transport wiring (importable)
- [ ] Test framework installed (Vitest for TypeScript; pytest for Python)

---

## Phase 4 Deliverables

Produce all before moving to Phase 5:

1. **Unit tests** — At least one happy-path test per tool handler
2. **Error case tests** — At least one test per tool for invalid/missing input
3. **Passing test suite** — `npm test` or `pytest` exits 0

---

## Key Commands

```bash
# TypeScript unit tests
npm run build
npm test             # Watch mode
npm run test:run     # Single pass (CI)

# Python unit tests
pytest
pytest -v           # Verbose

# MCP Inspector integration test (all tools visible?)
npx @modelcontextprotocol/inspector node dist/index.js
npx @modelcontextprotocol/inspector python server.py
```

---

## Minimum Test Coverage Per Tool

```text
[ ] Valid input → expected output type returned
[ ] Missing required param → error content returned (not exception)
[ ] Invalid param type → handled gracefully
[ ] Edge case (empty string, zero, max value) → no crash
```

---

## Gate Criterion

Phase 4 is complete when all unit tests pass and the MCP Inspector shows
all declared tools in its Tools panel.

---

## Common Failures

1. **Test imports the transport** — Tests that start the full server are slow
   and brittle. Fix: import handler functions directly, bypassing transport.

2. **Missing async handling in Python** — `@pytest.mark.asyncio` required for
   async tool handlers. Fix: add `pytest-asyncio` and `asyncio_mode = "auto"` to
   pyproject.toml.

3. **Inspector unreachable ("Cannot connect")** — Build not run before Inspector.
   Fix: `npm run build` before `npx @modelcontextprotocol/inspector node dist/index.js`.
