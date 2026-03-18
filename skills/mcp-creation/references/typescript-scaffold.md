# TypeScript MCP Server Scaffold

Load when building a TypeScript MCP server. Contains full project templates,
SDK usage patterns, and build/run commands.

---

## Project Initialization

```bash
npm create @modelcontextprotocol/server@latest my-server
cd my-server
npm install
```

Or manually scaffold:

```bash
mkdir my-server && cd my-server
npm init -y
npm install @modelcontextprotocol/sdk zod
npm install -D typescript @types/node tsx
```

---

## package.json Template

```json
{
  "name": "my-mcp-server",
  "version": "1.0.0",
  "description": "MCP server for ...",
  "type": "module",
  "main": "dist/index.js",
  "scripts": {
    "build": "tsc",
    "dev": "tsx watch src/index.ts",
    "start": "node dist/index.js",
    "test": "vitest"
  },
  "dependencies": {
    "@modelcontextprotocol/sdk": "^1.0.0",
    "zod": "^3.22.0"
  },
  "devDependencies": {
    "@types/node": "^20.0.0",
    "typescript": "^5.0.0",
    "tsx": "^4.0.0",
    "vitest": "^1.0.0"
  }
}
```

---

## tsconfig.json Template

```json
{
  "compilerOptions": {
    "target": "ES2022",
    "module": "Node16",
    "moduleResolution": "Node16",
    "outDir": "dist",
    "rootDir": "src",
    "strict": true,
    "esModuleInterop": true,
    "skipLibCheck": true
  },
  "include": ["src/**/*"],
  "exclude": ["node_modules", "dist"]
}
```

---

## Complete src/index.ts

```typescript
import { Server } from "@modelcontextprotocol/sdk/server/index.js";
import { StdioServerTransport } from "@modelcontextprotocol/sdk/server/stdio.js";
import {
  CallToolRequestSchema,
  ListToolsRequestSchema,
  ListResourcesRequestSchema,
  ReadResourceRequestSchema,
  ListPromptsRequestSchema,
  GetPromptRequestSchema,
} from "@modelcontextprotocol/sdk/types.js";
import { z } from "zod";

const server = new Server(
  { name: "my-server", version: "1.0.0" },
  {
    capabilities: {
      tools: {},
      resources: {},
      prompts: {},
    },
  }
);

// ── Tool Registration ────────────────────────────────────────────────────────

server.setRequestHandler(ListToolsRequestSchema, async () => ({
  tools: [
    {
      name: "echo",
      description: "Returns the input message unchanged. Useful for testing connectivity.",
      inputSchema: {
        type: "object",
        properties: {
          message: {
            type: "string",
            description: "The message to echo back",
          },
        },
        required: ["message"],
      },
    },
  ],
}));

server.setRequestHandler(CallToolRequestSchema, async (request) => {
  const { name, arguments: args } = request.params;

  if (name === "echo") {
    const { message } = z.object({ message: z.string() }).parse(args);
    return {
      content: [{ type: "text", text: message }],
      isError: false,
    };
  }

  return {
    content: [{ type: "text", text: `Unknown tool: ${name}` }],
    isError: true,
  };
});

// ── Resource Registration ────────────────────────────────────────────────────

server.setRequestHandler(ListResourcesRequestSchema, async () => ({
  resources: [
    {
      uri: "info://server",
      name: "Server Info",
      description: "Basic information about this server",
      mimeType: "text/plain",
    },
  ],
}));

server.setRequestHandler(ReadResourceRequestSchema, async (request) => {
  const { uri } = request.params;
  if (uri === "info://server") {
    return {
      contents: [
        {
          uri,
          mimeType: "text/plain",
          text: "my-server v1.0.0 — MCP server",
        },
      ],
    };
  }
  throw new Error(`Unknown resource: ${uri}`);
});

// ── Prompt Registration ──────────────────────────────────────────────────────

server.setRequestHandler(ListPromptsRequestSchema, async () => ({
  prompts: [
    {
      name: "greet",
      description: "Generate a greeting message",
      arguments: [
        { name: "name", description: "Name to greet", required: true },
      ],
    },
  ],
}));

server.setRequestHandler(GetPromptRequestSchema, async (request) => {
  const { name, arguments: args } = request.params;
  if (name === "greet") {
    const userName = (args?.name as string) ?? "World";
    return {
      messages: [
        {
          role: "user",
          content: { type: "text", text: `Please greet ${userName} warmly.` },
        },
      ],
    };
  }
  throw new Error(`Unknown prompt: ${name}`);
});

// ── Server Startup ───────────────────────────────────────────────────────────

async function main() {
  const transport = new StdioServerTransport();
  await server.connect(transport);
  // All diagnostic output must go to stderr — stdout is the MCP protocol channel
  process.stderr.write("my-server started\n");
}

main().catch((err) => {
  process.stderr.write(`Fatal error: ${err}\n`);
  process.exit(1);
});
```

---

## Build and Run

```bash
npm run build          # Compile TypeScript → dist/
node dist/index.js     # Run the compiled server (used in client config)
npm run dev            # Run with hot-reload during development (tsx watch)
```

---

## Error Handling Pattern

Return error content instead of throwing uncaught exceptions from tool handlers:

```typescript
try {
  const result = await doWork(args);
  return { content: [{ type: "text", text: result }], isError: false };
} catch (err) {
  return {
    content: [{ type: "text", text: `Error: ${err instanceof Error ? err.message : String(err)}` }],
    isError: true,
  };
}
```

Throwing from a tool handler crashes the server for stdio transport. Always catch
and return an error content block.

---

## Logging Rules

- **Use `process.stderr.write()`** for all diagnostic output
- **Never use `console.log()`** in stdio servers — it writes to stdout and corrupts the JSON-RPC stream
- `console.error()` is acceptable (writes to stderr) but `process.stderr.write()` is preferred for clarity
