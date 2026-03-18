# Resource and Prompt Definitions

Load when defining resource URI templates or authoring MCP prompt templates.

---

## Resources

Resources expose data to clients as readable content. They are identified by URIs
and accessed via the `resources/read` protocol method.

### URI Template Syntax

Resources use URI templates (RFC 6570 subset) with `{param}` placeholders:

```
file://{path}                  → one required param
db://{table}/{row_id}          → two required params
config://{env}/{key}           → two required params
logs://{service}?level={level} → one required + one optional
```

### Resource Definition (TypeScript SDK)

```typescript
server.resource(
  "file",                          // resource name
  "file://{path}",                 // URI template
  async (uri, { path }) => ({
    contents: [{
      uri: uri.href,
      mimeType: "text/plain",
      text: await fs.readFile(path, "utf-8"),
    }],
  })
);
```

### Resource Content Types

| Type | Field | MIME Type Examples | When to Use |
|---|---|---|---|
| Text | `text` | `text/plain`, `text/html`, `application/json` | Human-readable or structured text |
| Blob | `blob` | `image/png`, `application/pdf`, `application/octet-stream` | Binary data (base64-encoded) |

Text example:
```json
{
  "uri": "file:///path/to/file.txt",
  "mimeType": "text/plain",
  "text": "file contents here"
}
```

Blob example:
```json
{
  "uri": "image:///path/to/image.png",
  "mimeType": "image/png",
  "blob": "<base64-encoded-data>"
}
```

### When to Use Resources vs Tools

| Use Resources When | Use Tools When |
|---|---|
| Exposing read-only data by URI | Performing actions or mutations |
| The client may subscribe to changes | Single request/response is sufficient |
| Data is addressable (has a natural URI) | Data requires computation or side effects |
| Multiple items share a URI pattern | Each invocation is unique |

---

## Prompts

Prompts are templated messages that clients can present to users as starting points.
They are accessed via the `prompts/get` protocol method.

### Prompt Definition (TypeScript SDK)

```typescript
server.prompt(
  "summarize_file",              // prompt name
  "Summarize the contents of a file",  // description
  {
    path: z.string().describe("Path to the file to summarize"),
    style: z.enum(["brief", "detailed"]).optional()
      .describe("Summary style (default: brief)"),
  },
  async ({ path, style = "brief" }) => ({
    messages: [
      {
        role: "user",
        content: {
          type: "text",
          text: `Please provide a ${style} summary of the file at: ${path}`,
        },
      },
    ],
  })
);
```

### Prompt `arguments` Array (JSON protocol level)

```json
{
  "name": "summarize_file",
  "description": "Summarize the contents of a file",
  "arguments": [
    {
      "name": "path",
      "description": "Path to the file to summarize",
      "required": true
    },
    {
      "name": "style",
      "description": "Summary style: brief or detailed",
      "required": false
    }
  ]
}
```

### Prompt Message Roles

| Role | Use |
|---|---|
| `user` | The user's turn — the template content goes here |
| `assistant` | Pre-filled assistant response (use sparingly) |

Most prompt templates use a single `user` role message.

### When to Define Prompts

Define prompts when:
- There is a common, reusable way to start a task with this server's tools
- The task requires a specific phrasing to get good results
- The client UI can surface prompts as a menu or palette

Do not define prompts for:
- Ad-hoc interactions that vary too much to template
- Simple tool wrappers (prompts should add value beyond just calling a tool)

---

## Capability Declaration

Declare all three capability types in the server options:

```typescript
const server = new Server(
  { name: "my-server", version: "1.0.0" },
  {
    capabilities: {
      tools: {},
      resources: {},   // include only if server exposes resources
      prompts: {},     // include only if server exposes prompts
    },
  }
);
```

Omitting a capability type from the declaration prevents clients from attempting
to call those protocol methods.
