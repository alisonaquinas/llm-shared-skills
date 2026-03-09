---
name: 7z-command
description: "Work with 7z and multi-format archives using `7z`. Use when users ask for high-compression archives, encrypted archive handling, or cross-format extraction workflows."
---

# 7z Command Skill

## Purpose

Use `7z` for high-compression archiving, listing, and extraction across multiple archive formats.

## Quick start

```bash

7z --help

```

## Common workflows

1. List archive details

```bash

7z l bundle.7z

```

Listing validates file set and compression/encryption metadata.

1. Extract with full directory structure

```bash

7z x bundle.7z -oout

```

Use `x` to preserve paths and set output directory explicitly.

1. Create a compressed archive

```bash

7z a release.7z dist/

```

Archive creation is deterministic when source paths are controlled.

## Guardrails

- Use `x` (not `e`) when directory hierarchy must be preserved.

- Avoid passing plaintext passwords directly on shared terminals.

- Verify destination path (`-o`) before extraction to prevent clutter or overwrite.

## Reproducibility and reporting

- Record the exact command, flags, input paths, and working directory.

- Capture relevant environment details when they affect behavior (OS, tool version, locale, or shell).

- Summarize key output lines and explicitly note filters, truncation, or assumptions.
