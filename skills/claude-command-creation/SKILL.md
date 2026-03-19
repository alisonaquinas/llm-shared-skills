---
name: claude-command-creation
description: >
  Creation phase for reusable command workflow development. Use when planning, designing, building,
  testing, validating, or refining a reusable command workflow as it moves through a full delivery
  lifecycle. Triggers include drafting the command spec, locking interfaces,
  wiring runtime placement, scoring quality, running live scenarios, or choosing
  the right re-entry point after a failure.
---

# Command Creation

Build the actual workflow files, helper scripts, and templates from the approved design.

## Intent Router

Load reference files on demand only when the corresponding topic is active:

- `references/scaffold-patterns.md` — Load when laying out command files, templates, or plugin packaging

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
Files created
- workflow definition
- helper scripts
- sample config or template

Smoke check
- local invocation succeeds
- output shape matches design
- fallback path documented
```

## Gate

Creation is complete when the target files exist, the workflow can be exercised locally, and every declared dependency is resolvable.

## Safety Notes

Keep generated artifacts aligned with the interface contract. Any design drift must route back through the design phase.

## Resource Index

| Reference File | Load When |
|---|---|
| `references/scaffold-patterns.md` | Load when laying out command files, templates, or plugin packaging |
