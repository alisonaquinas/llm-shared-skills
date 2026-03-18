# Scenario Matrix

Load when designing the test scenario matrix, choosing scenario buckets,
or deriving scenarios from the capability inventory.

---

## Scenario Buckets

Every test drive must include scenarios from these buckets:

| Bucket | Purpose | Minimum Coverage |
|---|---|---|
| Happy path | Primary tool with canonical valid input | 1 per primary tool |
| Variant | Same tool with alternate valid input (boundary, different param combination) | 1 per primary tool |
| Error recovery | Tool called with invalid input; verify graceful error return | 1 per server |
| Resource access | Fetch a resource by URI via `resources/read` | 1 if any resources declared |
| Edge case | Boundary condition or known quirk (empty string, max length, special chars) | 1 per server |

Minimum total: 5 scenarios. Target: 7–10 for comprehensive coverage.

---

## Scenario Design Rules

1. Derive each scenario directly from the capability inventory written in mcp-planning.
2. Every scenario must have a concrete, reproducible live action (specific inputs, not "try it").
3. The success check must be observable without subjective judgment.
4. Each tool should appear in at least one scenario.
5. At least one error-recovery scenario must be included, even for simple servers.
6. If the server declares resources, at least one resource scenario is required.

---

## Scenario Table Template

```markdown
| # | Bucket | Job | Tool / Resource / Prompt | Live Action | Success Check |
|---|---|---|---|---|---|
| 1 | Happy path | [what the user wants to accomplish] | [tool_name] | Call with valid input: [exact params] | [expected output or behavior] |
| 2 | Variant | [alternate use case] | [tool_name] | Call with [different params] | [expected output] |
| 3 | Error recovery | Verify bad input handled | [tool_name] | Call with [invalid/missing param] | isError: true; message contains "Error:" |
| 4 | Resource access | Read [resource description] | [resource://uri] | GET resource URI | Content returned; mimeType correct |
| 5 | Edge case | [boundary condition] | [tool_name] | Call with [edge input] | Server responds without crashing |
```

---

## Example: Filesystem Server Scenario Matrix

```markdown
| # | Bucket | Job | Tool / Resource | Live Action | Success Check |
|---|---|---|---|---|---|
| 1 | Happy path | Read a small text file | read_file | Call with path="/tmp/test.txt" | Content of test.txt returned as string |
| 2 | Happy path | List a directory | list_directory | Call with path="/tmp" | Array of filenames returned |
| 3 | Variant | Read a file with spaces in name | read_file | Call with path="/tmp/my file.txt" | Content returned correctly |
| 4 | Error recovery | Read a nonexistent file | read_file | Call with path="/tmp/does_not_exist.txt" | isError: true; "file not found" in message |
| 5 | Resource access | Fetch file as resource | file:///tmp/test.txt | GET resource | Text content returned; mimeType="text/plain" |
| 6 | Edge case | Read an empty file | read_file | Call with path="/tmp/empty.txt" | Empty string returned; no error |
| 7 | Edge case | List an empty directory | list_directory | Call with path="/tmp/empty_dir" | Empty array returned; no error |
```

---

## Running Scenarios with MCP Inspector

```bash
# TypeScript server
npx @modelcontextprotocol/inspector node dist/index.js

# Python server
npx @modelcontextprotocol/inspector python server.py
```

In the Inspector UI:
1. Open the **Tools** tab
2. Select the tool for each scenario
3. Fill in the parameter form with the Live Action inputs
4. Click **Call Tool**
5. Record the response in the outcome column

For resource scenarios:
1. Open the **Resources** tab
2. Locate the resource URI
3. Click **Read Resource**
4. Verify content and mimeType

---

## Minimum Coverage Requirements

| Server Type | Required Scenarios |
|---|---|
| Tools only | ≥1 happy path per tool; ≥1 error recovery; ≥1 edge case |
| Tools + resources | Above + ≥1 resource access scenario |
| Tools + resources + prompts | Above + ≥1 prompt retrieval scenario |

Gate: ≥5 scenarios attempted; ≥3 PASS; friction report written.

---

## Outcome Definitions

| Outcome | Meaning |
|---|---|
| PASS | Tool behaved exactly as expected; success check satisfied |
| PARTIAL | Tool responded but output was incomplete or slightly wrong; no crash |
| FAIL | Tool returned an error when success was expected, or crashed |
| BLOCKED | Scenario could not be executed due to missing infrastructure (e.g., no test database) |

BLOCKED scenarios are not failures — document them as infrastructure dependencies
in the friction report. They represent hidden prerequisites, not implementation bugs.
