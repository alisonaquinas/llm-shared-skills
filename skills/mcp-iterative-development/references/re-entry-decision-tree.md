# Re-Entry Decision Tree

Load when determining which phase to re-enter after any failure, recovering
from a partial development cycle, or deciding whether to iterate or ship.

---

## Re-Entry Decision Tree

Answer these questions in order to find the correct re-entry point:

1. **Did mcp-verification fail (schema or protocol error)?**
   → Re-enter **mcp-creation**. Fix the handler or startup code, rebuild,
   re-run mcp-verification. Skip mcp-planning and mcp-design.

2. **Did mcp-validation fail on M01 (Discoverability) or M02 (Interface Completeness)?**
   → Re-enter **mcp-design**. Redesign tool names, descriptions, or add missing tools.
   After design changes, re-create, re-verify, re-validate. Skip mcp-planning.

3. **Did mcp-validation fail on M03 (Error Handling) or M05 (Safety)?**
   → Re-enter **mcp-creation**. Fix handler error handling or add input validation.
   Re-verify and re-validate. Skip mcp-planning and mcp-design.

4. **Did mcp-validation fail on M04 (Documentation) only?**
   → Fix documentation in place (README, tool descriptions). Re-validate M04 only.
   No phase re-entry required.

5. **Did mcp-validation fail on M06 (Performance) only?**
   → Re-enter **mcp-creation** for the specific optimization. Re-verify and re-validate.

6. **Did mcp-test-drive return FAIL on a tool scenario?**
   → Inspect the failure: tool missing → re-enter **mcp-design**; wrong output
   → re-enter **mcp-creation**. Re-verify and re-validate after fixes.

7. **Did mcp-test-drive return PARTIAL on most scenarios?**
   → Re-enter **mcp-validation** (re-score after examining PARTIAL patterns).
   If validation confirms APPROVE, the PARTIALs are acceptable.

8. **Did mcp-integration fail (client cannot connect)?**
   → Check whether the build is stale (re-run `npm run build`/`python` check).
   If build is current, re-enter **mcp-creation** to fix startup. If build is the
   issue, rebuild and re-integrate without any authoring changes.

9. **Did M01 fail twice after two separate mcp-design re-entries?**
   → Re-enter **mcp-planning**. The server scope is too broad — split into two
   narrower servers with clearer single-domain purposes.

---

## Loop Patterns Table

| Failure Mode | Re-Entry Phase | Phases to Skip |
|---|---|---|
| Verification FAIL (schema invalid) | mcp-creation | mcp-planning, mcp-design |
| Verification FAIL (protocol error) | mcp-creation | mcp-planning, mcp-design |
| Validation FAIL M01 Discoverability | mcp-design | mcp-planning |
| Validation FAIL M02 Completeness | mcp-design | mcp-planning |
| Validation FAIL M03 Error Handling | mcp-creation | mcp-planning, mcp-design |
| Validation FAIL M04 Documentation | Fix in place | All (no phase re-entry) |
| Validation FAIL M05 Safety | mcp-creation | mcp-planning, mcp-design |
| Validation FAIL M06 Performance | mcp-creation | mcp-planning, mcp-design |
| Test drive FAIL (wrong output) | mcp-creation | mcp-planning, mcp-design |
| Test drive FAIL (tool missing) | mcp-design | mcp-planning |
| Test drive PARTIAL | mcp-validation (re-score) | mcp-planning through mcp-testing |
| Integration FAIL (connection) | mcp-creation (rebuild) | mcp-planning, mcp-design |
| Repeated M01 FAIL (2+ cycles) | mcp-planning (scope split) | None — all phases need rework |

---

## Iterate vs Ship

**Ship when all of these are true:**

- mcp-verification checklist: all items PASS
- mcp-validation verdict: APPROVE (≥5 PASS, 0 FAIL, M05 PASS)
- mcp-test-drive: ≥5 scenarios attempted, ≥3 PASS, friction report written
- All BLOCKED scenarios documented with their infrastructure requirements

**Iterate when any of these is true:**

- Any mcp-verification item FAIL
- mcp-validation verdict: REVISE or REJECT
- Fewer than 3 test-drive scenarios PASS
- M05 (Safety) is FAIL or WARN with a confirmed vulnerability
- Uncaught exception discovered during test drive

---

## Partial Completion Recovery

When resuming a development cycle mid-stream, inspect existing artifacts to find
the highest completed phase:

1. Does `skills/<name>/` or the server project directory exist?
   → mcp-planning is done.

2. Does a design document or tool schema list exist?
   → mcp-design is done.

3. Does the server start and respond to `tools/list`?
   → mcp-creation is done.

4. Do unit tests exist and pass?
   → mcp-testing is done.

5. Has the mcp-verification checklist been run with all PASS?
   → mcp-verification is done. Conservative default: re-run verification if no
   recent run is confirmed — rebuild first.

6. Does the client connect and show all tools?
   → mcp-integration is done.

7. Does a validation report exist with APPROVE verdict?
   → mcp-validation is done.

8. Does a friction report exist with ≥5 scenarios?
   → mcp-test-drive is done.

Start from the highest confirmed completed phase — do not restart from mcp-planning
unless the scope itself has changed.

---

## Escalation

**When M01 (Discoverability) fails repeatedly after two full mcp-design re-entries:**

The server is attempting to do too many distinct things. Characteristics:

- Tool descriptions overlap or conflict
- Tools from different domains are in the same server
- The "purpose statement" from mcp-planning covers more than one domain

Action: Re-enter mcp-planning. Split the capability inventory into two separate
servers, each with a single clear domain. A server that does one thing well is
always more discoverable than one that does many things.

**When mcp-verification fails repeatedly after mcp-creation re-entries:**

The SDK version in use may not match the protocol version expected by the client.

Action: Check `@modelcontextprotocol/sdk` version (TypeScript) or `mcp` package
version (Python). Update to the latest stable version and re-verify.
