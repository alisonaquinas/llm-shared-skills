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
- **Use external context** — connect MCP servers, apps/connectors, plugins, skills, and subagents
- **Handle multimodal work** — attach images, screenshots, and design references

## Execution Model

Codex CLI runs tasks in your local environment. It has access to:

- Your filesystem (read/write files)
- Terminal (run shell commands)
- Git (create branches, commits, PRs)

File edits and shell commands execute locally in the selected workspace. Prompts,
summaries, and selected context are sent to the configured model provider.

## Approval & Sandbox

| Mode | Behavior |
| --- | --- |
| `--ask-for-approval on-request` | Prompt before commands when Codex asks for approval |
| `--ask-for-approval never` | Do not prompt; pair with a sandbox for automation |
| `--sandbox read-only` | Let commands inspect, not mutate |
| `--sandbox workspace-write` | Allow writes inside the workspace |
| `--sandbox danger-full-access` | No filesystem sandbox; use only in trusted environments |

## AGENTS.md Support

Codex CLI reads `AGENTS.md` at the project root for project-specific instructions.
Place architecture notes, build commands, and coding conventions there.

Full AGENTS.md docs: <https://developers.openai.com/codex/guides/agents-md>
