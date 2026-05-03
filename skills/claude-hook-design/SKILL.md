---
name: claude-hook-design
description: >
  Design phase for hook automation rule development. Use when planning, designing, building,
  testing, validating, or refining a hook automation rule as it moves through a full delivery
  lifecycle. Triggers include drafting the hook spec, locking contracts,
  wiring runtime placement, scoring quality, running live scenarios, or choosing
  the right re-entry point after a failure.
---

# Hook Design

Lock event contracts, matcher rules, return behavior, portability expectations, and safety rules before creation starts.

## Intent Router

Load reference files on demand only when the corresponding topic is active:

- `references/event-contract.md` — Load when defining events, matchers, stdin payloads, exit codes, and return JSON
- `references/safety-patterns.md` — Load when the hook can block actions, rewrite files, or trigger other tools

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
{
  "event": "<event-name>",
  "matcher": "<condition>",
  "env": ["..."],
  "returns": ["approve", "block"],
  "failure_modes": ["..."]
}
```

## Gate

Design is complete when every event, matcher, input, output, and decision path is explicit and no safety rule is left implicit.

## Safety Notes

Do not start creation while event semantics, return behavior, or fallback handling are still ambiguous.

## Resource Index

| Reference File | Load When |
|---|---|
| `references/event-contract.md` | Load when defining events, matchers, stdin payloads, exit codes, and return JSON |
| `references/safety-patterns.md` | Load when the hook can block actions, rewrite files, or trigger other tools |
