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
| `UserPromptSubmit` | Before a user prompt is processed |
| `Stop` | When Claude stops (task complete or error) |
| `SubagentStop` | When a subagent completes |
| `PreCompact` | Before conversation compaction |
| `SessionStart` | At session startup |
| `SessionEnd` | At session end |

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
            "command": "$CLAUDE_PROJECT_DIR/.claude/hooks/format.sh"
          }
        ]
      }
    ]
  }
}
```

Command strings are interpreted by the user's shell. On Windows, do not copy the
POSIX `$CLAUDE_PROJECT_DIR/...` expansion literally; use the shell's environment
syntax instead.

For PowerShell:

```json
{
  "type": "command",
  "command": "pwsh -NoProfile -File \"$env:CLAUDE_PROJECT_DIR/.claude/hooks/format.ps1\""
}
```

For `cmd.exe`:

```json
{
  "type": "command",
  "command": "pwsh -NoProfile -File \"%CLAUDE_PROJECT_DIR%\\.claude\\hooks\\format.ps1\""
}
```

## Hook Input

Hook commands receive JSON on stdin. `CLAUDE_PROJECT_DIR` is available when the
CLI spawns the hook command and points at the project root.

| Detail | Notes |
| --- | --- |
| stdin | Event payload as JSON |
| `CLAUDE_PROJECT_DIR` | Absolute project root |
| timeout | Defaults to 60 seconds per command; configurable per hook |
| execution | Matching hooks run in parallel; identical commands are deduplicated |

## Hook Return Values

Hooks can use exit codes or JSON stdout to influence behavior:

- Exit `0` — success. stdout is usually shown only to the user, except selected context-injection events.
- Exit `2` — blocking error. stderr is fed back according to the event.
- Other non-zero exits — non-blocking error; stderr is shown to the user.
- JSON stdout can include `continue`, `stopReason`, `suppressOutput`, or event-specific decisions.
