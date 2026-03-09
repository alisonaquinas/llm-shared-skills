---
name: tar-command
description: "Create and extract tar archives with explicit compression and paths. Use when users ask for packaging directories, inspecting tarballs, or controlled extraction."
---

# tar Command Skill

## Purpose

Use `tar` for reproducible archiving/extraction workflows with explicit compression and destination control.

## Quick start

```bash

tar --help

```

## Common workflows

1. Create a gzip-compressed archive

```bash

tar -czf release.tar.gz dist/

```

Explicit `-czf` makes compression and output target clear.

1. List archive contents without extracting

```bash

tar -tf release.tar.gz

```

Listing first helps validate structure and file names.

1. Extract into a dedicated directory

```bash

mkdir -p unpack && tar -xzf release.tar.gz -C unpack

```

Destination control avoids polluting current working directories.

## Guardrails

- Inspect contents before extraction to catch suspicious absolute/parent paths.

- Use `-C` to extract into controlled directories.

- Document compression flags (`-z`, `-j`, `-J`) so archives are reproducible.

## Reproducibility and reporting

- Record the exact command, flags, input paths, and working directory.

- Capture relevant environment details when they affect behavior (OS, tool version, locale, or shell).

- Summarize key output lines and explicitly note filters, truncation, or assumptions.
