# Phase 6: Integration

Gate-focused reference for the MCP SDLC integration phase. Load when entering
or reviewing Phase 6.

---

## Pre-Entry Checklist

Before starting Phase 6:
- [ ] Phase 5 gate passed: verification checklist all PASS
- [ ] Build is current and server binary exists
- [ ] Absolute path to server entry point is known

---

## Phase 6 Deliverables

Produce all before moving to Phase 7:

1. **settings.json entry** — mcpServers block with correct absolute paths
2. **Successful connection** — Client starts and connects to the server
3. **Tool visibility confirmed** — All declared tools appear in client UI

---

## Key Configuration Snippet

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

Add to `~/.claude/settings.json` (user scope) or `.claude/settings.json` (project).
Start a new session after saving for the config to take effect.

For Python:
```json
{
  "mcpServers": {
    "my-server": {
      "command": "python",
      "args": ["/absolute/path/to/server.py"]
    }
  }
}
```

---

## Verification Steps

1. Save settings.json
2. Start a new conversation
3. Ask "what MCP tools do you have?" or type `/mcp`
4. Confirm server name and all tool names appear
5. Call one tool to verify end-to-end function

---

## Gate Criterion

Phase 6 is complete when the client connects, all tools are visible in the UI,
and at least one tool call succeeds in a live session.

---

## Common Failures

1. **Relative path in `args`** — `"args": ["dist/index.js"]` fails when the
   client's CWD is not the project root. Fix: use the full absolute path.

2. **Wrong Node or Python version on PATH** — The binary in `command` resolves
   to an older version without the required features. Fix: specify the absolute
   path to the binary: `"command": "/usr/local/bin/node"`.

3. **Missing build before integration** — Connecting to a server with stale `dist/`
   may cause import errors or missing tools. Fix: run `npm run build` immediately
   before adding the server to settings.json.
