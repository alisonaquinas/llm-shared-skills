---
name: claude-agent-iterative-development
description: >
  Iterative Development phase for delegated agent workflow development. Use when planning, designing, building,
  testing, validating, or refining a delegated agent workflow as it moves through a full delivery
  lifecycle. Triggers include drafting the agent orchestration spec, locking contracts,
  wiring runtime placement, scoring quality, running live scenarios, or choosing
  the right re-entry point after a failure.
---

# Agent Iterative Development

Choose the minimum re-entry phase after a failure so fixes are systematic rather than ad hoc.

## Intent Router

Load reference files on demand only when the corresponding topic is active:

- `references/re-entry-patterns.md` — Load when mapping orchestration failures to the minimum re-entry phase

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
| Failure mode | Re-entry phase | Skip phases |
|---|---|---|
| Planning gap | planning | none |
| Contract mismatch | design | planning |
| Runtime defect | creation | planning, design |
| Quality rubric failure | validation | planning through integration |
```

## Gate

Iteration is complete when the right upstream phase is re-run, the failing gate passes again, and the evidence trail is updated.

## Safety Notes

Do not restart from scratch by reflex. Re-enter at the earliest phase that can actually change the failing outcome.

## Resource Index

| Reference File | Load When |
|---|---|
| `references/re-entry-patterns.md` | Load when mapping orchestration failures to the minimum re-entry phase |
