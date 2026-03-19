---
name: claude-hook-creation
description: >
  Creation phase for hook automation rule development. Use when planning, designing, building,
  testing, validating, or refining a hook automation rule as it moves through a full delivery
  lifecycle. Triggers include drafting the hook spec, locking contracts,
  wiring runtime placement, scoring quality, running live scenarios, or choosing
  the right re-entry point after a failure.
---

# Hook Creation

Build the actual hook configuration, helper scripts, and templates from the approved design.

## Intent Router

Load reference files on demand only when the corresponding topic is active:

- `references/scaffold-patterns.md` — Load when creating hook config, scripts, and support files

## Quick Start

```text
[ ] Capture the current hook spec
[ ] Complete the required outputs for this phase
[ ] Record evidence for the gate
[ ] Hand off the evidence to the next phase
```

## Phase Workflow

Start from the current hook spec and tighten only the decisions owned by this phase.
Work forward until the gate is satisfied, then hand the evidence to the next phase in the family.
Keep the workflow description portable even when the runtime wiring is specific to one environment.

## Example Evidence

```text
Files created
- hook configuration
- helper scripts
- sample settings snippet

Smoke check
- local invocation succeeds
- return shape matches design
- fallback path documented
```

## Gate

Creation is complete when the target files exist, the rule can be exercised locally, and every declared dependency is resolvable.

## Safety Notes

Keep generated artifacts aligned with the event contract. Any design drift must route back through the design phase.

## Resource Index

| Reference File | Load When |
|---|---|
| `references/scaffold-patterns.md` | Load when creating hook config, scripts, and support files |
