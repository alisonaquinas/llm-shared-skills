---
name: mcp-sdlc
description: >
  Orchestrate the full end-to-end SDLC for building a production-quality MCP server.
  Use when building a new MCP server from scratch, following a complete MCP development
  pipeline, managing iterative MCP server development, running the full lifecycle from
  ideation to client integration, guiding a structured MCP workflow, or performing
  lifecycle management for an existing MCP server. Covers all phases: planning, design,
  creation, testing, verification, integration, validation, live scenario testing,
  iteration loops, and final ship.
---

# MCP SDLC

End-to-end orchestrator for building, validating, and shipping MCP servers.

## Intent Router

Load reference files on demand — only when the corresponding phase is active:

- `references/phase-planning.md` — Phase 1: purpose definition, capability inventory, transport decision, gate criterion
- `references/phase-design.md` — Phase 2: tool schema design, resource/prompt templates, interface contract
- `references/phase-creation.md` — Phase 3: scaffold setup, handler implementation, build commands
- `references/phase-testing.md` — Phase 4: test harness, unit tests, Inspector integration
- `references/phase-verification.md` — Phase 5: verification checklist, schema validation, Inspector run
- `references/phase-integration.md` — Phase 6: client config patterns, settings.json, connection verification
- `references/phase-validation.md` — Phase 7: M01–M06 quality rubric, scoring workflow, verdict thresholds
- `references/phase-test-drive.md` — Phase 8: scenario matrix, Inspector execution, friction report
- `references/iteration-patterns.md` — Phase 9: re-entry decision tree, loop patterns, partial recovery

## Quick Start — Phase Overview

| # | Phase | Primary Skill | Gate Criterion | On Failure |
|---|---|---|---|---|
| 1 | Planning | mcp-planning | Purpose + capability inventory + transport decision written | Clarify scope |
| 2 | Design | mcp-design | All tool schemas valid; interface contract documented | Revise schemas |
| 3 | Creation | mcp-creation | Server starts; tools/list returns all declared tools | Fix handlers; rebuild |
| 4 | Testing | mcp-testing | Unit tests pass; Inspector shows all tools | Fix test failures |
| 5 | Verification | mcp-verification | Verification checklist all PASS; zero protocol errors | Fix schema/protocol |
| 6 | Integration | mcp-integration | Client connects; tools visible in client UI | Fix config; rebuild |
| 7 | Validation | mcp-validation | M01–M06 PASS or WARN; M05 PASS; verdict APPROVE | Fix FAIL dimensions |
| 8 | Test Drive | mcp-test-drive | ≥5 scenarios; ≥3 PASS; friction report written | Address friction |
| 9 | Iteration | mcp-iterative-development | Re-entry complete; upstream gates re-pass | Continue fixing |
| 10 | Ship | — | All gates pass; README updated; commit done | Fix build |

## Phase Definitions

### Phase 1: Planning

Load `references/phase-planning.md` for the full deliverable list and gate criterion.

Document four outputs before writing any code: purpose statement, capability
inventory (all tools named), transport decision, and client compatibility notes.
Scope limit: one server = one domain. Gate: all four outputs written; no tool
names listed as TBD.

### Phase 2: Design

Load `references/phase-design.md` for the schema checklist and validation commands.

Produce valid JSON Schema `inputSchema` for every tool. Validate schemas with ajv
or jsonschema before writing any implementation code. Gate: all schemas validated;
interface contract document written.

### Phase 3: Creation

Load `references/phase-creation.md` for scaffold templates and the handler contract.

```bash
npm create @modelcontextprotocol/server@latest my-server  # TypeScript
pip install mcp                                            # Python
npm run build                                              # Build TypeScript
```

Gate: server starts; `tools/list` returns all declared tools via the Inspector.

### Phase 4: Testing

Load `references/phase-testing.md` for test harness setup and coverage targets.

```bash
npx @modelcontextprotocol/inspector node dist/index.js    # TypeScript
npx @modelcontextprotocol/inspector python server.py      # Python
npm test                                                   # Unit tests
pytest                                                     # Python tests
```

