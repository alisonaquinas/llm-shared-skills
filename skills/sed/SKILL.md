---
name: sed-command
description: "Transform text streams with `sed` using explicit scripts and backups. Use when users ask for line filtering, in-place substitutions, or repeatable stream edits."
---

# sed Command Skill

## Purpose

Use `sed` for deterministic line-oriented substitutions, filtering, and simple text rewrites.

## Quick start

```bash

sed --help

```

## Common workflows

1. Print only specific line ranges

```bash

sed -n '50,80p' app.log

```

Use `-n` with explicit print commands to avoid accidental full output.

1. Apply global substitution in a stream

```bash

sed 's/old_value/new_value/g' config.txt

```

Keep replacement scripts quoted so the shell does not alter them.

1. Edit files in place with backup

```bash

sed -i.bak 's/http:/https:/g' settings.conf

```

Backup suffixes provide an immediate rollback path.

## Guardrails

- Prefer `-i.bak` over bare `-i` when editing files to keep rollback artifacts.

- Confirm GNU vs BSD `sed` differences before sharing cross-platform commands.

- Validate complex scripts on sample input before touching production files.

## Reproducibility and reporting

- Record the exact command, flags, input paths, and working directory.

- Capture relevant environment details when they affect behavior (OS, tool version, locale, or shell).

- Summarize key output lines and explicitly note filters, truncation, or assumptions.
