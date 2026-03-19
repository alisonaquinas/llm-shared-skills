---
name: claude-agent-design
description: >
  Design phase for delegated agent workflow development. Use when planning, designing, building,
  testing, validating, or refining a delegated agent workflow as it moves through a full delivery
  lifecycle. Triggers include drafting the agent orchestration spec, locking contracts,
  wiring runtime placement, scoring quality, running live scenarios, or choosing
  the right re-entry point after a failure.
---

# Agent Design

Lock role contracts, ownership rules, message shapes, portability expectations, and safety rules before creation starts.

## Intent Router

Load reference files on demand only when the corresponding topic is active:

- `references/orchestration-contract.md` — Load when defining roles, ownership, messages, merge steps, and isolation rules
- `references/safety-patterns.md` — Load when delegated work can conflict or perform risky actions

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
{
  "roles": ["orchestrator", "worker"],
  "handoffs": ["..."],
  "merge_rules": ["..."],
  "failure_modes": ["..."],
  "portability_notes": ["..."]
}
```

## Gate

Design is complete when every role, handoff, input, output, and merge path is explicit and no safety rule is left implicit.

## Safety Notes

Do not start creation while role ownership, merge behavior, or fallback handling are still ambiguous.

## Resource Index

| Reference File | Load When |
|---|---|
| `references/orchestration-contract.md` | Load when defining roles, ownership, messages, merge steps, and isolation rules |
| `references/safety-patterns.md` | Load when delegated work can conflict or perform risky actions |
