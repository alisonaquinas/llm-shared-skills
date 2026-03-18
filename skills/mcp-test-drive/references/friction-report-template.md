# Friction Report Template

Load when recording scenario outcomes and producing the final friction report.
Copy this template and fill in each section after executing the scenario matrix.

---

## Template

```markdown
# MCP Test Drive Friction Report: <server-name>

**Date:** YYYY-MM-DD
**Server version:** x.y.z
**Inspector version:** (output of `npx @modelcontextprotocol/inspector --version`)
**Scenarios attempted:** N
**Scenarios PASS:** N | PARTIAL: N | FAIL: N | BLOCKED: N

---

## Scenario Results

| # | Bucket | Tool / Resource | Outcome | Notes |
|---|---|---|---|---|
| 1 | Happy path | [tool_name] | PASS / PARTIAL / FAIL / BLOCKED | [observations] |
| 2 | Variant | [tool_name] | PASS / PARTIAL / FAIL / BLOCKED | [observations] |
| 3 | Error recovery | [tool_name] | PASS / PARTIAL / FAIL / BLOCKED | [observations] |
| 4 | Resource access | [resource://uri] | PASS / PARTIAL / FAIL / BLOCKED | [observations] |
| 5 | Edge case | [tool_name] | PASS / PARTIAL / FAIL / BLOCKED | [observations] |

---

## Friction Items

List each point of friction encountered during the test drive:

- **[category]:** [description of the issue] → [suggested fix]

Categories:
- routing — tool name or description caused wrong tool selection
- completeness — tool or resource missing from server
- error-shape — error response not in expected format
- safety — input not validated; potential security issue
- latency — tool hung, timed out, or was unusually slow
- documentation — usage unclear; params ambiguous

---

## BLOCKED Scenario Dependencies

List any BLOCKED scenarios and what infrastructure they require:

- Scenario N: requires [database / external API / specific file / etc.] at [location/URL]

---

## Verdict

**Overall:** approve / revise / re-test

**Rationale:** [1–2 sentences explaining the verdict]

**Gate check:**
- Scenarios attempted: N ≥ 5? [YES / NO]
- Scenarios PASS: N ≥ 3? [YES / NO]
- Friction report complete? [YES]

**Re-entry recommendation (if revise or re-test):**
- [Which phase to re-enter and why]
```

---

## Friction Category Guide

Use these categories consistently to make the report actionable:

| Category | Examples | Typical Fix Phase |
|---|---|---|
| routing | Tool named `process` called instead of `transform_text`; description too generic | mcp-design (rename/redescribe) |
| completeness | `search` tool missing from tools/list; resource URI 404 | mcp-creation (implement) |
| error-shape | Error thrown as exception not returned as content; `isError` missing | mcp-creation (error handling) |
| safety | Path parameter not validated; raw user input in shell command | mcp-creation (add validation) |
| latency | Tool times out on large input; startup takes >10 seconds | mcp-creation (optimize) |
| documentation | Unclear what unit `limit` param uses; missing example in README | mcp-validation (M04) |

---

## Example Completed Report

```markdown
# MCP Test Drive Friction Report: filesystem-server

**Date:** 2026-03-18
**Scenarios attempted:** 7 | PASS: 6 | PARTIAL: 1 | FAIL: 0 | BLOCKED: 0

## Scenario Results

| # | Bucket | Tool / Resource | Outcome | Notes |
|---|---|---|---|---|
| 1 | Happy path | read_file | PASS | Returned file content correctly |
| 2 | Happy path | list_directory | PASS | Returned array of filenames |
| 3 | Variant | read_file | PASS | File with spaces in name read correctly |
| 4 | Error recovery | read_file | PASS | isError: true returned for missing file |
| 5 | Resource access | file:///tmp/test.txt | PASS | Content and mimeType correct |
| 6 | Edge case | read_file (empty file) | PASS | Empty string returned, no error |
| 7 | Edge case | list_directory (empty dir) | PARTIAL | Returns empty array but also logs to stderr; minor issue |

## Friction Items

- **documentation:** The `path` parameter description says "file path" without specifying
  whether absolute or relative paths are accepted → Clarify in description: "Absolute path to the file"
- **error-shape:** Error message for missing file says "ENOENT" (Node error code) rather
  than a human-readable message → Change to "File not found at {path}"

## BLOCKED Scenario Dependencies

None.

## Verdict

**Overall:** approve

**Rationale:** 6 of 7 scenarios PASS, 1 PARTIAL (minor stderr logging issue, not a
functional problem), 0 FAIL. Server is ready to ship with minor documentation improvements.

**Gate check:**
- Scenarios attempted: 7 ≥ 5? YES
- Scenarios PASS: 6 ≥ 3? YES
- Friction report complete? YES
```
