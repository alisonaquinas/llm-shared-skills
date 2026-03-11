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
| `--model <id>` | Override the model (e.g. `--model claude-opus-4-6`) |
| `--output-format` | Output format: `text`, `json`, `stream-json` |
| `--max-turns <n>` | Limit agentic turns in non-interactive mode |
| `--allowedTools` | Comma-separated list of tools to enable |
| `--disallowedTools` | Comma-separated list of tools to block |
| `--system-prompt` | Override the system prompt |
| `--append-system-prompt` | Append to the system prompt |
| `--permission-mode` | Permission mode: `default`, `acceptEdits`, `bypassPermissions`, `plan` |
| `--no-stream` | Disable streaming (wait for full response) |
| `--verbose` | Enable verbose/debug output |
| `--dangerously-skip-permissions` | Skip all permission prompts (use with care) |
| `--resume <session-id>` | Resume a previous session |
| `--continue` | Resume the most recent session |

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

Full slash command list → <https://code.claude.com/docs/en/cli-reference>
