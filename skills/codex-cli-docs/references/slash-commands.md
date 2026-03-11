# Codex CLI — Slash Commands

## Reference Page

<https://developers.openai.com/codex/cli/slash-commands>

## Available Slash Commands

Slash commands are used inside an interactive Codex CLI session.

| Command | Description |
| --- | --- |
| `/help` | Show available commands and usage |
| `/clear` | Clear the current conversation context |
| `/model <id>` | Switch to a different model mid-session |
| `/exit` or `/quit` | Exit the Codex CLI session |
| `/undo` | Undo the last file change |
| `/diff` | Show the diff of changes made so far |
| `/approve` | Approve a pending action |
| `/reject` | Reject a pending action |

## Usage

Type a slash command at the Codex CLI prompt:

```text
> /model o3
Switched to model: o3

> /diff
--- a/src/auth.ts
+++ b/src/auth.ts
...
```

## Notes

- Slash commands are only available in interactive mode
- For non-interactive/scripted use, pass all options as CLI flags
- Full up-to-date command list: <https://developers.openai.com/codex/cli/slash-commands>
