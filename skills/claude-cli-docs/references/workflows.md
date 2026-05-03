# Claude Code CLI — Workflows & Sub-agents

## Key Pages

| Page | URL |
| --- | --- |
| Common workflows | <https://code.claude.com/docs/en/common-workflows> |
| Best practices | <https://code.claude.com/docs/en/best-practices> |
| Sub-agents | <https://code.claude.com/docs/en/sub-agents> |
| Settings | <https://code.claude.com/docs/en/settings> |

## Common Workflows

```bash
# Explore and fix a bug
claude "find why the login endpoint returns 500 and fix it"

# Write and run tests
claude "write tests for the auth module, run them, and fix any failures"

# Commit with a good message
claude "commit my changes with a descriptive message"

# Create a PR
claude "open a PR for the changes on this branch"

# Review code for security issues
git diff main --name-only | claude -p "review changed files for security issues"

# Automate a CI step
claude -p "translate new strings into French and raise a PR for review"
```

## Sub-agents

Custom subagents live in `~/.claude/agents/` for user-wide use or
`.claude/agents/` for project-scoped use. Each is a Markdown file with YAML
frontmatter:

```markdown
---
name: test-runner
description: Runs tests and diagnoses failures. Use PROACTIVELY after edits.
tools: Bash, Read, Grep
---

Run focused tests, summarize failures, and identify the smallest fix.
```

Use `/agents` to create or edit subagents interactively. If `tools` is omitted,
the subagent inherits available tools, including MCP tools.

Full docs: <https://code.claude.com/docs/en/sub-agents>

## Best Practices

- Write a `CLAUDE.md` with build/test commands and project conventions
- Use `/plan` mode for large changes to review the approach before execution
- Use `/agents` for repeatable specialized roles instead of ad hoc delegation prompts
- Use `--permission-mode acceptEdits` for trusted automation scripts
- Use `--permission-mode auto` when the built-in classifier should decide safe actions
- Use `--bare -p` for fast scripts that should skip project auto-discovery
- Pipe output into Claude for analysis: `tail -f app.log | claude -p "alert on errors"`
- Use `--max-turns` to bound non-interactive runs

## Settings

Claude Code settings live in `~/.claude/settings.json` (global) and
`.claude/settings.json` (project, checked in) and `.claude/settings.local.json`
(project, gitignored).

Full settings reference: <https://code.claude.com/docs/en/settings>
