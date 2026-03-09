---
name: zoxide-navigation
description: Efficient terminal directory navigation with zoxide (`z`, `zi`, and `zoxide query`). Use when users ask to jump to frequently used directories, select directories by keywords, troubleshoot zoxide shell setup, or resolve ranked directory matches for scripts.
---

# Zoxide Navigation

Use zoxide-first navigation when the target directory is implied by keywords or history instead of a fixed absolute path.

## Workflow
1. Confirm intent:
- Exact path available -> use `cd <path>`.
- Best historical match by keywords -> use `z <keywords>`.
- User wants to choose among matches -> use `zi <keywords>` or `zoxide query -i <keywords>`.
- Script needs path without changing directory -> use `zoxide query <keywords>`.
2. Confirm setup when needed:
- `command -v zoxide`
- `type z`
- `type zi`
3. Run the mapped command:
- Jump to best match: `z <keywords>`
- Interactive picker: `zi <keywords>`
- Return best match path: `zoxide query <keywords>`
- List matches: `zoxide query -l <keywords>`
- List matches with score: `zoxide query -ls <keywords>`
- Add path explicitly: `zoxide add <path>`
- Remove stale path: `zoxide remove <path>`
4. Validate destination before risky operations:
- Print `pwd` after jump, or inspect with `zoxide query -l <keywords>` first.

## Automation Guardrails
- Prefer deterministic path resolution in scripts:
```bash
target="$(zoxide query <keywords>)"
cd "$target"
```
- Use `zoxide query` in automation instead of `z`, because `z` depends on shell integration and interactive session state.
- For destructive or high-impact work, resolve with `query -l` and verify the chosen directory explicitly.

## Troubleshooting
- `z` or `zi` missing: initialize shell integration with `zoxide init <shell>` and load it from shell startup files.
- Wrong match chosen: add more keywords or inspect ranked results with `zoxide query -ls <keywords>`.
- Stale entries: run `zoxide remove <path>` or `zoxide edit`.
- No results: navigate manually once, then run `zoxide add <path>` if needed.

## Environment Knobs
- `_ZO_ECHO=1`: print matched path before changing directory.
- `_ZO_EXCLUDE_DIRS`: exclude glob patterns from ranking.
- `_ZO_MAXAGE`: tune aging and cleanup aggressiveness.
- `_ZO_FZF_OPTS`: customize interactive picker behavior.
