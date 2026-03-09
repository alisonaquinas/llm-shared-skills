---
name: less-command
description: "Navigate large text output with `less` using reproducible flags for search, paging, and follow mode. Use when users ask for pager workflows, interactive log review, or `less` key behavior."
---

# less Command Skill

## Purpose

Use `less` to inspect large text outputs interactively with precise navigation, search, and follow mode.

## Quick start

```bash

less --help

```

## Common workflows

1. Open a large log with line numbers and no wrapping

```bash

less -N -S app.log

```

This keeps long lines intact and makes line references reproducible.

1. Follow a growing log stream

```bash

less +F /var/log/system.log

```

Press `Ctrl+C` to pause and inspect, then `F` to resume follow mode.

1. Page colored diff output from a pipeline

```bash

git diff --color=always | less -R

```

Use `-R` so ANSI color escapes render correctly.

## Guardrails

- Use `file <path>` before opening unknown files to avoid binary noise in the pager.

- Avoid `less` in non-interactive scripts; use tools like `head`, `tail`, `sed`, or `awk` instead.

- Capture whether flags like `-N`, `-S`, or `-R` were used so navigation behavior is reproducible.

## Reproducibility and reporting

- Record the exact command, flags, input paths, and working directory.

- Capture relevant environment details when they affect behavior (OS, tool version, locale, or shell).

- Summarize key output lines and explicitly note filters, truncation, or assumptions.
