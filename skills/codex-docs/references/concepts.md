# OpenAI Codex — Concepts

## Key Pages

| Topic | URL |
| --- | --- |
| Prompting | <https://developers.openai.com/codex/concepts/prompting> |
| Customization | <https://developers.openai.com/codex/concepts/customization> |
| Sandboxing | <https://developers.openai.com/codex/concepts/sandboxing> |
| Multi-agents | <https://developers.openai.com/codex/concepts/multi-agents> |
| Workflows | <https://developers.openai.com/codex/concepts/workflows> |
| Models | <https://developers.openai.com/codex/concepts/models> |
| Cyber safety | <https://developers.openai.com/codex/concepts/cyber-safety> |

## Sandboxing

Codex runs tasks in isolated sandbox environments with internet access restricted to
allowlisted domains. This ensures safety during automated code execution. Each task
gets a fresh environment cloned from your repository.

## Multi-agent Workflows

Codex supports spawning multiple agent instances to work on tasks in parallel.
Useful for large refactors, running tests across multiple configurations, or
parallelizing independent feature work.

## Prompting Tips

- Be specific about acceptance criteria ("write tests that cover edge cases X, Y, Z")
- Reference file paths, function names, or existing patterns
- State constraints explicitly ("do not change the public API")
- For complex tasks, break into subtasks or use AGENTS.md to set context

## Customization

Codex behavior can be customized via:

- **AGENTS.md** — project-level instructions (see configuration.md)
- **Rules** — reusable instruction sets
- **Skills** — packaged workflows (see configuration.md)
- **MCP** — connect external tools (see configuration.md)
