---
name: file-command
description: "Identify file formats with `file` and MIME signatures. Use when users ask to classify unknown files, verify content type, or detect binary-vs-text inputs safely."
---

# file Command Skill

## Purpose

Use `file` to classify unknown files quickly before selecting downstream tooling.

## Quick start

```bash

file --help

```

## Common workflows

1. Classify a single file

```bash

file sample.bin

```

Start here before parsing unknown content.

1. Get MIME type for automation

```bash

file --mime-type upload.dat

```

MIME output is easier to branch on in scripts.

1. Scan many files in a directory

```bash

find artifacts -type f -maxdepth 1 -print0 | xargs -0 file

```

Batch classification highlights unexpected formats.

## Guardrails

- Treat `file` results as heuristic signatures, not cryptographic guarantees.

- Use `-L` intentionally when symlink dereferencing behavior matters.

- Run `file` before opening unknown data in interactive pagers or editors.

## Reproducibility and reporting

- Record the exact command, flags, input paths, and working directory.

- Capture relevant environment details when they affect behavior (OS, tool version, locale, or shell).

- Summarize key output lines and explicitly note filters, truncation, or assumptions.
