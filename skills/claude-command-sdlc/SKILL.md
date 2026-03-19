---
name: claude-command-sdlc
description: >
  Orchestrate the full end-to-end SDLC for reusable command workflow development. Use when building
  a new reusable command workflow from scratch, following a complete development pipeline, managing
  iteration across planning, design, creation, testing, verification,
  integration, validation, and live scenario testing, or recovering from a
  failed gate without restarting the whole effort.
---

# Command SDLC

End-to-end SDLC orchestrator for building, validating, and shipping command workflows.

## Intent Router

Load reference files on demand only when the corresponding phase is active:

- `references/phase-planning.md` — Phase 1: planning guidance, deliverables, and gate criteria
- `references/phase-design.md` — Phase 2: design guidance, deliverables, and gate criteria
- `references/phase-creation.md` — Phase 3: creation guidance, deliverables, and gate criteria
- `references/phase-testing.md` — Phase 4: testing guidance, deliverables, and gate criteria
- `references/phase-verification.md` — Phase 5: verification guidance, deliverables, and gate criteria
- `references/phase-integration.md` — Phase 6: integration guidance, deliverables, and gate criteria
- `references/phase-validation.md` — Phase 7: validation guidance, deliverables, and gate criteria
- `references/phase-test-drive.md` — Phase 8: test drive guidance, deliverables, and gate criteria
- `references/iteration-patterns.md` — Phase 9: iterative development guidance, deliverables, and gate criteria

## Quick Start

| # | Phase | Primary Skill | Gate Criterion | On Failure |
|---|---|---|---|---|
| 1 | Planning | claude-command-planning | Planning is complete when scope, trigger inventory, interface summary, and success criteria are all written with no TBD items. | Clarify scope |
| 2 | Design | claude-command-design | Design is complete when every public interface is named, every input and output is defined, and no safety rule is left implicit. | Revise contract |
| 3 | Creation | claude-command-creation | Creation is complete when the target files exist, the workflow can be exercised locally, and every declared dependency is resolvable. | Fix implementation |
| 4 | Testing | claude-command-testing | Testing is complete when the happy path, one variant, one failure path, and one recovery path all have evidence. | Fix coverage |
| 5 | Verification | claude-command-verification | Verification is complete when all required checklist items pass and no unresolved mismatch remains between design and implementation. | Fix mismatch |
| 6 | Integration | claude-command-integration | Integration is complete when discovery succeeds, one live invocation works, and any required local settings are documented. | Fix wiring |
| 7 | Validation | claude-command-validation | Rubric verdict is APPROVE and C04 Safety passes | Address failed rubric items |
| 8 | Test Drive | claude-command-test-drive | Test drive is complete when at least five scenarios were attempted, at least three passed, and a friction report was written. | Address friction |
| 9 | Iterative Development | claude-command-iterative-development | Iteration is complete when the right upstream phase is re-run, the failing gate passes again, and the evidence trail is updated. | Continue fixing |

## Iteration Patterns

| Failure Mode | Re-Entry Phase | Phases to Skip |
|---|---|---|
| Scope or audience mistake | Phase 1 | None |
| Interface or safety contract mistake | Phase 2 | 1 |
| Implementation defect | Phase 3 | 1, 2 |
| Coverage gap | Phase 4 | 1-3 |
| Contract mismatch discovered late | Phase 5 | 1-4 |
| Wiring or discovery failure | Phase 6 | 1-5 |
| Rubric failure only | Phase 7 | 1-6 |
| Test-drive friction | Phase 8 | 1-7 |
| Re-entry decision unclear | Phase 9 | 1-8 |

## Ship Checklist

```text
[ ] Every phase gate passed or was explicitly re-run after changes
[ ] README entry added for each new skill in the family
[ ] Focused lint and validation runs are green
[ ] Baseline repo gates pass
[ ] Changelog entry is written
```

## Example Handoff

```text
Current phase: verification
Failed gate: interface mismatch between design and implementation
Next step: return to claude-command-design, update the contract, then rerun
claude-command-creation and claude-command-verification before integration.
```

## Resource Index

| Reference File | Phase | Load When |
|---|---|---|
| `references/phase-planning.md` | Phase 1 | Planning guidance and gate criteria |
| `references/phase-design.md` | Phase 2 | Design guidance and gate criteria |
| `references/phase-creation.md` | Phase 3 | Creation guidance and gate criteria |
| `references/phase-testing.md` | Phase 4 | Testing guidance and gate criteria |
| `references/phase-verification.md` | Phase 5 | Verification guidance and gate criteria |
| `references/phase-integration.md` | Phase 6 | Integration guidance and gate criteria |
| `references/phase-validation.md` | Phase 7 | Validation guidance and gate criteria |
| `references/phase-test-drive.md` | Phase 8 | Test Drive guidance and gate criteria |
| `references/iteration-patterns.md` | Phase 9 | Iterative Development guidance and gate criteria |
