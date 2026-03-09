---
name: unzip-command
description: "Inspect and extract ZIP archives with `unzip`. Use when users ask for zip listing, selective extraction, overwrite controls, or archive integrity tests."
---

# unzip Command Skill

## Purpose

Use `unzip` to list, test, and extract ZIP archives with explicit destination behavior.

## Quick start

```bash

unzip -h

```

## Common workflows

1. List archive contents before extraction

```bash

unzip -l package.zip

```

Listing first catches unexpected paths or file counts.

1. Extract into a target directory

```bash

unzip package.zip -d extracted/

```

Always set destination to keep workspace layout predictable.

1. Test archive integrity without extracting

```bash

unzip -t package.zip

```

Integrity checks can fail fast before write operations.

## Guardrails

- Choose overwrite policy explicitly (`-o` overwrite, `-n` never overwrite).

- Inspect names for path traversal patterns before extraction.

- Avoid exposing passwords via shell history when handling encrypted zips.

## Reproducibility and reporting

- Record the exact command, flags, input paths, and working directory.

- Capture relevant environment details when they affect behavior (OS, tool version, locale, or shell).

- Summarize key output lines and explicitly note filters, truncation, or assumptions.
