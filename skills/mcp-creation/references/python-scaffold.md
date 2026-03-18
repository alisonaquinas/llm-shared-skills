# Python MCP Server Scaffold

Load when building a Python MCP server. Contains full project templates,
FastMCP usage patterns, and run commands.

---

## Project Initialization

```bash
pip install mcp
# or using uv (recommended for isolation):
uv init my-server
cd my-server
uv add mcp
```

---

## pyproject.toml Template

```toml
[build-system]
requires = ["hatchling"]
build-backend = "hatchling.build"

[project]
name = "my-mcp-server"
version = "1.0.0"
description = "MCP server for ..."
requires-python = ">=3.10"
dependencies = [
    "mcp>=1.0.0",
]

[project.scripts]
my-server = "my_server.server:main"

[tool.hatch.build.targets.wheel]
packages = ["src/my_server"]
```

---

## Complete server.py (FastMCP style)

```python
import sys
from mcp.server.fastmcp import FastMCP

# Create the server — name appears in client UI
mcp = FastMCP("my-server")


# ── Tool Definitions ─────────────────────────────────────────────────────────

@mcp.tool()
def echo(message: str) -> str:
    """Return the input message unchanged. Useful for testing connectivity."""
    return message


@mcp.tool()
def add_numbers(a: float, b: float) -> str:
    """Add two numbers and return the result as a string."""
    try:
        result = a + b
        return str(result)
    except Exception as e:
        # Return error as content rather than raising
        return f"Error: {e}"


# ── Resource Definitions ─────────────────────────────────────────────────────

@mcp.resource("info://server")
def server_info() -> str:
    """Basic information about this server."""
    return "my-server v1.0.0 — MCP server"


@mcp.resource("data://{key}")
def get_data(key: str) -> str:
    """Retrieve a data item by key."""
    store = {"example": "example value"}
    return store.get(key, f"Key not found: {key}")


# ── Prompt Definitions ───────────────────────────────────────────────────────

@mcp.prompt()
def greet(name: str) -> str:
    """Generate a greeting message for the given name."""
    return f"Please greet {name} warmly."


# ── Server Startup ───────────────────────────────────────────────────────────

def main():
    # stdio transport is the default — runs the server over stdin/stdout
    # All diagnostic output must go to stderr
    print("my-server started", file=sys.stderr)
    mcp.run()


if __name__ == "__main__":
    main()
```

---

## Low-Level Server Style (without FastMCP)

For servers requiring fine-grained control:

```python
import asyncio
import sys
from mcp.server import Server
from mcp.server.stdio import stdio_server
from mcp import types

server = Server("my-server")


@server.list_tools()
async def list_tools() -> list[types.Tool]:
    return [
        types.Tool(
            name="echo",
            description="Return the input message unchanged.",
            inputSchema={
                "type": "object",
                "properties": {
                    "message": {"type": "string", "description": "Message to echo"}
                },
                "required": ["message"],
            },
        )
    ]


@server.call_tool()
async def call_tool(name: str, arguments: dict) -> list[types.TextContent]:
    if name == "echo":
        return [types.TextContent(type="text", text=arguments["message"])]
    raise ValueError(f"Unknown tool: {name}")


async def main():
    async with stdio_server() as (read_stream, write_stream):
        await server.run(read_stream, write_stream, server.create_initialization_options())


if __name__ == "__main__":
    asyncio.run(main())
```

---

## Run Commands

```bash
python server.py          # Run directly (used in client config)
uv run server.py          # Run with uv (resolves venv automatically)
python -m my_server       # If installed as a package
```

---

## Error Handling Pattern

FastMCP style — return error as string rather than raising:

```python
@mcp.tool()
def read_file(path: str) -> str:
    """Read a file and return its contents."""
    try:
        with open(path, "r") as f:
            return f.read()
    except FileNotFoundError:
        return f"Error: file not found at {path}"
    except PermissionError:
        return f"Error: permission denied reading {path}"
    except Exception as e:
        return f"Error: {e}"
```

Low-level style — use `types.TextContent` with error text:

```python
@server.call_tool()
async def call_tool(name: str, arguments: dict):
    try:
        result = await do_work(arguments)
        return [types.TextContent(type="text", text=result)]
    except Exception as e:
        return [types.TextContent(type="text", text=f"Error: {e}")]
```

---

## Logging Rules

- **Use `sys.stderr`** for all diagnostic output
- **Never use `print()` without `file=sys.stderr`** in stdio servers
- The default `print()` writes to stdout and corrupts the JSON-RPC stream

```python
# Correct
print("debug info", file=sys.stderr)

# Wrong — corrupts stdio protocol
print("debug info")
```
