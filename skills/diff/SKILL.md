---
name: diff-command
description: "Compare files and directories with `diff` for patch-ready output. Use when users ask for textual differences, recursive comparisons, or whitespace-tolerant review."
---

# diff Command Skill

## Purpose

Use `diff` to produce precise textual differences between files or directory trees.

## Quick start

```bash

diff --help

```

## Common workflows

1. Compare two files with unified format

```bash

diff -u before.txt after.txt

```

Unified output is the standard for review and patch creation.

1. Compare directories recursively

```bash

diff -ru old_dir new_dir

```

Recursive mode highlights added, removed, and changed files.

1. Ignore whitespace-only churn

```bash

diff -u -w old.txt new.txt

```

Useful for detecting substantive changes in reformatted content.

## Guardrails

- Use unified diffs (`-u`) for human review and tool compatibility.

- Avoid binary comparisons with `diff`; use `cmp`, `xxd`, or hash tools instead.

- State whether whitespace-ignore flags were used to prevent misinterpretation.

## Reproducibility and reporting

- Record the exact command, flags, input paths, and working directory.

- Capture relevant environment details when they affect behavior (OS, tool version, locale, or shell).

- Summarize key output lines and explicitly note filters, truncation, or assumptions.
