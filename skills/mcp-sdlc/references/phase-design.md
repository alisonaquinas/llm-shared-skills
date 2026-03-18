# Phase 2: Design

Gate-focused reference for the MCP SDLC design phase. Load when entering
or reviewing Phase 2.

---

## Pre-Entry Checklist

Before starting Phase 2:
- [ ] Phase 1 deliverables complete (purpose statement, capability inventory, transport, client notes)
- [ ] All tool names are finalized (snake_case, verb_noun)
- [ ] Resources and prompts are listed in the capability inventory (even if empty)

---

## Phase 2 Deliverables

Produce all before moving to Phase 3:

1. **Tool schemas** — Valid JSON Schema `inputSchema` for every tool
2. **Resource URI templates** — `{param}` syntax for every declared resource
3. **Prompt argument lists** — `arguments` array for every declared prompt
4. **Interface contract document** — Compiled view of all schemas; used as Phase 3 reference

---

## Key Design Commands

Validate inputSchema before Phase 3:
```bash
# TypeScript
npx ajv validate -s schema.json -d '{"key":"value"}' --spec=draft7

# Python
python -m jsonschema -i data.json schema.json
```

---

## Schema Checklist

For every tool `inputSchema`:
```
[ ] Root is {"type": "object", "properties": {...}}
[ ] Every property has a "description" field
[ ] "required" array only references keys that exist in "properties"
[ ] Nested objects are ≤2 levels deep
[ ] No "anyOf"/"oneOf" at property level
```

---

## Gate Criterion

Phase 2 is complete when all tool schemas pass ajv/jsonschema validation
and the interface contract document is written. Do not begin Phase 3 with
an unvalidated schema.

---

## Common Failures

1. **Missing `"type": "object"` at root** — The most common schema error; silently
   causes tool registration failure in some clients. Fix: always start inputSchema
   with `{"type": "object", "properties": {...}}`.

2. **Vague property descriptions** — "The value" or "Input data" do not help a
   language model determine what to pass. Fix: be specific about type, format,
   and constraints: "Absolute POSIX path to the file (must exist)."

3. **Unsupported schema features** (`anyOf`/`oneOf` at property level) — MCP clients
   render these poorly. Fix: choose the most common type and document alternatives
   in the description string.
