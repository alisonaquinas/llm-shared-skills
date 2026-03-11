# Codex CLI — Features

## Reference Page

<https://developers.openai.com/codex/cli/features>

## What the Codex CLI Does

Codex CLI is a lightweight terminal-based coding agent that runs locally. It can:

- **Read and understand your codebase** — explore files, understand architecture
- **Generate code** — write new features, scripts, or boilerplate from descriptions
- **Edit existing files** — apply targeted changes across multiple files
- **Run commands** — execute build, test, and lint commands to verify changes
- **Debug** — trace errors, find root causes, suggest and apply fixes
- **Review code** — analyze for bugs, security issues, logic errors
- **Explain code** — describe what unfamiliar code does in plain language
- **Refactor** — restructure code while preserving behavior

## Execution Model

Codex CLI runs tasks in your local environment. It has access to:

- Your filesystem (read/write files)
- Terminal (run shell commands)
- Git (create branches, commits, PRs)

It does NOT upload your code to OpenAI servers by default — execution is local.

## Approval Modes

| Mode | Behavior |
| --- | --- |
| Default | Asks approval before file writes and command execution |
| `--approval-mode auto` | Approves safe operations automatically |
| `--non-interactive` | Fully automated, no prompts |

## AGENTS.md Support

Codex CLI reads `AGENTS.md` at the project root for project-specific instructions.
Place architecture notes, build commands, and coding conventions there.

Full AGENTS.md docs: <https://developers.openai.com/codex/config/agents-md>
