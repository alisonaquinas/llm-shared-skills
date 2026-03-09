---
name: markdownlint-cli2-enforcer
description: >
  Run markdownlint-cli2 to lint and fix Markdown files using project-specific rules.
  Use when enforcing Markdown linting rules, applying fixes to documentation, validating
  README/AGENTS/docs formatting, checking configuration file compliance, understanding
  Markdown lint violations, disabling specific rules, or running quality checks against
  curvecapture/markdownlint-cli2.jsonc or local `.markdownlint-cli2.jsonc` config files.
---

# Markdownlint CLI2 Enforcer

## Intent Router

| Request | Reference | Load When |
|---|---|---|
| Install tool, first-time setup | `references/install-and-setup.md` | User needs to install markdownlint-cli2 or do initial configuration |
| Rule reference, config format | `references/rules-and-config.md` | User asks about specific rules, how to disable/configure rules, or understand violations |
| Quick command patterns | (Inline below) | Standard lint/fix workflows |

## Overview

Use `markdownlint-cli2` to check and fix Markdown consistently. Prefer the provided Curvecapture config file when present, then fall back to local repo config files.

## Workflow

1. Resolve config file.
- Prefer explicit user-provided config path.
- Else prefer `curvecapture/markdownlint-cli2.jsonc`.
- Else use local `markdownlint-cli2.jsonc` or `.markdownlint-cli2.jsonc` if present.

2. Resolve target scope.
- Use user-provided file paths or globs when given.
- If scope is not provided, lint `**/*.md` and `**/*.markdown` from current working directory.
- Avoid linting generated output and dependency trees unless explicitly requested.

3. Run lint check first.
- Run without `--fix` to capture violations.
- Report failing rules and affected files before making edits.

4. Apply fixes as needed.
- Run with `--fix` only when user asks for fixes or when task requires enforcing rules.
- Re-run lint check to ensure a clean result.

5. Summarize clearly.
- Report config used, targets checked, whether fixes were applied, and final lint status.

## Commands

Use the bundled script for deterministic execution:

```bash
./skills/markdownlint-cli2-enforcer/scripts/run-markdownlint-cli2.sh --config ./curvecapture/markdownlint-cli2.jsonc README.md AGENTS.md
```

Run with automatic config detection:

```bash
./skills/markdownlint-cli2-enforcer/scripts/run-markdownlint-cli2.sh README.md
```

Run and auto-fix:

```bash
./skills/markdownlint-cli2-enforcer/scripts/run-markdownlint-cli2.sh --fix README.md AGENTS.md
```

## Safety and Guardrails

| Action | Guardrail | Why |
|---|---|---|
| **Lint check** | Always run without `--fix` first | Verify violations before modifying files |
| **Report violations** | List failed rules and affected files before auto-fixing | Operator visibility; manual review of what changed |
| **Apply fixes** | Only when user explicitly requests `--fix` or task requires it | Prevent unintended modifications |
| **Verify after fix** | Re-run lint check to ensure clean result | Confirm fixes were effective |

## Resources

### scripts/run-markdownlint-cli2.sh

Use this wrapper to:
- auto-select config file
- run `markdownlint-cli2` directly if installed
- fall back to `markdownlint` (with mapped disabled rules) when available
- else fall back to `npx --yes markdownlint-cli2` when binary is missing
- apply optional `--fix`
