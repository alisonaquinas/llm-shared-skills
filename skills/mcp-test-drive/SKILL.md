---
name: mcp-test-drive
description: >
  Live scenario testing phase for MCP server development. Use when running
  end-to-end tests against a running MCP server, designing a scenario matrix
  covering happy path and edge cases, testing error recovery behavior, validating
  real tool calls through the MCP Inspector or a live client, or producing a
  friction report with improvement recommendations. Requires a running server
  and the MCP Inspector or a connected client.
---

# MCP Test Drive

End-to-end scenario testing against a live MCP server.

## Intent Router

Load reference files on demand — only when the corresponding topic is active:

- `references/scenario-matrix.md` — Load when designing the 5–7 scenario matrix,
  choosing scenario buckets, or deriving scenarios from the capability inventory
- `references/friction-report-template.md` — Load when recording outcomes and
  producing the final friction report

## Quick Start — Inspector Setup

```bash
# TypeScript server (build first: npm run build)
npx @modelcontextprotocol/inspector node dist/index.js

# Python server
npx @modelcontextprotocol/inspector python server.py
```

The Inspector opens a browser UI. Use the Tools and Resources panels to
execute scenarios interactively and inspect raw JSON-RPC messages.

## Scenario Matrix

Design at least 5 scenarios before executing any. Load `references/scenario-matrix.md`
for bucket definitions and derivation rules. Inline template:

| # | Bucket | Job | Tool / Resource / Prompt | Live Action | Success Check |
|---|---|---|---|---|---|
| 1 | Happy path | Primary tool with valid input | [tool_name] | Call with [exact params] | Expected output returned |
| 2 | Variant | Alternate valid input | [tool_name] | Call with [different params] | Valid response returned |
| 3 | Error recovery | Invalid input handled | [tool_name] | Pass missing/invalid param | isError: true; message contains "Error:" |
| 4 | Resource access | Read a declared resource | [resource://uri] | GET resource | Content + mimeType correct |
| 5 | Edge case | Boundary condition | [tool_name] | [edge input] | No crash; graceful response |

## Outcome Scoring

Record one outcome per scenario:

| Outcome | Meaning |
|---|---|
| PASS | Tool behaved exactly as expected; success check satisfied |
| PARTIAL | Tool responded but output was incomplete or slightly wrong |
| FAIL | Error when success was expected, or server crashed |
| BLOCKED | Scenario could not run due to missing infrastructure |

BLOCKED scenarios are not failures — document their infrastructure requirements.

## Friction Categories for MCP

After recording outcomes, classify each friction point:

- **routing** — tool name/description caused wrong tool selection
- **completeness** — tool or resource missing from server
- **error-shape** — error response not in expected format
- **safety** — input not validated; potential security issue
- **latency** — tool hung, timed out, or was unusually slow
- **documentation** — usage unclear; parameters ambiguous

## Gate

≥5 scenarios attempted; ≥3 PASS; friction report written.
Load `references/friction-report-template.md` for the report format.

## Safety Notes

Run all test-drive scenarios against a local development server only. Never
connect the Inspector to a production server — it has full control over the
server process lifecycle.

## Resource Index

| Reference File | Load When |
|---|---|
| `references/scenario-matrix.md` | Designing the scenario matrix; bucket definitions |
| `references/friction-report-template.md` | Recording outcomes; writing the friction report |
