---
name: claude-agent-planning
description: >
  Planning phase for delegated agent workflow development. Use when planning, designing, building,
  testing, validating, or refining a delegated agent workflow as it moves through a full delivery
  lifecycle. Triggers include drafting the agent orchestration spec, locking contracts,
  wiring runtime placement, scoring quality, running live scenarios, or choosing
  the right re-entry point after a failure.
---

# Agent Planning

Clarify roles, ownership boundaries, dependencies, handoffs, and success criteria before implementation begins.

## Intent Router

Load reference files on demand only when the corresponding topic is active:

- `references/agent-scope-template.md` — Load when defining roles, ownership boundaries, handoffs, and success criteria
- `references/portability-notes.md` — Load when mapping the orchestration pattern to other agent runtimes

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
| Output | Required detail |
|---|---|
| Roles | Named roles and responsibilities |
| Handoffs | Inputs, outputs, and merge points |
| Constraints | Concurrency, isolation, and tooling limits |
| Success | Observable outcome and rollback path |
```

## Gate

Planning is complete when role scope, handoff inventory, interface summary, and success criteria are all written with no TBD items.

## Safety Notes

Avoid scope drift. If the workflow mixes unrelated domains or overlapping ownership, split it before design.

## Resource Index

| Reference File | Load When |
|---|---|
| `references/agent-scope-template.md` | Load when defining roles, ownership boundaries, handoffs, and success criteria |
| `references/portability-notes.md` | Load when mapping the orchestration pattern to other agent runtimes |
