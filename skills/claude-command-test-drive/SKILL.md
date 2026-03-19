---
name: claude-command-test-drive
description: >
  Test Drive phase for reusable command workflow development. Use when planning, designing, building,
  testing, validating, or refining a reusable command workflow as it moves through a full delivery
  lifecycle. Triggers include drafting the command spec, locking interfaces,
  wiring runtime placement, scoring quality, running live scenarios, or choosing
  the right re-entry point after a failure.
---

# Command Test Drive

Run realistic scenarios end to end and capture friction, surprises, and missing guidance.

## Intent Router

Load reference files on demand only when the corresponding topic is active:

- `references/scenario-matrix.md` — Load when designing live command scenarios and the friction report

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
| Scenario | Outcome | Friction | Follow-up |
|---|---|---|---|
| Happy path | PASS | None | Keep |
| Variant | PARTIAL | Missing example | Add example |
| Recovery | FAIL | Retry policy unclear | Tighten docs |
```

## Gate

Test drive is complete when at least five scenarios were attempted, at least three passed, and a friction report was written.

## Safety Notes

Record blocked and partial results instead of collapsing them into success. They reveal the next iteration target.

## Resource Index

| Reference File | Load When |
|---|---|
| `references/scenario-matrix.md` | Load when designing live command scenarios and the friction report |
