# Command Placement And Discovery

This reference supports the reusable command workflow lifecycle.

Use this reference when wiring the workflow into its target runtime.

1. Identify the exact discovery path or config surface.
2. Prefer explicit absolute or repo-relative paths over implied search behavior.
3. Record any local settings file that must be updated.
4. Confirm the runtime can list or discover the workflow after placement.
5. Run one live invocation to prove the wiring works.
6. Document any runtime-specific caveat separately from the platform-neutral contract.
7. Keep shared and project-local placement rules distinct.
8. Confirm logs or diagnostics are reachable if discovery fails.
9. Capture rollback steps for incorrect registration.
10. Do not mark integration complete until discovery and one invocation both succeed.

## Runtime Notes

| Runtime | Placement | Discovery check |
| --- | --- | --- |
| Claude Code project command | `.claude/commands/<name>.md` | Type `/` and find the command |
| Claude Code user command | `~/.claude/commands/<name>.md` | Type `/` in any project |
| Claude Code MCP prompt | MCP server prompt | Confirm `/mcp__server__prompt` appears |
| Codex reusable workflow | Skill or plugin, not an arbitrary slash-command file | Run `/plugins`, `/status`, or invoke the skill |

For Codex, do not assume that adding a Markdown file creates a slash command.
Prefer skills, plugins, MCP prompts/tools, or documented CLI flags depending on
the workflow.
