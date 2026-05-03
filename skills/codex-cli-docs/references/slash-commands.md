# Codex CLI — Slash Commands

## Reference Page

<https://developers.openai.com/codex/cli/slash-commands>

## Available Slash Commands

Slash commands are used inside an interactive Codex CLI session.

| Command | Description |
| --- | --- |
| `/permissions` | Update approval and sandbox preset during a session |
| `/model` | Choose model and reasoning effort |
| `/fast` | Toggle Fast mode for supported models |
| `/personality` | Choose communication style or disable personality instructions |
| `/plan` | Switch into planning mode |
| `/status` | Show model, approval policy, writable roots, and token usage |
| `/debug-config` | Show config layer and managed requirement diagnostics |
| `/mcp` | List configured MCP tools; use `verbose` for server details |
| `/apps` | Browse connectors and attach one to the prompt |
| `/plugins` | Browse, inspect, and manage plugins |
| `/agent` | Switch active agent thread |
| `/fork` | Fork the conversation into a new thread |
| `/side` | Start an ephemeral side conversation |
| `/resume` | Resume a saved conversation |
| `/new` | Start a new conversation in the same CLI session |
| `/compact` | Summarize older turns to free context |
| `/diff` | Show the diff of changes made so far |
| `/review` | Ask for a local code review |
| `/ps` | Inspect background terminals |
| `/stop` | Stop background terminals |
| `/sandbox-add-read-dir` | Grant Windows sandbox read access to an absolute directory |
| `/statusline` | Configure TUI footer fields |
| `/title` | Configure terminal title fields |
| `/keymap` | Remap TUI keyboard shortcuts |
| `/logout` | Sign out |
| `/clear` | Clear UI and start a fresh conversation |
| `/exit` or `/quit` | Exit the CLI session |

## Usage

Type a slash command at the Codex CLI prompt:

```text
> /model
Choose a model and reasoning effort

> /diff
--- a/src/auth.ts
+++ b/src/auth.ts
...
```

## Notes

- Slash commands are only available in interactive mode
- For non-interactive/scripted use, pass all options as CLI flags
- `/approvals` still works as an alias for `/permissions`, but may not appear in the popup
- Full up-to-date command list: <https://developers.openai.com/codex/cli/slash-commands>
