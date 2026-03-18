---
name: mcp-iterative-development
description: >
  Iteration loop management for MCP server development. Use when a phase has
  failed and the correct re-entry point must be determined, when deciding whether
  to re-enter planning versus design versus implementation, when recovering from
  a partial development cycle, or when repeated failures indicate a deeper
  structural problem. Covers re-entry decision trees, loop patterns for each
  failure mode, partial completion recovery, and escalation criteria.
---

# MCP Iterative Development

Re-entry decisions and loop management across MCP SDLC phases.

## Intent Router

Load reference files on demand — only when the corresponding topic is active:

- `references/re-entry-decision-tree.md` — Load when determining which phase
  to re-enter after any failure; contains the full decision tree, loop patterns
  table, partial completion recovery checklist, and escalation criteria

## Quick Start — Re-Entry Table

| Failure Mode | Re-Entry Phase | Phases to Skip |
|---|---|---|
| Verification FAIL (schema invalid) | mcp-creation | mcp-planning, mcp-design |
| Verification FAIL (protocol error) | mcp-creation | mcp-planning, mcp-design |
| Validation FAIL M01 Discoverability | mcp-design | mcp-planning |
| Validation FAIL M02 Completeness | mcp-design | mcp-planning |
| Validation FAIL M03 Error Handling | mcp-creation | mcp-planning, mcp-design |
| Validation FAIL M04 Documentation | Fix in place | All phases (no re-entry) |
| Validation FAIL M05 Safety | mcp-creation | mcp-planning, mcp-design |
| Validation FAIL M06 Performance | mcp-creation | mcp-planning, mcp-design |
| Test drive FAIL (wrong output) | mcp-creation | mcp-planning, mcp-design |
| Test drive FAIL (tool missing) | mcp-design | mcp-planning |
| Test drive PARTIAL | mcp-validation (re-score) | mcp-planning through mcp-testing |
| Integration FAIL (connection) | mcp-creation (rebuild) | mcp-planning, mcp-design |
| Repeated M01 FAIL (2+ cycles) | mcp-planning (scope split) | None — full rework |

## Re-Entry Decision Tree

Answer these questions in order to find the correct re-entry point:

1. **Did mcp-verification fail?** → Re-enter **mcp-creation**
2. **Did mcp-validation fail on M01 or M02?** → Re-enter **mcp-design**
3. **Did mcp-validation fail on M03, M05, or M06?** → Re-enter **mcp-creation**
4. **Did mcp-validation fail on M04 only?** → Fix documentation in place
5. **Did test drive scenarios FAIL?** → mcp-creation (wrong output) or mcp-design (missing tool)
6. **Did test drive return mostly PARTIAL?** → Re-enter **mcp-validation** for re-scoring
7. **Did M01 fail twice after design fixes?** → Re-enter **mcp-planning** (scope split)

**Multiple simultaneous FAILs:** When several dimensions fail together, apply the
re-entry in the highest-priority order above. Fix code issues first (M03/M05/M06
via mcp-creation), then re-run mcp-verification and re-score mcp-validation. Fix
documentation (M04) last — after code fixes pass validation — since documentation
changes do not require another verification run.

Load `references/re-entry-decision-tree.md` for the extended version with rationale
and partial completion recovery checklist.

## Iterate vs Ship

**Ship when:**
- mcp-verification checklist: all items PASS
- mcp-validation verdict: APPROVE (≥5 PASS, 0 FAIL, M05 PASS)
- mcp-test-drive: ≥5 scenarios attempted, ≥3 PASS, friction report written
- All BLOCKED scenarios documented with infrastructure requirements

**Iterate when:**
- Any mcp-verification item is FAIL
- mcp-validation verdict: REVISE or REJECT
- Fewer than 3 test-drive scenarios PASS
- M05 Safety is FAIL or WARN with a confirmed vulnerability

## Partial Completion Recovery

Inspect these artifacts to find the highest completed phase:

1. Server project directory exists → mcp-planning done
2. Tool schema list / design doc exists → mcp-design done
3. Server starts and `tools/list` responds → mcp-creation done
4. Unit tests exist and pass → mcp-testing done
5. Verification checklist all PASS (re-run if uncertain) → mcp-verification done
6. Client connects and tools visible → mcp-integration done
7. Validation report with APPROVE verdict exists → mcp-validation done
8. Friction report with ≥5 scenarios exists → mcp-test-drive done

Start from the highest confirmed completed phase.

## Safety Notes

Never skip mcp-verification after any change to handler code — even documentation
fixes can inadvertently alter behavior. The cost of a re-run is low; the cost of
a protocol regression reaching a client is high.

## Resource Index

| Reference File | Load When |
|---|---|
| `references/re-entry-decision-tree.md` | Determining re-entry point; recovering partial state; escalation |
