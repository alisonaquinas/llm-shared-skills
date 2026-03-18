# Iteration Patterns

Load when deciding which phase to re-enter after a failure, recovering from
a partial development cycle, or determining whether to iterate or ship.

---

## Re-Entry Decision Tree

Answer these questions in order to find the correct re-entry point:

1. **Did Phase 5 (Verification) fail?**
   → Re-enter Phase 3 (Creation). Fix handler or startup; rebuild; re-verify.
   Skip Phases 1 and 2.

2. **Did Phase 7 (Validation) fail on M01 or M02 (Discoverability/Completeness)?**
   → Re-enter Phase 2 (Design). Revise tool names, descriptions, or add missing tools.
   Then re-enter Phase 3, 5, 6, 7 in order.

3. **Did Phase 7 (Validation) fail on M03, M05, or M06 (implementation dimensions)?**
   → Re-enter Phase 3 (Creation). Fix error handling, safety checks, or performance.
   Then re-enter Phase 5, 6, 7 in order.

4. **Did Phase 7 (Validation) fail on M04 only (Documentation)?**
   → Fix documentation in place. Re-run Phase 7 only. No phase re-entry required.

5. **Did Phase 8 (Test Drive) return FAIL on a tool scenario?**
   → Tool output wrong → re-enter Phase 3. Tool missing → re-enter Phase 2.

6. **Did Phase 8 (Test Drive) return mostly PARTIAL?**
   → Re-enter Phase 7 (Validation re-score). If validation confirms APPROVE,
   the PARTIALs are acceptable.

7. **Did M01 fail twice after two Phase 2 re-entries?**
   → Re-enter Phase 1 (Planning). Split the capability inventory into two
   narrower servers. All phases need rework.

---

## Loop Patterns Table

| Failure Mode | Re-Entry Phase | Phases to Skip |
|---|---|---|
| Verification FAIL (schema) | Phase 3 (Creation) | Phases 1, 2 |
| Verification FAIL (protocol) | Phase 3 (Creation) | Phases 1, 2 |
| Validation FAIL M01/M02 | Phase 2 (Design) | Phase 1 |
| Validation FAIL M03/M05/M06 | Phase 3 (Creation) | Phases 1, 2 |
| Validation FAIL M04 only | Fix in place | All phases |
| Test drive FAIL (wrong output) | Phase 3 (Creation) | Phases 1, 2 |
| Test drive FAIL (tool missing) | Phase 2 (Design) | Phase 1 |
| Test drive PARTIAL | Phase 7 (Validation re-score) | Phases 1–6 |
| Integration FAIL (connection) | Phase 3 (rebuild) | Phases 1, 2 |
| Repeated M01 FAIL (2+ cycles) | Phase 1 (Planning — scope split) | None |

---

## Iterate vs Ship

**Ship when:**
- Phase 5 verification checklist: all items PASS
- Phase 7 validation verdict: APPROVE (≥5 PASS, 0 FAIL, M05 PASS)
- Phase 8 test drive: ≥5 attempted, ≥3 PASS, friction report written
- All BLOCKED scenarios documented with infrastructure requirements

**Iterate when:**
- Any Phase 5 item is FAIL
- Phase 7 verdict: REVISE or REJECT
- Fewer than 3 Phase 8 scenarios PASS
- M05 Safety is FAIL or WARN with a confirmed vulnerability

---

## Partial Completion Recovery

Inspect these artifacts to find the highest completed phase:

1. Server project directory exists → Phase 1 done
2. Tool schema list / interface contract written → Phase 2 done
3. Server starts; tools/list returns all tools → Phase 3 done
4. Unit tests exist and pass → Phase 4 done
5. Verification checklist all PASS → Phase 5 done (re-run if uncertain)
6. Client connects; tools visible in UI → Phase 6 done
7. Validation report with APPROVE verdict → Phase 7 done
8. Friction report with ≥5 scenarios → Phase 8 done

Start from the highest confirmed completed phase — never from Phase 1 unless scope changed.

**Conservative default for Phase 5:** if no record of a recent verification run
exists, assume incomplete and re-run. The cost is low; the risk of a protocol
regression reaching a client is high.

---

## Escalation

When M01 (Discoverability) fails repeatedly after two Phase 2 re-entries:
- The server is doing too many distinct things
- Split the capability inventory into two narrower servers
- Re-enter Phase 1 and define tighter, single-domain scope for each server
