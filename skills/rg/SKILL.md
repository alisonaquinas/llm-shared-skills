---
name: rg-command
description: "Search text and code with `rg` for speed and precise filters. Use when users ask for ripgrep syntax, scoped recursive matching, or machine-parsable search output."
---

# rg Command Skill

## Purpose

Use `rg` for high-performance recursive search with strong filtering and output control.

## Quick start

```bash

rg --help

```

## Common workflows

1. Search for API key usage with line numbers

```bash

rg -n 'API_KEY' src

```

Default recursive behavior is fast and ignore-aware.

1. Restrict search to selected file globs

```bash

rg -n --glob '*.ts' --glob '*.tsx' 'useEffect' src

```

Use explicit globs to reduce false positives.

1. Emit JSON lines for tool-driven processing

```bash

rg --json 'ERROR' logs

```

JSON output is reliable for downstream automation.

## Guardrails

- Use `--hidden` and `--no-ignore` only when you intentionally need ignored content.

- Prefer fixed strings (`-F`) when regex is unnecessary to avoid pattern mistakes.

- Constrain search scope to avoid scanning vendor/build artifacts.

## Reproducibility and reporting

- Record the exact command, flags, input paths, and working directory.

- Capture relevant environment details when they affect behavior (OS, tool version, locale, or shell).

- Summarize key output lines and explicitly note filters, truncation, or assumptions.
