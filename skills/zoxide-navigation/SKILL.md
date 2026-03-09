---
name: zoxide-navigation
description: >
  Efficient terminal directory navigation with zoxide (`z`, `zi`, and `zoxide query`).
  Use when users ask to jump to frequently used directories, select directories by keywords,
  set up or troubleshoot zoxide shell integration, resolve ranked directory matches for scripts,
  migrate from z/autojump/fasd, configure fzf interactive mode, or investigate database location.
---

# Zoxide Navigation

Use zoxide-first navigation when the target directory is implied by keywords or history instead of a fixed absolute path.

## Intent Router

| Request | Reference | Load When |
| --- | --- | --- |
| Install tool, first-time setup | `references/install-and-setup.md` | User needs to install zoxide or fzf, or do initial shell setup |
| Shell setup, fzf config, migration | `references/zoxide-setup-and-config.md` | User needs init commands, database location, or fzf setup |
| Preflight and environment | `scripts/probe-zoxide.sh` | Verify shell integration and check database status |

## Quick Setup

```bash
# Initialize in shell startup file (~/.bashrc, ~/.zshrc, etc.)
eval "$(zoxide init bash)"

# Or for zsh:
eval "$(zoxide init zsh)"
```

## Workflow

1. Confirm intent:

- Exact path available -> use `cd <path>`.
- Best historical match by keywords -> use `z <keywords>`.
- User wants to choose among matches -> use `zi <keywords>` or `zoxide query -i <keywords>`.
- Script needs path without changing directory -> use `zoxide query <keywords>`.

1. Confirm setup when needed:

- `command -v zoxide`
- `type z`
- `type zi`

1. Run the mapped command:

- Jump to best match: `z <keywords>`
- Interactive picker: `zi <keywords>`
- Return best match path: `zoxide query <keywords>`
- List matches: `zoxide query -l <keywords>`
- List matches with score: `zoxide query -ls <keywords>`
- Add path explicitly: `zoxide add <path>`
- Remove stale path: `zoxide remove <path>`

1. Validate destination before risky operations:

- Print `pwd` after jump, or inspect with `zoxide query -l <keywords>` first.

## Safety and Guardrails

| Operation | Guardrail | Why |
| --- | --- | --- |
| **Interactive jump** | Use `zi` or verify with `zoxide query -l` first | Multiple matches may not be what expected |
| **Destructive ops** | Validate target with `pwd` after jump | Verify correct directory before rm/move |
| **Scripts** | Use `zoxide query` not `z` | `z` depends on shell integration; not reliable in subshells |
| **High-impact** | Resolve and inspect with `zoxide query -l <keywords>` before proceeding | Confirm directory explicitly |

## Automation Guardrails

- Prefer deterministic path resolution in scripts:

```bash
target="$(zoxide query <keywords>)"
cd "$target"
```

- Use `zoxide query` in automation instead of `z`, because `z` depends on shell integration and interactive session state.
- For destructive or high-impact work, resolve with `query -l` and verify the chosen directory explicitly.
- Run probe script first: `scripts/probe-zoxide.sh` to verify shell integration and database status

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
