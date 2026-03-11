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

Claude Code can spawn multiple agent instances to work in parallel:

```bash
claude "spawn 3 agents to implement feature A, B, and C in parallel,
        then merge the results"
```

Sub-agents share the same tool set but work in isolated contexts. The orchestrator
coordinates and merges their output.

Full docs: <https://code.claude.com/docs/en/sub-agents>

## Best Practices

- Write a `CLAUDE.md` with build/test commands and project conventions
- Use `/plan` mode for large changes to review the approach before execution
- Use `--permission-mode acceptEdits` for trusted automation scripts
- Pipe output into Claude for analysis: `tail -f app.log | claude -p "alert on errors"`
- Use `--max-turns` to bound non-interactive runs

## Settings

Claude Code settings live in `~/.claude/settings.json` (global) and
`.claude/settings.json` (project, checked in) and `.claude/settings.local.json`
(project, gitignored).

Full settings reference: <https://code.claude.com/docs/en/settings>
