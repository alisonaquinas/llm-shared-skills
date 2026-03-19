---
name: claude-command-verification
description: >
  Verification phase for reusable command workflow development. Use when planning, designing, building,
  testing, validating, or refining a reusable command workflow as it moves through a full delivery
  lifecycle. Triggers include drafting the command spec, locking interfaces,
  wiring runtime placement, scoring quality, running live scenarios, or choosing
  the right re-entry point after a failure.
---

# Command Verification

Run the static and contract-level checks that confirm the implementation still matches the design.

## Intent Router

Load reference files on demand only when the corresponding topic is active:

- `references/verification-checklist.md` — Load when confirming static command contracts before integration

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
| Check | Status | Notes |
|---|---|---|
| Interface matches design | PASS | |
| Required files present | PASS | |
| Fallback path documented | PASS | |
| Safety constraints enforced | PASS | |
```

## Gate

Verification is complete when all required checklist items pass and no unresolved mismatch remains between design and implementation.

## Safety Notes

Verification failures are upstream failures. Fix the underlying design or creation gap instead of papering over the mismatch.

## Resource Index

| Reference File | Load When |
|---|---|
| `references/verification-checklist.md` | Load when confirming static command contracts before integration |
