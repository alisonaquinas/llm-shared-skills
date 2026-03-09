---
name: od-command
description: "Dump data in octal, decimal, or hex formats with `od`. Use when users ask for numeric byte views, typed-word inspection, or offset-based binary checks."
---

# od Command Skill

## Purpose

Use `od` for typed numeric views of bytes, words, and characters at explicit offsets.

## Quick start

```bash

od --help

```

## Common workflows

1. Show byte values in hex with offsets

```bash

od -Ax -tx1 -v sample.bin | head -n 30

```

Hex byte mode is useful for protocol and header checks.

1. Interpret data as 32-bit decimals

```bash

od -An -td4 -N 64 sample.bin

```

Typed output helps validate integer fields quickly.

1. Inspect printable characters

```bash

od -An -tc -N 128 sample.bin

```

Character mode highlights plain-text fragments.

## Guardrails

- Set format types (`-t`) explicitly to avoid ambiguous interpretation.

- Use bounded reads (`-N`, `-j`) when inspecting large files.

- Document byte order assumptions when interpreting multi-byte words.

## Reproducibility and reporting

- Record the exact command, flags, input paths, and working directory.

- Capture relevant environment details when they affect behavior (OS, tool version, locale, or shell).

- Summarize key output lines and explicitly note filters, truncation, or assumptions.
