# Tool Schema Patterns

Load when designing non-trivial tool parameter schemas, writing JSON Schema
definitions, or choosing tool naming conventions.

---

## Naming Conventions

| Rule | Example | Anti-example |
|---|---|---|
| snake_case for tool names | `read_file`, `list_directory` | `readFile`, `Read-File` |
| verb_noun pattern | `get_user`, `create_record`, `delete_item` | `user`, `records`, `removal` |
| Specific over generic | `read_local_file`, `query_database` | `process`, `handle`, `do_thing` |
| Max 64 characters | `search_web_and_return_results` | (too long after 64 chars) |
| All lowercase | `send_email` | `SendEmail`, `SEND_EMAIL` |

---

## Minimal Valid Schema

Every tool `inputSchema` must be a JSON Schema Draft 7 object at the root level:

```json
{
  "type": "object",
  "properties": {
    "path": {
      "type": "string",
      "description": "Absolute path to the file to read"
    }
  },
  "required": ["path"]
}
```

Missing `"type": "object"` at root is the most common schema error.

---

## Schema Patterns by Parameter Type

### String parameter

```json
"name": {
  "type": "string",
  "description": "The full name of the user"
}
```

### Integer parameter

```json
"count": {
  "type": "integer",
  "description": "Number of items to return",
  "minimum": 1,
  "maximum": 100
}
```

### Enum / fixed choices

```json
"format": {
  "type": "string",
  "enum": ["json", "csv", "text"],
  "description": "Output format for the response"
}
```

### Boolean parameter

```json
"recursive": {
  "type": "boolean",
  "description": "Whether to recurse into subdirectories"
}
```

### Array of strings

```json
"tags": {
  "type": "array",
  "items": {"type": "string"},
  "description": "List of tags to apply to the item"
}
```

### Optional parameter (omit from required array)

```json
"properties": {
  "path": {"type": "string", "description": "File path (required)"},
  "encoding": {"type": "string", "description": "File encoding (optional, defaults to utf-8)"}
},
"required": ["path"]
```

`encoding` is optional because it is not listed in `required`.

### Nested object

```json
"options": {
  "type": "object",
  "description": "Search configuration options",
  "properties": {
    "case_sensitive": {"type": "boolean", "description": "Match case exactly"},
    "max_results": {"type": "integer", "description": "Maximum results to return"}
  }
}
```

Avoid nesting deeper than 2 levels — most clients flatten or truncate nested schemas in their UI.

---

## Full Multi-Parameter Example

```json
{
  "type": "object",
  "properties": {
    "query": {
      "type": "string",
      "description": "Search query string"
    },
    "limit": {
      "type": "integer",
      "description": "Maximum number of results (1–50)",
      "minimum": 1,
      "maximum": 50
    },
    "format": {
      "type": "string",
      "enum": ["json", "text"],
      "description": "Response format"
    },
    "include_metadata": {
      "type": "boolean",
      "description": "Include result metadata in response"
    }
  },
  "required": ["query"]
}
```

---

## Anti-Patterns

| Anti-Pattern | Problem | Fix |
|---|---|---|
| Missing `"type": "object"` at root | Schema invalid; tool may not register | Always start with `"type": "object"` |
| Properties without `description` | Poor discoverability; LLM cannot route | Add a description to every property |
| `required` references a non-existent property | Schema validation error | Ensure every `required` entry exists in `properties` |
| Deeply nested objects (3+ levels) | Client rendering issues; LLM confusion | Flatten or use parallel top-level params |
| `anyOf`/`oneOf` at parameter level | Poorly supported by MCP clients | Use separate tools or enum types instead |
| Overly permissive `additionalProperties: true` | Hides interface contract | Omit (defaults to allowing) or set false explicitly |
| Vague description: "The value" | LLM cannot determine what to pass | Be specific: "The database row ID as a UUID string" |

---

## Description Quality Guidelines

Tool descriptions are read by language models to decide which tool to call.
Apply these rules to every tool description:

- State what the tool does in one sentence (≤100 words)
- Specify what the tool returns ("Returns a list of filenames", "Returns the file contents as a string")
- Mention side effects ("Creates a file at the given path", "Sends an HTTP POST request")
- Avoid jargon the model might not recognize
- Do not repeat the tool name in the description

Property descriptions:

- State the expected format ("ISO 8601 date string", "Absolute POSIX path", "UUID")
- State any constraints ("Must be between 1 and 100", "Cannot be empty")
- State the default behavior when optional ("Defaults to utf-8 if omitted")
