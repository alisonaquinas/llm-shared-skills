---
name: binwalk-command
description: "Scan firmware binaries with `binwalk` for embedded signatures. Use when users ask for firmware carving, embedded filesystem detection, or binary entropy review."
---

# binwalk Command Skill

## Purpose

Use `binwalk` to locate embedded file signatures and extraction opportunities in firmware images.

## Quick start

```bash

binwalk --help

```

## Common workflows

1. Identify embedded signatures in firmware

```bash

binwalk firmware.bin

```

Signature scan provides offsets and candidate embedded objects.

1. Extract recognized embedded content

```bash

binwalk -e firmware.bin

```

Extraction creates output directories with carved artifacts.

1. Review entropy profile for packed regions

```bash

binwalk -E firmware.bin

```

Entropy peaks can indicate compression or encryption boundaries.

## Guardrails

- Perform extraction in controlled directories because `-e` writes many files.

- Treat signature hits as hints; validate extracted artifacts independently.

- Do not run extraction on untrusted samples without containment controls.

## Reproducibility and reporting

- Record the exact command, flags, input paths, and working directory.

- Capture relevant environment details when they affect behavior (OS, tool version, locale, or shell).

- Summarize key output lines and explicitly note filters, truncation, or assumptions.
