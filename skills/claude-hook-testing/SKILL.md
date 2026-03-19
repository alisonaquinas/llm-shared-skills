---
name: claude-hook-testing
description: >
  Testing phase for hook automation rule development. Use when planning, designing, building,
  testing, validating, or refining a hook automation rule as it moves through a full delivery
  lifecycle. Triggers include drafting the hook spec, locking contracts,
  wiring runtime placement, scoring quality, running live scenarios, or choosing
  the right re-entry point after a failure.
---

# Hook Testing

Exercise the rule with fixtures, dry runs, negative cases, and boundary conditions before integration.

## Intent Router

Load reference files on demand only when the corresponding topic is active:

- `references/test-harness.md` — Load when exercising event payloads, matchers, and failure injection

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
| Scenario | Goal | Expected result |
|---|---|---|
| Happy path | Event fires and rule runs | PASS with expected output |
| Variant | Alternate matcher input | PASS with same contract |
| Blocked | Invalid or forbidden input | Clear block signal |
| Recovery | Retry or fallback path | Controlled recovery |
```

## Gate

Testing is complete when the happy path, one variant, one blocked path, and one recovery path all have evidence.

## Safety Notes

Do not rely only on the happy path. A hook without blocked-path evidence is not ready for verification.

## Resource Index

| Reference File | Load When |
|---|---|
| `references/test-harness.md` | Load when exercising event payloads, matchers, and failure injection |
