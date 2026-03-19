---
name: claude-agent-testing
description: >
  Testing phase for delegated agent workflow development. Use when planning, designing, building,
  testing, validating, or refining a delegated agent workflow as it moves through a full delivery
  lifecycle. Triggers include drafting the agent orchestration spec, locking contracts,
  wiring runtime placement, scoring quality, running live scenarios, or choosing
  the right re-entry point after a failure.
---

# Agent Testing

Exercise the workflow with fixtures, dry runs, negative cases, and merge-path boundary conditions before integration.

## Intent Router

Load reference files on demand only when the corresponding topic is active:

- `references/test-harness.md` — Load when simulating role handoffs, merge conflicts, and blocked workers

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
| Scenario | Goal | Expected result |
|---|---|---|
| Happy path | Roles complete delegated work | PASS with expected output |
| Variant | Alternate role split | PASS with same contract |
| Blocked | One role cannot proceed | Clear escalation signal |
| Recovery | Retry or fallback path | Controlled recovery |
```

## Gate

Testing is complete when the happy path, one variant, one blocked path, and one recovery path all have evidence.

## Safety Notes

Do not rely only on the happy path. An orchestration without blocked-path evidence is not ready for verification.

## Resource Index

| Reference File | Load When |
|---|---|
| `references/test-harness.md` | Load when simulating role handoffs, merge conflicts, and blocked workers |
