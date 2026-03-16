---
name: skill-development
description: >
  Orchestrate the full end-to-end SDLC for authoring a new LLM agent skill.
  Use when the user wants to create a new skill from scratch, follow a complete
  skill development pipeline, manage iterative skill authoring, run the full
  skill lifecycle from ideation to ship, guide a structured skill development
  workflow, or perform lifecycle management for existing skills. Covers all
  phases: ideation, authoring via skill-creator, structural linting via
  skill-linting, qualitative validation via skill-validation, live scenario
  testing via skill-test-drive, iteration loops, and final commit and ship.
---

# Skill Development

End-to-end SDLC orchestrator for building, validating, and shipping LLM agent skills.

## Intent Router

Load reference files on demand — only when the corresponding phase is active:

- `references/phase-authoring.md` — Phase 2: directory setup, SKILL.md structure, anti-patterns, gate criterion
- `references/phase-linting.md` — Phase 3: 12-rule table, fix priority order, `.lintignore` mechanism
- `references/phase-validation.md` — Phase 4: 8-criterion rubric, decision thresholds, report template
- `references/phase-test-drive.md` — Phase 5: scenario matrix design, execution workflow, friction report
- `references/iteration-patterns.md` — Phase 6: re-entry decision tree, loop patterns, partial recovery

## Quick Start — Phase Overview

| # | Phase | Primary Skill | Gate Criterion | On Failure |
|---|---|---|---|---|
| 1 | Ideation | — | Triggers, success scenario, resource plan written | Clarify scope |
| 2 | Authoring | skill-creator | Directory complete; SKILL.md written; zero dangling refs | Fix gaps; re-author |
| 3 | Linting | skill-linting | `lint-skill.sh` exits 0; zero FAILs | Fix FAILs → WARNs; re-lint |
| 4 | Validation | skill-validation | All V01–V07 PASS/WARN; V08 PASS; overall APPROVE | Fix FAIL criteria; re-validate |
| 5 | Test Drive | skill-test-drive | ≥5 scenarios; ≥3 PASS; friction report done | Address friction; re-test |
| 6 | Iteration | skill-creator + skill-linting | Improvements implemented; re-lint passes; APPROVE | Continue fixing |
| 7 | Ship | — | Commit passes; submodule pointer updated | Fix build |

## Phase Definitions

### Phase 1: Ideation

Before writing any files, document these four outputs:

- 3+ trigger phrases (how a user would phrase the request)
- A success scenario (what does a completed task look like?)
- A reference file plan (topic list for `references/`)
- Scope boundaries (what is explicitly out of scope?)

Ideation is complete when all four outputs are written.

### Phase 2: Authoring

Load `references/phase-authoring.md` for full guidance.

Initialize the directory from the skill repo root (e.g., `repos/llm-shared-skills`).
Always build resources before SKILL.md to prevent L07 violations:

```bash
mkdir -p skills/<name>/agents
mkdir -p skills/<name>/references
```

Write files in this sequence:

1. All `references/*.md` files
2. `agents/claude.yaml` and `agents/openai.yaml`
3. `SKILL.md` (last — all referenced files must exist first)

### Phase 3: Linting

Load `references/phase-linting.md` for the full 12-rule table and fix recipes.

```bash
bash linting/lint-skill.sh skills/<name>
```

Fix FAILs in order L01 → L12, then address WARNs L06 and L11. Re-lint after each
batch of fixes. Gate: `lint-skill.sh` exits 0 with zero FAILs.

### Phase 4: Validation

Load `references/phase-validation.md` for rubric details and the report template.

```bash
bash validation/validate-skill.sh skills/<name>
```

Score criteria V01–V08. APPROVE threshold: ≥7 criteria at PASS, ≤1 at FAIL, all
V01–V07 PASS or WARN, V08 PASS. Write and retain the validation report.

### Phase 5: Test Drive

Load `references/phase-test-drive.md` for scenario matrix design and friction report.

Set up a disposable workspace — all live actions run inside `$WORK_DIR` only:

```bash
# Caution: the trap removes only the system temp directory, never the repo
WORK_DIR=$(mktemp -d)
trap "rm -rf $WORK_DIR" EXIT
cd "$WORK_DIR"
```

Design a 5-scenario matrix covering: Happy path, Variant, Verification, Recovery, Setup.
Execute each scenario, score 6 dimensions, record outcome (PASS/PARTIAL/FAIL/BLOCKED).
Produce a friction report. Gate: ≥5 attempted, ≥3 PASS.

### Phase 6: Iteration

Load `references/iteration-patterns.md` for the re-entry decision tree and loop patterns.

Match each failure mode to its minimum re-entry point — do not restart from Phase 1
unless ideation scope is the root cause. After any authoring change, always re-run
Phase 3; never skip linting after editing files.

### Phase 7: Ship

Confirm the quality gates pass. Requires Node.js 20+:

```bash
make lint && make test && make build
```

If `make` is unavailable or Node < 20 is installed, use the bash fallbacks:

```bash
bash linting/lint-skill.sh skills/<name>
bash linting/lint-all.sh
bash validation/validate-skill.sh skills/<name>
```

Update the `README.md` skill table first, then commit inside the skill's repository
and update the submodule pointer at the root:

```bash
# Update README.md skill table entry, then:
git add README.md skills/<name>
git commit -m "feat(<name>): add skill"
# At workspace root:
git add repos/<submodule>
git commit -m "chore(submodules): bump <submodule> with <name> skill"
```

## Iteration Patterns

| Failure Mode | Re-Entry Point | Phases to Skip |
|---|---|---|
| Lint FAIL (L01–L12) | Phase 3 | 1, 2 |
| Validation FAIL (V01–V07) | Phase 2 | 1 |
| Validation FAIL (V08 only) | Phase 4 (re-score) | 1–3 |
| Test drive FAIL | Phase 2 | 1 |
| Test drive PARTIAL | Phase 4 (re-validate) | 1–3 |
| Repeated V07 FAIL | Phase 1 (split scope) | None |

## Cross-Phase Decision Guide

- After any change to `SKILL.md` or reference files, re-run Phase 3 before anything else.
- If validation returns REVISE on V01 or V02, fix description and Intent Router first —
  these affect all downstream phases.
- If test drive returns ≥3 PASS with only PARTIAL results, prefer Phase 4 re-validation
  over full re-authoring.
- Record all BLOCKED scenarios; they document hidden dependencies, not dismissible failures.
- When V07 (LLM Usability) fails twice in a row, treat it as a scope signal — load
  `references/iteration-patterns.md` for escalation guidance.
- Never ship with lint FAILs; WARN items may ship if suppressed with a documented `.lintignore`.

## Resource Index

| Reference File | Phase | Load When |
|---|---|---|
| `references/phase-authoring.md` | Phase 2 | Building or reworking the skill's file structure |
| `references/phase-linting.md` | Phase 3 | Running or fixing lint checks |
| `references/phase-validation.md` | Phase 4 | Scoring criteria or writing the validation report |
| `references/phase-test-drive.md` | Phase 5 | Designing or executing live scenarios |
| `references/iteration-patterns.md` | Phase 6 | Deciding re-entry point or recovering partial state |
