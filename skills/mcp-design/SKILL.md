---
name: mcp-design
description: >
  Architecture and interface design phase for MCP server development. Use when
  designing tool schemas with JSON Schema parameters, defining resource URI
  templates, authoring prompt templates, finalizing transport architecture,
  reviewing tool naming and discoverability, or producing a complete interface
  contract before writing implementation code. Covers tool schema design patterns,
  resource definition, prompt template authoring, and transport architecture.
---

# MCP Design

Tool schemas, resource definitions, and transport architecture for MCP servers.

## Intent Router

Load reference files on demand — only when the corresponding topic is active:

- `references/tool-schema-patterns.md` — Load when designing tool parameter schemas,
  writing JSON Schema definitions, or choosing tool naming conventions
- `references/resource-prompt-definitions.md` — Load when defining resource URI
  templates or authoring MCP prompt templates

## Quick Start — Design Checklist

```text
[ ] Tool names: snake_case, verb_noun pattern (read_file, list_directory)
[ ] Each tool has: name, description (≤100 words), inputSchema
[ ] inputSchema root is {"type": "object", "properties": {...}}
[ ] Each inputSchema property has a "description" field
[ ] Required properties listed in inputSchema "required" array
[ ] "required" entries all exist as keys in "properties"
[ ] Resource URI templates use {param} syntax
[ ] Prompt templates list their arguments array
[ ] Transport confirmed: stdio or SSE
[ ] Capability declaration includes only exposed types (tools/resources/prompts)
```

## Tool Schema Design

Every tool must have a valid `inputSchema`. Minimal example:

```json
{
  "name": "read_file",
  "description": "Read the contents of a file at the given path. Returns the file contents as a plain text string.",
  "inputSchema": {
    "type": "object",
    "properties": {
      "path": {
        "type": "string",
        "description": "Absolute path to the file to read"
      }
    },
    "required": ["path"]
  }
}
```

Load `references/tool-schema-patterns.md` for patterns covering enums, arrays,
optional parameters, nested objects, and anti-patterns.

## Resource URI Template Design

Resources use URI templates with `{param}` placeholders:

```text
file://{path}              → single required param
db://{table}/{row_id}      → two required params
config://{env}/{key}       → required + required
```

Load `references/resource-prompt-definitions.md` for content types (text vs blob),
`mimeType` selection, and when to use resources versus tools.

## Prompt Template Design

Prompts are templated starting messages. Define them when there is a reusable way
to begin a task that benefits from a specific phrasing:

```json
{
  "name": "summarize_file",
  "description": "Summarize the contents of a file",
  "arguments": [
    {"name": "path", "description": "Path to the file", "required": true},
    {"name": "style", "description": "brief or detailed", "required": false}
  ]
}
```

## Discoverability Rules

Tool descriptions are read by language models to route tool selection.

- State what the tool does in one sentence
- State what it returns ("Returns a list of filenames", "Returns file contents")
- State side effects when present ("Creates a file at path", "Sends HTTP POST")
- Use the model's vocabulary — avoid internal jargon
- Differentiate tools with similar purposes by domain, input type, or return type

## Gate

mcp-design is complete when:

- Every tool in the capability inventory has a validated `inputSchema`
- Interface contract document is written (tool names, parameter types, return types)
- No tool name is listed as TBD

Proceed to mcp-creation only after all schemas pass ajv or jsonschema validation.

## Safety Notes

JSON Schema errors in `inputSchema` silently cause tool registration failures in
some clients. Validate all schemas before implementation using ajv or jsonschema.
Do not proceed to mcp-creation with an unvalidated schema.

## Resource Index

| Reference File | Load When |
|---|---|
| `references/tool-schema-patterns.md` | Designing parameter schemas; naming conventions; anti-patterns |
| `references/resource-prompt-definitions.md` | Defining resource URI templates or prompt templates |