Gate: unit tests pass; Inspector shows all tools in the Tools panel.

### Phase 5: Verification

Load `references/phase-verification.md` for the full 10-item checklist.

Run the verification checklist. Validate each tool's inputSchema. Confirm the
initialize handshake includes `protocolVersion`. Gate: all 10 checklist items PASS.

### Phase 6: Integration

Load `references/phase-integration.md` for config examples and troubleshooting.

Add the server to `~/.claude/settings.json` or `.claude/settings.json` using
absolute paths. Start a new session and confirm tools appear.
Gate: client connects; all tools visible; one tool call succeeds.

### Phase 7: Validation

Load `references/phase-validation.md` for scoring steps and the report template.

Score dimensions M01–M06 using the mcp-validation quality rubric. Write the
validation report. Gate: APPROVE verdict (≥5 PASS, 0 FAIL, M05 PASS).

### Phase 8: Test Drive

Load `references/phase-test-drive.md` for bucket definitions and the friction report.

Design a 5+ scenario matrix from the capability inventory. Execute via the
Inspector. Record outcomes and write the friction report.
Gate: ≥5 attempted; ≥3 PASS; friction report written.

### Phase 9: Iteration

Load `references/iteration-patterns.md` for the re-entry decision tree.

Match each failure mode to its minimum re-entry phase — do not restart from
Phase 1 unless planning scope is the root cause. After any code change, always
re-run Phase 5 (Verification). Gate: re-entry complete; upstream phase gates re-pass.

### Phase 10: Ship

Confirm all phase gates pass. Update README, then commit:

```bash
bash linting/lint-skill.sh skills/<name>
bash validation/validate-skill.sh skills/<name>
git add README.md skills/<name>
git commit -m "feat(<name>): add MCP server"
# At workspace root:
git add repos/llm-shared-skills
git commit -m "chore(submodules): advance llm-shared-skills with <name>"
```

## Iteration Patterns

| Failure Mode | Re-Entry Phase | Phases to Skip |
|---|---|---|
| Verification FAIL (schema/protocol) | Phase 3 | 1, 2 |
| Validation FAIL M01/M02 | Phase 2 | 1 |
| Validation FAIL M03/M05/M06 | Phase 3 | 1, 2 |
| Validation FAIL M04 only | Fix in place | All |
| Test drive FAIL | Phase 2 or 3 | 1 |
| Test drive PARTIAL | Phase 7 (re-score) | 1–6 |
| Integration FAIL | Phase 3 (rebuild) | 1, 2 |
| Repeated M01 FAIL | Phase 1 (split scope) | None |

## Cross-Phase Decision Guide

- After any change to handler code, re-run Phase 5 before anything else.
- If validation returns REVISE on M01, fix tool descriptions and names before
  re-validating — discoverability affects all downstream testing.
- If test drive returns ≥3 PASS with mostly PARTIAL results, prefer Phase 7
  re-validation over full re-implementation.
- Record all BLOCKED scenarios — they document infrastructure dependencies,
  not dismissible failures.
- When M01 fails twice in a row, treat it as a scope signal — load
  `references/iteration-patterns.md` for escalation guidance.
- Never ship with a Phase 5 FAIL or M05 Safety FAIL.

## Resource Index

| Reference File | Phase | Load When |
|---|---|---|
| `references/phase-planning.md` | 1 | Defining purpose, inventory, or transport |
| `references/phase-design.md` | 2 | Designing schemas or interface contract |
| `references/phase-creation.md` | 3 | Scaffolding or implementing handlers |
| `references/phase-testing.md` | 4 | Setting up tests or running Inspector |
| `references/phase-verification.md` | 5 | Running verification checklist |
| `references/phase-integration.md` | 6 | Configuring client or troubleshooting |
| `references/phase-validation.md` | 7 | Scoring dimensions or writing report |
| `references/phase-test-drive.md` | 8 | Designing scenarios or writing friction report |
| `references/iteration-patterns.md` | 9 | Deciding re-entry point or recovering partial state |
