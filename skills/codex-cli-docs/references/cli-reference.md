# Codex CLI — Command Reference

## Reference Page

<https://developers.openai.com/codex/cli/reference>

## Basic Usage

```bash
codex                           # start interactive session
codex "describe the codebase"   # one-shot task
codex --non-interactive "..."   # fully automated, no prompts
```

## Key Flags

| Flag | Description |
| --- | --- |
| `--non-interactive` | Run without prompts; exit when done |
| `--approval-mode <mode>` | `suggest` (default), `auto`, `full-auto` |
| `--model <id>` | Override model (e.g. `--model o4-mini`) |
| `--api-key <key>` | Provide API key directly |
| `--quiet` | Suppress non-essential output |
| `--verbose` | Enable verbose/debug output |
| `--cwd <path>` | Set working directory |
| `--config <path>` | Path to config file |

## Approval Modes

| Mode | Description |
| --- | --- |
| `suggest` | Shows proposed changes, asks before applying |
| `auto` | Automatically applies safe changes (no shell commands) |
| `full-auto` | Applies all changes and runs commands without asking |

## Pipe Usage

```bash
# Pipe a file for analysis
cat error.log | codex "what is causing these errors?"

# Pipe git diff for review
git diff | codex "review these changes for issues"
```

## Auth Subcommand

```bash
codex auth login    # sign in via browser
codex auth logout   # sign out
codex auth status   # check current auth state
```

Full reference: <https://developers.openai.com/codex/cli/reference>
