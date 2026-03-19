---
name: claude-command-testing
description: >
  Testing phase for reusable command workflow development. Use when planning, designing, building,
  testing, validating, or refining a reusable command workflow as it moves through a full delivery
  lifecycle. Triggers include drafting the command spec, locking interfaces,
  wiring runtime placement, scoring quality, running live scenarios, or choosing
  the right re-entry point after a failure.
---

# Command Testing

Exercise the workflow with fixtures, dry runs, negative cases, and boundary conditions before integration.

## Intent Router

Load reference files on demand only when the corresponding topic is active:

- `references/test-harness.md` — Load when building fixtures, dry runs, or argument coverage

## Quick Start

```text
[ ] Capture the current command spec
[ ] Complete the required outputs for this phase
[ ] Record evidence for the gate
[ ] Hand off the evidence to the next phase
```

## Phase Workflow

Start from the current command spec and tighten only the decisions owned by this phase.
Work forward until the gate is satisfied, then hand the evidence to the next phase in the family.
Keep the workflow description portable even when the runtime wiring is specific to one environment.

## Example Evidence

```text
| Scenario | Goal | Expected result |
|---|---|---|
| Happy path | Core workflow executes | PASS with expected output |
| Variant | Alternate input pattern | PASS with same contract |
| Failure | Invalid input or blocked dependency | Clear failure signal |
| Recovery | Retry or fallback path | Controlled recovery |
```

## Gate

Testing is complete when the happy path, one variant, one failure path, and one recovery path all have evidence.

## Safety Notes

Do not rely only on the happy path. A workflow without failure-path evidence is not ready for verification.

## Resource Index

| Reference File | Load When |
|---|---|
| `references/test-harness.md` | Load when building fixtures, dry runs, or argument coverage |
