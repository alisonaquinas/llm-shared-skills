# Client Configuration Patterns

Load when doing initial client configuration, setting up mcpServers blocks,
or passing environment variables to a server.

---

## Claude Code: User-Scope Configuration

Applies to all projects for the current user.

**File:** `~/.claude/settings.json`

```json
{
  "mcpServers": {
    "my-server": {
      "command": "node",
      "args": ["/Users/alice/projects/my-server/dist/index.js"],
      "env": {}
    }
  }
}
```

---

## Claude Code: Project-Scope Configuration

Applies to the current project only. Overrides user-scope for the same server name.

**File:** `.claude/settings.json` (in project root, commit to version control)

```json
{
  "mcpServers": {
    "my-server": {
      "command": "node",
      "args": ["/absolute/path/to/dist/index.js"]
    }
  }
}
```

**Important:** Use absolute paths even in project config. Relative paths are resolved
from the client's working directory, which may not be the project root.

---

## Claude Desktop: macOS Configuration

**File:** `~/Library/Application Support/Claude/claude_desktop_config.json`

```json
{
  "mcpServers": {
    "my-server": {
      "command": "node",
      "args": ["/Users/alice/projects/my-server/dist/index.js"]
    }
  }
}
```

After editing, restart Claude Desktop (Cmd+Q, then relaunch).

---

## Claude Desktop: Windows Configuration

**File:** `%APPDATA%\Claude\claude_desktop_config.json`
(typically `C:\Users\<username>\AppData\Roaming\Claude\claude_desktop_config.json`)

```json
{
  "mcpServers": {
    "my-server": {
      "command": "node",
      "args": ["C:\\Users\\alice\\projects\\my-server\\dist\\index.js"]
    }
  }
}
```

Use double backslashes in JSON strings, or forward slashes (both work on Windows Node.js).

---

## Python Server Configuration

```json
{
  "mcpServers": {
    "my-python-server": {
      "command": "python",
      "args": ["/absolute/path/to/server.py"]
    }
  }
}
```

If using `uv`:
```json
{
  "mcpServers": {
    "my-python-server": {
      "command": "uv",
      "args": ["run", "/absolute/path/to/server.py"]
    }
  }
}
```

---

## Environment Variables

Pass secrets and configuration via the `env` block:

```json
{
  "mcpServers": {
    "my-server": {
      "command": "node",
      "args": ["/path/to/dist/index.js"],
      "env": {
        "API_KEY": "sk-...",
        "DATABASE_URL": "postgres://...",
        "LOG_LEVEL": "info"
      }
    }
  }
}
```

**Security note:** Values in `settings.json` are stored in plaintext. For sensitive
secrets, prefer having the server read from a `.env` file at startup:

```typescript
import { config } from "dotenv";
config({ path: "/absolute/path/to/.env" });
const apiKey = process.env.API_KEY;
```

---

## Multiple Servers

Multiple servers can be registered simultaneously. Each gets a unique key:

```json
{
  "mcpServers": {
    "filesystem": {
      "command": "node",
      "args": ["/path/to/filesystem-server/dist/index.js"]
    },
    "database": {
      "command": "python",
      "args": ["/path/to/db-server/server.py"],
      "env": {"DATABASE_URL": "..."}
    },
    "web-search": {
      "url": "http://localhost:3001/sse"
    }
  }
}
```

The server key (e.g., `filesystem`) becomes part of the tool name in the client:
`mcp__filesystem__read_file`, `mcp__database__query`, etc.

---

## SSE Server Configuration

For servers using HTTP/SSE transport:

```json
{
  "mcpServers": {
    "remote-server": {
      "url": "https://my-server.example.com/sse"
    }
  }
}
```

With authentication header:
```json
{
  "mcpServers": {
    "remote-server": {
      "url": "https://my-server.example.com/sse",
      "headers": {
        "Authorization": "Bearer my-token"
      }
    }
  }
}
```

---

## PreToolCall Hook: Safety Gate for Dangerous Tools

Intercept specific tools before execution — useful for file-write or shell-execution tools:

```json
{
  "hooks": {
    "PreToolCall": [
      {
        "matcher": "mcp__my-server__write_file",
        "hooks": [
          {
            "type": "command",
            "command": "echo \"About to write file via MCP\" >&2"
          }
        ]
      }
    ]
  }
}
```

The matcher syntax `mcp__<server-key>__<tool-name>` targets a specific tool on a
specific server. Use `mcp__my-server__*` to intercept all tools on a server.
