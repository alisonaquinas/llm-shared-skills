# Claude Code CLI — Hooks

## Reference Page

<https://code.claude.com/docs/en/hooks>

## What are Hooks?

Hooks let you run shell commands before or after Claude Code actions. Examples:

- Auto-format after every file edit
- Run lint before a commit
- Post a notification when Claude completes a task
- Log tool usage for auditing

## Hook Events

| Event | Fires when... |
| --- | --- |
| `PreToolUse` | Before any tool is called |
| `PostToolUse` | After any tool completes |
| `Notification` | When Claude sends a notification |
| `Stop` | When Claude stops (task complete or error) |

## Configure Hooks

In `~/.claude/settings.json`:

```json
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "Write",
        "hooks": [
          {
            "type": "command",
            "command": "prettier --write $CLAUDE_TOOL_INPUT_FILE_PATH"
          }
        ]
      }
    ]
  }
}
```

## Environment Variables in Hooks

Claude Code passes context to hooks via environment variables:

| Variable | Value |
| --- | --- |
| `CLAUDE_TOOL_NAME` | Name of the tool that fired the hook |
| `CLAUDE_TOOL_INPUT_FILE_PATH` | File path (for file-editing tools) |
| `CLAUDE_TOOL_INPUT` | Full JSON input to the tool |
| `CLAUDE_TOOL_OUTPUT` | Tool output (PostToolUse only) |

## Hook Return Values

Hooks can return JSON to influence Claude's behavior:

- `{"decision": "block", "reason": "..."}` — block the tool call
- `{"decision": "approve"}` — approve without prompting
