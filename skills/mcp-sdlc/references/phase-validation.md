# Phase 7: Validation

Gate-focused reference for the MCP SDLC validation phase. Load when entering
or reviewing Phase 7.

---

## Pre-Entry Checklist

Before starting Phase 7:
- [ ] Phase 6 gate passed: client connects, tools visible, at least one call succeeds
- [ ] mcp-verification checklist all PASS (re-run if any code has changed since Phase 5)
- [ ] Capability inventory from Phase 1 is accessible for M02 comparison

---

## Phase 7 Deliverables

Produce all before moving to Phase 8:

1. **Scored dimensions** — M01–M06 each scored PASS / WARN / FAIL with rationale
2. **Overall verdict** — APPROVE / REVISE / REJECT
3. **Validation report** — Written using the report template

---

## Scoring Workflow

1. Re-run mcp-verification checklist (confirm all PASS)
2. Load `mcp-validation/references/mcp-quality-rubric.md`
3. Score M01 → M06 in order; document rationale for each
4. Compute verdict:
   - APPROVE: ≥5 PASS, 0 FAIL, M05 PASS
   - REVISE: 3–4 PASS, 1–2 FAIL (fixable)
   - REJECT: <3 PASS, or ≥3 FAIL, or M05 FAIL
5. Write report using `mcp-validation/references/validation-report-template.md`

---

## Quality Dimensions Summary

| ID | Dimension | Hard Gate? |
|---|---|---|
| M01 | Discoverability | No |
| M02 | Interface Completeness | No |
| M03 | Error Handling | No |
| M04 | Documentation | No |
| M05 | Safety | **Yes — FAIL = REJECT** |
| M06 | Performance | No |

---

## Gate Criterion

Phase 7 is complete when the verdict is APPROVE. REVISE requires fixing
the FAIL dimensions and re-validating. REJECT requires re-entering Phase 3
(implementation) or Phase 2 (design) based on the failure type.

---

## Common Failures

1. **M01 Discoverability** — Generic tool descriptions that don't differentiate
   tools. Fix: rewrite to state action, output, and domain for each tool.

2. **M03 Error Handling** — Uncaught exceptions that disconnect the transport.
   Fix: wrap all handlers in try/catch; return `isError: true` content.

3. **M05 Safety** — Path parameters passed directly to `fs.readFile`/`open()`
   without `path.resolve` + allowed-directory check. Fix: implement path validation
   before any filesystem access. M05 FAIL always produces REJECT.
