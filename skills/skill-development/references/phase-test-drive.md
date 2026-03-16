# Phase 5: Test Drive

Deep guidance for the test-drive phase. Load when designing, executing, or
reporting on live skill scenarios in a disposable workspace.

---

## Disposable Workspace Setup

```bash
WORK_DIR=$(mktemp -d)
trap "rm -rf $WORK_DIR" EXIT
cd "$WORK_DIR"
```

The trap removes only the system-generated temp directory on exit — it does not
touch the real repository. Run all scenario live actions inside `$WORK_DIR` to
prevent side effects. If the session ends abnormally, run `rm -rf "$WORK_DIR"`
manually to clean up.

---

## Scenario Matrix Design

Design at least 5 scenarios. Cover each bucket before repeating:

| # | Bucket | What It Tests |
|---|---|---|
| 1 | Happy path | Main workflow from Quick Start |
| 2 | Variant | Same workflow with a different input, flag, or size |
| 3 | Verification | Explicit check that proves the result is correct |
| 4 | Recovery | A likely failure or misstep with a recovery attempt |
| 5 | Setup | Dependency, fixture, bootstrap, or environment assumption |

Optional expansion buckets (use only after minimum coverage is complete): Safety,
Integration, Scale, Format drift, Documentation discovery.

---

## Scenario Table Template

| # | Bucket | Job | Skill Section | Live Action | Success Check | Outcome |
|---|---|---|---|---|---|---|
| 1 | Happy path | [task description] | [SKILL.md section] | [command or action] | [verification step] | PASS/FAIL/PARTIAL/BLOCKED |

---

## Per-Scenario Execution Workflow

For each scenario:

1. State the job being attempted.
2. Identify which skill section should enable it.
3. Take the live action (real command or file operation — no pseudocode).
4. Run the success check and observe the result.
5. Score 6 dimensions: Discoverability, Completeness, Correctness, Verification, Safety,
   Efficiency (0–2 each; max 12 per scenario).
6. Record outcome: PASS, PARTIAL, FAIL, or BLOCKED.

---

## Outcome Labels

| Label | Meaning |
|---|---|
| `PASS` | Skill enabled the scenario cleanly; verification succeeded |
| `PARTIAL` | Scenario completed, but skill omitted or weakened key guidance |
| `FAIL` | Scenario did not complete due to wrong, incomplete, or unsafe guidance |
| `BLOCKED` | Real attempt made; external blocker prevented completion |

---

## Issue Categories

| Category | Description |
|---|---|
| Discoverability | Guidance was hard to find in the skill |
| Completeness | Key steps were missing from the workflow |
| Correctness | Commands, flags, or paths were wrong |
| Verification | No clear success check was documented |
| Safety | Unsafe default or missing guardrail |
| Efficiency | Excessive extra work required for common tasks |
| Dependencies | Undocumented external tool or environment requirement |
| Scope | Skill claimed coverage it does not actually provide |

---

## Safety Rules

- Never run destructive commands outside the disposable workspace.
- Document any BLOCKED scenario with the exact missing precondition.
- Add a replacement scenario from an uncovered bucket for each BLOCKED one.
- Keep the total at 5 or more attempted scenarios even after replacements.

---

## Friction Report Structure

```markdown
# Test Drive Friction Report: <skill-name>

## Scenario Results

[Completed scenario table with outcome and dimension scores]

## Friction Items

- [issue category]: [description] → [suggested fix]

## Verdict

approve / revise / re-test

Rationale: [1–2 sentences explaining the verdict]
```

---

## Gate Criterion

Test-drive phase is complete when:

- ≥5 scenarios attempted
- ≥3 scenarios PASS
- Friction report written with all BLOCKED scenarios documented
- All identified issues categorized and assigned a suggested fix
