---
name: mcp-validation
description: >
  Quality and completeness validation phase for MCP server development. Use when
  scoring an MCP server against a quality rubric, evaluating tool discoverability,
  checking interface completeness, assessing error handling quality, reviewing
  documentation, validating safety properties, or determining if a server is ready
  for production use. Covers six quality dimensions scored as PASS, WARN, or FAIL
  with an overall APPROVE, REVISE, or REJECT verdict.
---

# MCP Validation

Quality scoring against six dimensions before production use.

## Intent Router

Load reference files on demand — only when the corresponding topic is active:

- `references/mcp-quality-rubric.md` — Load to score each dimension; contains
  PASS/WARN/FAIL thresholds, examples, and fix recipes for M01–M06
- `references/validation-report-template.md` — Load when producing the
  validation report

## Quick Start — Quality Dimensions

| ID | Dimension | Focus |
|---|---|---|
| M01 | Discoverability | Tool names and descriptions enable correct client routing |
| M02 | Interface Completeness | All planned tools/resources/prompts present and callable |
| M03 | Error Handling | Graceful degradation; proper JSON-RPC error responses; no crashes |
| M04 | Documentation | README present; tool descriptions complete; examples included |
| M05 | Safety | No credential leakage; input validation; path traversal prevention |
| M06 | Performance | Connection lifecycle managed; no resource leaks; prompt startup |

Run mcp-verification before scoring — a server that fails the verification
checklist cannot receive valid dimension scores.

## Scoring Workflow

1. Run the mcp-verification checklist — confirm all items PASS
2. Load `references/mcp-quality-rubric.md`
3. Score each dimension M01–M06 as PASS, WARN, or FAIL
4. Document rationale for each score (1–2 sentences)
5. Compute overall verdict using the thresholds below
6. Load `references/validation-report-template.md` and write the report

## Verdict Thresholds

| Verdict | Condition |
|---|---|
| **APPROVE** | ≥5 dimensions PASS; 0 dimensions FAIL; M05 Safety = PASS |
| **REVISE** | 3–4 PASS; 1–2 FAIL (fixable); resubmit after fixes |
| **REJECT** | <3 PASS; or ≥3 FAIL; or M05 FAIL (safety block) |

M05 (Safety) is a hard gate — a Safety FAIL always produces REJECT regardless
of other dimension scores.

## Common Failures

**M01:** Generic tool descriptions ("Process the input"), tool names that don't
hint at their function. Fix: rewrite descriptions to state action, output, and
domain clearly.

**M03:** Uncaught exceptions in handlers that crash the server or disconnect the
transport. Fix: wrap all handler code in try/catch; return `isError: true` content.

**M05:** Path parameters passed directly to `fs.readFile` or `open()` without
`path.resolve()` validation. Fix: use an allowed-directory check before any
file system access.

## Safety Notes

Score M05 with particular care — a server that exposes path traversal or shell
injection vulnerabilities must not ship regardless of other scores. Load
`references/mcp-quality-rubric.md` M05 section for specific fix recipes.

## Resource Index

| Reference File | Load When |
|---|---|
| `references/mcp-quality-rubric.md` | Scoring any dimension; fix recipes |
| `references/validation-report-template.md` | Writing the final validation report |
