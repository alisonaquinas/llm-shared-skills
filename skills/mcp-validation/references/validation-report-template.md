# Validation Report Template

Load when writing the final MCP validation report. Copy this template and fill in
each section with findings from the scoring session.

---

## Template

```markdown
# MCP Validation Report: <server-name>

**Date:** YYYY-MM-DD
**Server version:** x.y.z
**Validator:** (the agent / reviewer name)

---

## Pre-Flight (mcp-verification Checklist)

| Check | Result |
|---|---|
| Server starts without errors | PASS / FAIL |
| tools/list returns all declared tools | PASS / FAIL |
| Each tool has valid name, description, inputSchema | PASS / FAIL |
| inputSchema passes JSON Schema Draft 7 | PASS / FAIL |
| tools/call responds with correct content format | PASS / FAIL |
| Error responses follow JSON-RPC 2.0 structure | PASS / FAIL |
| No non-JSON output on stdout (stdio servers) | PASS / FAIL |

Pre-flight result: **PASS / FAIL**
(If any pre-flight item is FAIL, stop here and fix before scoring dimensions)

---

## Dimension Scores

| ID | Dimension | Score | Rationale |
|---|---|---|---|
| M01 | Discoverability | PASS / WARN / FAIL | [1–2 sentence rationale] |
| M02 | Interface Completeness | PASS / WARN / FAIL | [1–2 sentence rationale] |
| M03 | Error Handling | PASS / WARN / FAIL | [1–2 sentence rationale] |
| M04 | Documentation | PASS / WARN / FAIL | [1–2 sentence rationale] |
| M05 | Safety | PASS / WARN / FAIL | [1–2 sentence rationale] |
| M06 | Performance | PASS / WARN / FAIL | [1–2 sentence rationale] |

---

## Summary

**Overall verdict:** APPROVE / REVISE / REJECT

**Verdict rationale:** [1–2 sentences explaining the overall verdict]

**Blocking issues (FAIL dimensions):**
- [List each FAIL dimension and the specific issue]
- (none if all dimensions PASS or WARN)

**Recommended fixes (ordered by severity):**
1. [Most critical fix — typically M05 Safety or M03 Error Handling]
2. [Next fix]
3. [Minor improvements — M01, M04]

**Re-entry point after fixes:**
- All fixes in implementation → re-enter mcp-creation, then re-verify and re-validate
- Interface fixes → re-enter mcp-design, then re-create, re-verify, re-validate
- Documentation only → fix in place, re-validate M04 only

---

## Appendix: Tool Inventory

| Tool Name | Description Summary | Required Params | Optional Params |
|---|---|---|---|
| [tool_name] | [what it does] | [list] | [list] |
```

---

## Verdict Threshold Reference

| Verdict | Condition |
|---|---|
| **APPROVE** | ≥5 dimensions PASS; 0 dimensions FAIL; M05 Safety = PASS |
| **REVISE** | 3–4 PASS; 1–2 FAIL (fixable); M05 may be WARN; resubmit after fixes |
| **REJECT** | <3 PASS; or ≥3 FAIL; or M05 FAIL (safety block) |

---

## Example Completed Report

```markdown
# MCP Validation Report: filesystem-server

**Date:** 2026-03-18
**Server version:** 1.0.0

## Pre-Flight

| Check | Result |
|---|---|
| Server starts without errors | PASS |
| tools/list returns all declared tools | PASS |
| Each tool has valid name, description, inputSchema | PASS |
| inputSchema passes JSON Schema Draft 7 | PASS |
| tools/call responds with correct content format | PASS |
| Error responses follow JSON-RPC 2.0 structure | PASS |
| No non-JSON output on stdout | PASS |

Pre-flight result: **PASS**

## Dimension Scores

| ID | Dimension | Score | Rationale |
|---|---|---|---|
| M01 | Discoverability | PASS | Tool names follow verb_noun pattern; descriptions state action and output |
| M02 | Interface Completeness | PASS | All 4 planned tools present and callable |
| M03 | Error Handling | WARN | Most errors handled; directory-not-found case returns generic message |
| M04 | Documentation | WARN | README present but missing example invocations |
| M05 | Safety | PASS | Path validation present; uses path.resolve with allowedDir check |
| M06 | Performance | PASS | Starts in <1s; file handles closed in finally blocks |

## Summary

**Overall verdict:** APPROVE

**Verdict rationale:** Five dimensions PASS, one WARN each on M03 and M04, no FAILs,
M05 Safety passes — server is ready to ship with minor documentation improvements recommended.

**Blocking issues:** None

**Recommended fixes:**
1. M04: Add example invocations to README for each tool
2. M03: Improve directory-not-found error message to include the attempted path
```
