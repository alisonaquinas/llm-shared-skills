# Hook Placement And Discovery

This reference supports the hook automation rule lifecycle.

Use this reference when wiring the rule into its target runtime.

1. Identify the exact settings file or discovery path.
2. Prefer explicit absolute or repo-relative paths over implied search behavior.
3. Record any local settings file that must be updated.
4. Confirm the runtime can list or discover the rule after placement.
5. Run one live invocation to prove the wiring works.
6. Document runtime-specific caveats separately from the platform-neutral contract.
7. Keep shared and project-local placement rules distinct.
8. Confirm logs or diagnostics are reachable if discovery fails.
9. Capture rollback steps for incorrect registration.
10. Do not mark integration complete until discovery and one invocation both succeed.

## Runtime Notes

| Runtime | Placement | Discovery check |
| --- | --- | --- |
| Claude Code user | `~/.claude/settings.json` | Run `/hooks` |
| Claude Code project | `.claude/settings.json` or `.claude/settings.local.json` | Run `/hooks` from the project |
| Codex | `~/.codex/config.toml` hooks table, when the hook model is supported | Run `/debug-config` and inspect the effective hook layer |

Project hook commands should prefer `$CLAUDE_PROJECT_DIR/...` or equivalent
absolute paths so they work regardless of the process working directory.
Adapt environment-variable expansion to the runtime shell. For example,
PowerShell hook commands need `$env:CLAUDE_PROJECT_DIR/...`, while `cmd.exe`
needs `%CLAUDE_PROJECT_DIR%\...`.
