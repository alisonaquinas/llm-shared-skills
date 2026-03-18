# MCP Quality Rubric

Load when scoring any quality dimension M01–M06. Contains PASS/WARN/FAIL
criteria and fix recipes for each dimension.

---

## M01: Discoverability

**What it measures:** Whether tool names and descriptions allow a language model
to correctly select and invoke the right tool.

| Score | Criteria |
|---|---|
| PASS | All tool names follow verb_noun snake_case; all descriptions ≤100 words and state what the tool does, what it returns, and any side effects |
| WARN | Minor naming issues (abbreviations, slight vagueness) but tools are generally distinguishable; descriptions are present but incomplete |
| FAIL | Generic names (`process`, `handle`, `do_thing`); descriptions missing, one-word, or misleading; tools with identical or near-identical descriptions |

**Fix recipes:**
- Generic name: rename to `verb_noun` pattern (`process` → `transform_text`)
- Vague description: rewrite to state action, output, and side effect explicitly
- Duplicate descriptions: differentiate by stating input type or domain clearly

---

## M02: Interface Completeness

**What it measures:** Whether the server exposes all tools, resources, and prompts
documented in the capability inventory from the planning phase.

| Score | Criteria |
|---|---|
| PASS | All planned tools registered and callable; all declared resources readable; all declared prompts retrievable |
| WARN | 1–2 planned items missing but server is still useful; missing items are optional/low-priority |
| FAIL | Core tools missing; server cannot perform its primary function; >2 planned items absent |

**Fix recipes:**
- Missing tool: implement the handler and register it in `ListToolsRequestSchema`
- Missing resource: implement `ReadResourceRequestSchema` handler for that URI
- Return to mcp-design to update the capability inventory if scope has changed

---

## M03: Error Handling

**What it measures:** Whether the server handles errors gracefully without crashing,
and whether error responses are informative and follow the JSON-RPC error format.

| Score | Criteria |
|---|---|
| PASS | All tool handlers catch exceptions and return `isError: true` with a descriptive message; server never crashes on bad input; error messages are actionable |
| WARN | Most errors handled; some edge cases (e.g., very large input, unusual characters) may cause issues; error messages exist but are generic |
| FAIL | Uncaught exceptions crash the server or disconnect the transport; error messages are missing or uninformative; `isError` field absent from error responses |

**Fix recipes:**
- Uncaught exception: wrap handler body in try/catch; return `{content: [{type: "text", text: "Error: ..."}], isError: true}`
- Missing `isError`: add `isError: true` to all error response objects
- Uninformative message: include the error type and affected parameter in the message

**FastMCP note:** In Python FastMCP, raising an exception inside a tool handler
automatically produces `isError: true`. Catching the exception and returning a
plain string produces `isError: false` (content only). To get M03 PASS with
FastMCP, either `raise` exceptions or explicitly use `mcp.types.TextContent` with
`isError: true` in the response.

---

## M04: Documentation

**What it measures:** Whether the server's README and inline documentation are
sufficient for a new user to install, configure, and use the server.

| Score | Criteria |
|---|---|
| PASS | README present with: purpose, installation steps, client configuration snippet, full tool list with descriptions and example invocations |
| WARN | README present but missing installation steps or example invocations; tool descriptions are in code but not in README |
| FAIL | No README; README present but has no usage examples or tool list; tool descriptions in `inputSchema` are missing or single-word |

**Fix recipes:**
- Missing README: create `README.md` at project root with the sections above
- Missing examples: add one example input and output per tool
- Missing tool list: add a table with tool name, description, and required params

---

## M05: Safety

**What it measures:** Whether the server protects against credential leakage,
path traversal, shell injection, and other security vulnerabilities.

| Score | Criteria |
|---|---|
| PASS | All path parameters validated against allowed directories; no shell metacharacters passed to exec/spawn; no credentials in logs or tool responses; input validation present on all string parameters that touch the filesystem or network |
| WARN | Basic validation present; edge cases not fully covered (e.g., symlink traversal not checked); no credential leakage but validation is incomplete |
| FAIL | Path parameters passed directly to `fs.readFile` or `open()` without validation; user input concatenated into shell commands; API keys or tokens appear in tool response content or logs |

**Fix recipes — Path Traversal:**
```typescript
import path from "path";
const ALLOWED_DIR = "/safe/directory";
function safePath(inputPath: string): string {
  const resolved = path.resolve(ALLOWED_DIR, inputPath);
  if (!resolved.startsWith(ALLOWED_DIR)) {
    throw new Error("Path traversal attempt blocked");
  }
  return resolved;
}
```

**Fix recipes — Shell Injection:**
Never concatenate user input into shell commands. Use argument arrays:
```typescript
// Wrong
exec(`ls ${userInput}`);

// Correct
execFile("ls", [userInput]);
```

**Fix recipes — Credential Leakage:**
```typescript
// Wrong — API key in response
return { content: [{ type: "text", text: `Key: ${apiKey}, result: ${data}` }] };

// Correct
return { content: [{ type: "text", text: data }] };
```

---

## M06: Performance

**What it measures:** Whether the server manages its connection lifecycle cleanly,
avoids resource leaks, and starts up promptly.

| Score | Criteria |
|---|---|
| PASS | Server starts within 3 seconds; file handles, DB connections, and HTTP connections are closed when done; SIGINT handler shuts down cleanly; no memory leaks on repeated tool calls |
| WARN | Startup is slow (3–10 seconds) due to heavy initialization; minor resource leaks that self-correct; SIGINT not handled but process terminates |
| FAIL | Server startup takes >10 seconds; file handles or DB connections leak on repeated calls; process becomes unresponsive over time; port left bound after crash |

**Fix recipes:**
- Slow startup: defer heavy initialization (DB connection pooling, model loading) until first tool call
- Resource leak: use `try/finally` to close handles; use connection pools with max size
- No SIGINT handler (TypeScript):
  ```typescript
  process.on("SIGINT", async () => {
    await server.close();
    process.exit(0);
  });
  ```
- No SIGINT handler (Python FastMCP): FastMCP handles this automatically via `mcp.run()`
