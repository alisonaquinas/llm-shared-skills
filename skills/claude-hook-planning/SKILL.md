---
name: claude-hook-planning
description: >
  Planning phase for hook automation rule development. Use when planning, designing, building,
  testing, validating, or refining a hook automation rule as it moves through a full delivery
  lifecycle. Triggers include drafting the hook spec, locking contracts,
  wiring runtime placement, scoring quality, running live scenarios, or choosing
  the right re-entry point after a failure.
---

# Hook Planning

Clarify events, matchers, side effects, dependencies, and success criteria before implementation begins.

## Intent Router

Load reference files on demand only when the corresponding topic is active:

- `references/hook-scope-template.md` — Load when defining events, matchers, side effects, and success criteria
- `references/portability-notes.md` — Load when mapping hook behavior to cross-agent automation patterns

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
| Output | Required detail |
|---|---|
| Event | Triggering event and intent |
| Matchers | Conditions that narrow execution |
| Action | Command, inputs, and outputs |
| Success | Observable outcome and rollback path |
```

## Gate

Planning is complete when event scope, matcher inventory, interface summary, and success criteria are all written with no TBD items.

## Safety Notes

Avoid scope drift. If the rule mixes unrelated events or unrelated automation goals, split it before design.

## Resource Index

| Reference File | Load When |
|---|---|
| `references/hook-scope-template.md` | Load when defining events, matchers, side effects, and success criteria |
| `references/portability-notes.md` | Load when mapping hook behavior to cross-agent automation patterns |
