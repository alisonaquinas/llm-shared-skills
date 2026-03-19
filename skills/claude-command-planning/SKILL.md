---
name: claude-command-planning
description: >
  Planning phase for reusable command workflow development. Use when planning, designing, building,
  testing, validating, or refining a reusable command workflow as it moves through a full delivery
  lifecycle. Triggers include drafting the command spec, locking interfaces,
  wiring runtime placement, scoring quality, running live scenarios, or choosing
  the right re-entry point after a failure.
---

# Command Planning

Clarify scope, triggers, inputs, outputs, dependencies, and success criteria before implementation begins.

## Intent Router

Load reference files on demand only when the corresponding topic is active:

- `references/command-scope-template.md` — Load when defining scope boundaries, trigger phrases, inputs, and success criteria
- `references/portability-notes.md` — Load when translating the workflow to a cross-compatible skill shape

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
| Output | Required detail |
|---|---|
| Scope | Primary goal, audience, and explicit non-goals |
| Triggers | 3+ trigger phrases and one example prompt |
| Interface | Inputs, outputs, and execution constraints |
| Success | Observable completion criteria and rollback path |
```

## Gate

Planning is complete when scope, trigger inventory, interface summary, and success criteria are all written with no TBD items.

## Safety Notes

Avoid scope drift. If the plan mixes multiple unrelated workflows, split it before moving to design.

## Resource Index

| Reference File | Load When |
|---|---|
| `references/command-scope-template.md` | Load when defining scope boundaries, trigger phrases, inputs, and success criteria |
| `references/portability-notes.md` | Load when translating the workflow to a cross-compatible skill shape |
