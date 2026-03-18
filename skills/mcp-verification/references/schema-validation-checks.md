# Schema Validation Checks

Load when tool registration fails, clients show malformed schema errors, or
inputSchema definitions need to be validated against JSON Schema Draft 7.

---

## JSON Schema Draft 7 Requirements for MCP inputSchema

Every tool `inputSchema` must satisfy these requirements:

1. Root must be `{"type": "object", ...}` — not array, string, or bare schema
2. Every property must have a `"description"` field
3. Every entry in `"required"` must exist as a key in `"properties"`
4. `"additionalProperties"` is optional (omit to allow; set `false` to restrict)
5. Nested objects should not exceed 2 levels of depth (client rendering issues)
6. `"$schema"` is not required and should be omitted (MCP clients do not expect it)

---

## Validation with ajv (TypeScript/Node)

Install ajv CLI:
```bash
npm install -g ajv-cli
# or use npx without installing:
npx ajv validate -s schema.json -d data.json
```

Validate a single inputSchema:
```bash
# Save your tool's inputSchema to schema.json, then:
npx ajv validate -s schema.json -d '{"message": "test"}' --spec=draft7
```

Programmatic validation in a test:
```typescript
import Ajv from "ajv";
const ajv = new Ajv();

const schema = {
  type: "object",
  properties: {
    message: { type: "string", description: "Message to echo" }
  },
  required: ["message"]
};

const validate = ajv.compile(schema);
const valid = validate({ message: "hello" });
if (!valid) console.error(validate.errors);
```

---

## Validation with jsonschema (Python)

```bash
pip install jsonschema
python -m jsonschema -i data.json schema.json
```

Programmatic validation:
```python
import jsonschema

schema = {
    "type": "object",
    "properties": {
        "message": {"type": "string", "description": "Message to echo"}
    },
    "required": ["message"]
}

# Validate — raises jsonschema.ValidationError if invalid
jsonschema.validate({"message": "hello"}, schema)
```

---

## Common Schema Errors and Fix Recipes

### Error: Missing `"type": "object"` at root

Symptom: Some MCP clients refuse to register the tool; others silently ignore it.

Bad:
```json
{
  "properties": {
    "message": {"type": "string"}
  },
  "required": ["message"]
}
```

Fix:
```json
{
  "type": "object",
  "properties": {
    "message": {"type": "string", "description": "Message to process"}
  },
  "required": ["message"]
}
```

---

### Error: Property in `required` not in `properties`

Symptom: `jsonschema.SchemaError: 'path' is not valid under any of the given schemas`
or ajv `"required" property 'path' not found in schema`.

Bad:
```json
{
  "type": "object",
  "properties": {
    "filepath": {"type": "string", "description": "File path"}
  },
  "required": ["path"]
}
```

Fix: align the name (`path` → `filepath` or vice versa):
```json
{
  "type": "object",
  "properties": {
    "path": {"type": "string", "description": "Absolute path to the file"}
  },
  "required": ["path"]
}
```

---

### Error: Property missing `description`

Symptom: Lint WARN; LLMs may pass incorrect arguments; tool discovery is poor.

Bad:
```json
"limit": {"type": "integer"}
```

Fix:
```json
"limit": {
  "type": "integer",
  "description": "Maximum number of results to return (1–100)"
}
```

---

### Error: `anyOf` or `oneOf` at property level

Symptom: Client renders the parameter as having an unknown type; LLM cannot determine what to pass.

Bad:
```json
"value": {
  "anyOf": [{"type": "string"}, {"type": "integer"}]
}
```

Fix: choose the most common type; document the other in the description:
```json
"value": {
  "type": "string",
  "description": "The value as a string (numeric values should be passed as strings)"
}
```

---

### Error: Schema with `$schema` field

Symptom: Some MCP clients reject the schema or fail to parse it.

Fix: Remove the `$schema` field — MCP clients do not expect it:
```json
{
  "type": "object",
  "properties": { ... }
}
```
(not `{"$schema": "http://json-schema.org/draft-07/schema#", "type": "object", ...}`)

---

## Batch Schema Validation Script

Validate all tool schemas in a TypeScript project at once:

```typescript
import Ajv from "ajv";
import { createServer } from "./src/server.js";

async function validateAllSchemas() {
  const ajv = new Ajv();
  const server = createServer();
  const { tools } = await server._requestHandler(
    { method: "tools/list", params: {} } as any,
    {} as any
  );
  let failures = 0;
  for (const tool of tools) {
    try {
      ajv.compile(tool.inputSchema);
      console.log(`✓ ${tool.name}`);
    } catch (e) {
      console.error(`✗ ${tool.name}: ${e}`);
      failures++;
    }
  }
  if (failures > 0) process.exit(1);
}

validateAllSchemas();
```
