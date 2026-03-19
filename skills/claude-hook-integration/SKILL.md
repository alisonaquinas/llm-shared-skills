---
name: claude-hook-integration
description: >
  Integration phase for hook automation rule development. Use when planning, designing, building,
  testing, validating, or refining a hook automation rule as it moves through a full delivery
  lifecycle. Triggers include drafting the hook spec, locking contracts,
  wiring runtime placement, scoring quality, running live scenarios, or choosing
  the right re-entry point after a failure.
---

# Hook Integration

Place the rule where the target runtime discovers it and confirm it fires in context.

## Intent Router

Load reference files on demand only when the corresponding topic is active:

- `references/placement-and-discovery.md` — Load when wiring the hook into local or shared settings files

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
| Target surface | Path or config | Verification |
|---|---|---|
| Shared settings | <path> | Rule appears in runtime config |
| Project-local config | <path> | Event fires without manual patching |
```

## Gate

Integration is complete when discovery succeeds, one live invocation works, and any required local settings are documented.

## Safety Notes

Use explicit paths and documented config surfaces. Avoid hidden machine-local assumptions that other users cannot reproduce.

## Resource Index

| Reference File | Load When |
|---|---|
| `references/placement-and-discovery.md` | Load when wiring the hook into local or shared settings files |
