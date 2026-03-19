---
name: claude-command-validation
description: >
  Validation phase for reusable command workflow development. Use when planning, designing, building,
  testing, validating, or refining a reusable command workflow as it moves through a full delivery
  lifecycle. Triggers include drafting the command spec, locking interfaces,
  wiring runtime placement, scoring quality, running live scenarios, or choosing
  the right re-entry point after a failure.
---

# Command Validation

Score quality, discoverability, safety, and portability before the workflow is considered release-ready.

## Intent Router

Load reference files on demand only when the corresponding topic is active:

- `references/quality-rubric.md` — Load when scoring discoverability, safety, and portability

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
| Criterion | Score | Notes |
|---|---|---|
| Discoverability | PASS | |
| Safety | PASS | |
| Portability | PASS | |
| Operability | PASS | |
```

## Gate

Require `C04` Safety to PASS before approving the reusable command workflow.

## Safety Notes

A workflow that fails safety or portability validation must loop back before any live rollout.

## Resource Index

| Reference File | Load When |
|---|---|
| `references/quality-rubric.md` | Load when scoring discoverability, safety, and portability |
