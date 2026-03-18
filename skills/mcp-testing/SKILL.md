---
name: mcp-testing
description: >
  Unit and integration testing phase for MCP server development. Use when writing
  tests for MCP tool handlers, setting up a test harness, using a mock MCP client,
  testing error cases and edge inputs, validating tool output structure, or running
  automated tests against a locally running MCP server. Covers Vitest and pytest
  harness setup, mock client usage, handler unit tests, and Inspector-based
  integration testing.
---

# MCP Testing

Unit tests for handlers and integration tests with a real transport.

## Intent Router

Load reference files on demand — only when the corresponding topic is active:

- `references/test-harness-setup.md` — Load when setting up Vitest (TypeScript)
  or pytest (Python) for the first time, or configuring test fixtures
- `references/mock-client-patterns.md` — Load when writing protocol-level tests,
  testing JSON-RPC message flow, or simulating a client in-process

## Quick Start — Test Pyramid

| Layer | Scope | Tool | What It Tests |
|---|---|---|---|
| Unit | Single handler function | Vitest / pytest | Input processing, output shape, error returns |
| Integration | Full server over transport | In-process client (InMemoryTransport) | Tool registration, JSON-RPC flow |
| E2E | Real client → real server | MCP Inspector / mcp-test-drive | Full scenario validation with live client |

Start at the unit layer. Reach integration testing before mcp-verification.
E2E testing belongs in mcp-test-drive.

**Install test dependencies first:**
```bash
npm install --save-dev vitest          # TypeScript
pip install pytest pytest-asyncio      # Python
```

## TypeScript Unit Test Pattern

Separate handler logic from transport wiring to enable direct imports:

```typescript
// src/tools/echo.ts
export async function echoHandler(args: { message: string }): Promise<string> {
  return args.message;
}

// tests/echo.test.ts
import { describe, it, expect } from "vitest";
import { echoHandler } from "../src/tools/echo.js";

describe("echoHandler", () => {
  it("returns message unchanged", async () => {
    expect(await echoHandler({ message: "hello" })).toBe("hello");
  });
  it("returns error string for invalid input", async () => {
    const result = await echoHandler({ message: "" });
    expect(typeof result).toBe("string");
  });
});
```

Run with: `npm test` (watch) or `npm run test:run` (single pass)

## Python Unit Test Pattern

```python
# tools/echo.py
def echo_handler(message: str) -> str:
    return message

# tests/test_echo.py
from tools.echo import echo_handler

def test_echo_returns_message():
    assert echo_handler("hello") == "hello"

def test_echo_empty_string():
    assert echo_handler("") == ""
```

Run with: `pytest`

## MCP Inspector Integration

Run the Inspector to test the full server over a real transport:

```bash
# TypeScript (build first)
npm run build
npx @modelcontextprotocol/inspector node dist/index.js

# Python
npx @modelcontextprotocol/inspector python server.py
```

The Inspector opens a browser UI. Use the Tools panel to call each tool interactively
and inspect raw JSON-RPC messages. Verify: all tools appear, all calls return valid
content, error cases return `isError: true`.

Load `references/mock-client-patterns.md` for in-process integration tests that
run without the Inspector browser UI.

## Error Case Coverage

Every tool must be tested for these error cases before mcp-verification:

```
[ ] Missing required parameter → returns error content, not exception
[ ] Wrong parameter type → handled gracefully
[ ] Handler throws exception → caught and returned as isError: true
[ ] Resource not found → descriptive error message returned
[ ] Empty string parameter → handled without crash
```

## Gate

mcp-testing is complete when:
- All unit tests pass (`npm run test:run` or `pytest`)
- Error case checklist above is fully covered
- Inspector shows all tools and at least one tool call returns a valid response

Proceed to mcp-verification only after unit tests pass and Inspector confirms
tool registration.

## Safety Notes

Never point tests at production data sources, live APIs, or shared databases.
Use in-memory stubs, fixtures, and temporary directories for all test data.
Tests that modify state should clean up in `afterEach` / teardown fixtures.

## Resource Index

| Reference File | Load When |
|---|---|
| `references/test-harness-setup.md` | First-time setup of Vitest or pytest |
| `references/mock-client-patterns.md` | Writing in-process integration tests; PreToolCall hook debugging |
