---
name: claude-command-design
description: >
  Design phase for reusable command workflow development. Use when planning, designing, building,
  testing, validating, or refining a reusable command workflow as it moves through a full delivery
  lifecycle. Triggers include drafting the command spec, locking interfaces,
  wiring runtime placement, scoring quality, running live scenarios, or choosing
  the right re-entry point after a failure.
---

# Command Design

Lock naming, interfaces, control flow, portability expectations, and safety rules before creation starts.

## Intent Router

Load reference files on demand only when the corresponding topic is active:

- `references/interface-contract.md` — Load when defining command names, arguments, outputs, and handoff rules
- `references/safety-patterns.md` — Load when the command can write files, run tools, or chain other workflows

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
{
  "name": "<workflow-name>",
  "inputs": ["..."],
  "outputs": ["..."],
  "preconditions": ["..."],
  "failure_modes": ["..."],
  "portability_notes": ["..."]
}
```

## Gate

Design is complete when every public interface is named, every input and output is defined, and no safety rule is left implicit.

## Safety Notes

Do not start creation while arguments, side effects, or fallback behavior are still ambiguous.

## Resource Index

| Reference File | Load When |
|---|---|
| `references/interface-contract.md` | Load when defining command names, arguments, outputs, and handoff rules |
| `references/safety-patterns.md` | Load when the command can write files, run tools, or chain other workflows |
