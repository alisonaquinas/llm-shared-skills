# Phase 8: Test Drive

Gate-focused reference for the MCP SDLC test drive phase. Load when entering
or reviewing Phase 8.

---

## Pre-Entry Checklist

Before starting Phase 8:
- [ ] Phase 7 gate passed: validation verdict is APPROVE
- [ ] Server is running locally
- [ ] MCP Inspector is available (`npx @modelcontextprotocol/inspector --version`)
- [ ] Scenario matrix designed (≥5 scenarios, all buckets covered)

---

## Phase 8 Deliverables

Produce all before moving to Phase 9 or Phase 10:

1. **Executed scenario matrix** — ≥5 scenarios with recorded outcomes
2. **Friction report** — Written with all friction items and BLOCKED dependencies documented
3. **Verdict** — approve / revise / re-test

---

## Inspector Commands

```bash
# TypeScript
npm run build
npx @modelcontextprotocol/inspector node dist/index.js

# Python
npx @modelcontextprotocol/inspector python server.py
```

---

## Scenario Buckets (Minimum Coverage)

| Bucket | Required |
|---|---|
| Happy path | 1 per primary tool |
| Variant | 1 per primary tool |
| Error recovery | 1 per server |
| Resource access | 1 if resources declared |
| Edge case | 1 per server |

---

## Gate Criterion

Phase 8 is complete when ≥5 scenarios are attempted, ≥3 are PASS, and the
friction report is written. If <3 PASS, re-enter Phase 3 (creation) for tool
output issues or Phase 2 (design) for missing tools.

---

## Common Failures

1. **Only happy path tested** — Error recovery and edge cases not attempted.
   Gate requires at least one error-recovery scenario. Fix: design the error
   scenario before executing.

2. **Error cases not attempted** — Passing only valid inputs misses the most
   common real-world failure mode (bad input). Fix: include one scenario with
   a missing required parameter.

3. **No resource scenarios when resources are declared** — Resources listed in
   capability inventory but never tested. Fix: add at least one resource access
   scenario if any resources are declared.
