# Claude Code CLI — Command Reference

## Reference Page

<https://code.claude.com/docs/en/cli-reference>

## Basic Usage

```bash
claude                        # start interactive session in current directory
claude "do something"         # run a one-shot task
claude -p "prompt here"       # print mode — output to stdout, no interaction
```

## Key Flags

| Flag | Description |
| --- | --- |
| `-p, --print` | Non-interactive: print response to stdout and exit |
| `--model <id>` | Override the model. Use the canonical model alias (e.g. `claude-opus-<latest>` or a pinned ID from `https://platform.claude.com/docs/en/about-claude/models/overview`). |
| `--output-format` | Output format: `text`, `json`, `stream-json` |
| `--max-turns <n>` | Limit agentic turns in non-interactive mode |
| `--allowedTools` | Comma-separated list of tools to enable |
| `--disallowedTools` | Comma-separated list of tools to block |
| `--tools` | Restrict available built-in tools |
| `--system-prompt` | Override the system prompt |
| `--append-system-prompt` | Append to the system prompt |
| `--permission-mode` | `default`, `acceptEdits`, `plan`, `auto`, `dontAsk`, `bypassPermissions` |
| `--bare` | Minimal scripted mode; skip hooks, skills, plugins, MCP, memory, and CLAUDE.md |
| `--add-dir` | Grant access to extra directories |
| `--mcp-config` | Load MCP servers from JSON files or strings |
| `--strict-mcp-config` | Ignore all MCP config except `--mcp-config` |
| `--debug` | Enable debug logging by category |
| `--verbose` | Enable verbose/debug output |
| `--dangerously-skip-permissions` | Skip all permission prompts (use with care) |
| `--resume <session-id>` | Resume a previous session |
| `--continue` | Resume the most recent session |
| `--worktree` | Start in an isolated git worktree |
| `--remote` | Create a web session from the task description |

## Pipe / Script Usage

```bash
# Pipe input
echo "explain this" | claude -p

# Pipe logs for analysis
tail -f app.log | claude -p "alert me if you see errors"

# Bulk file review
git diff main --name-only | claude -p "review changed files for security issues"

# Non-interactive automation
claude -p "translate new strings into French and raise a PR"

# Minimal scripted run with no project auto-discovery
claude --bare -p "summarize this repository"
```

## Slash Commands (in interactive mode)

| Command | Description |
| --- | --- |
| `/help` | Show help |
| `/clear` | Clear conversation |
| `/compact` | Compact conversation history |
| `/cost` | Show token usage |
| `/model` | Switch model |
| `/permissions` | View current permissions |
| `/review` | Review pending edits before applying |
| `/plan` | Enter plan mode |
| `/agents` | Manage custom subagents |
| `/hooks` | Inspect or configure hooks |
| `/schedule` | Create or manage cron-scheduled routines (remote agents). See `references/routines-and-dispatch.md` |
| `/loop` | Run a prompt or slash command on a recurring interval (e.g. `/loop 5m /foo`); omit interval to let the model self-pace |
| `/teleport` | Move a web or iOS session into the local terminal (cross-device handoff) |

Full slash command list → <https://code.claude.com/docs/en/cli-reference>
