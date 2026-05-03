# Agent Placement And Discovery

This reference supports the delegated agent workflow lifecycle.

Use this reference when wiring the workflow into its target runtime.

1. Identify the exact discovery path or config surface.
2. Prefer explicit absolute or repo-relative paths over implied search behavior.
3. Record any local settings file that must be updated.
4. Confirm the runtime can list or discover the workflow after placement.
5. Run one live invocation to prove the wiring works.
6. Document runtime-specific caveats separately from the platform-neutral contract.
7. Keep shared and project-local placement rules distinct.
8. Confirm logs or diagnostics are reachable if discovery fails.
9. Capture rollback steps for incorrect registration.
10. Do not mark integration complete until discovery and one invocation both succeed.

## Runtime Notes

| Runtime | Placement | Discovery check |
| --- | --- | --- |
| Claude Code user subagent | `~/.claude/agents/<name>.md` | Run `claude agents` or `/agents` |
| Claude Code project subagent | `.claude/agents/<name>.md` | Run `/agents` from the project |
| Codex subagent workflow | Codex subagent/skill/plugin config for the target surface | Run `/agent`, `/plugins`, or `/status` depending on surface |

Claude Code subagent files require `name` and `description` frontmatter. `tools`
is optional; when omitted, the subagent inherits available tools, including MCP
tools.
