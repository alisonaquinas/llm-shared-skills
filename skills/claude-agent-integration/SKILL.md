---
name: claude-agent-integration
description: >
  Integration phase for delegated agent workflow development. Use when planning, designing, building,
  testing, validating, or refining a delegated agent workflow as it moves through a full delivery
  lifecycle. Triggers include drafting the agent orchestration spec, locking contracts,
  wiring runtime placement, scoring quality, running live scenarios, or choosing
  the right re-entry point after a failure.
---

# Agent Integration

Place the workflow where the target runtime discovers it and confirm delegated execution works in context.

## Intent Router

Load reference files on demand only when the corresponding topic is active:

- `references/placement-and-discovery.md` — Load when wiring agent definitions into plugin or workspace discovery paths

## Quick Start

```text
[ ] Capture the current agent orchestration spec
[ ] Complete the required outputs for this phase
[ ] Record evidence for the gate
[ ] Hand off the evidence to the next phase
```

## Phase Workflow

Start from the current agent orchestration spec and tighten only the decisions owned by this phase.
Work forward until the gate is satisfied, then hand the evidence to the next phase in the family.
Keep the workflow description portable even when the runtime wiring is specific to one environment.

## Example Evidence

```text
| Target surface | Path or config | Verification |
|---|---|---|
| Shared plugin | <path> | Workflow appears in discovery list |
| Project-local config | <path> | Delegation resolves without manual patching |
```

## Gate

Integration is complete when discovery succeeds, one live delegated run works, and any required local settings are documented.

## Safety Notes

Use explicit paths and documented config surfaces. Avoid hidden machine-local assumptions that other users cannot reproduce.

## Resource Index

| Reference File | Load When |
|---|---|
| `references/placement-and-discovery.md` | Load when wiring agent definitions into plugin or workspace discovery paths |
