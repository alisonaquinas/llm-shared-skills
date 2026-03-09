---
name: hexdump-command
description: "Inspect raw bytes with `hexdump` format controls. Use when users ask for canonical hex views, custom byte formatting, or offset-limited binary inspection."
---

# hexdump Command Skill

## Purpose

Use `hexdump` for low-level byte inspection and custom output formatting.

## Quick start

```bash

hexdump --help

```

## Common workflows

1. Display canonical hex + ASCII view

```bash

hexdump -C sample.bin | head -n 40

```

Canonical output is easy to correlate with offsets.

1. Inspect a bounded slice by offset

```bash

hexdump -C -s 1024 -n 256 sample.bin

```

Offset and length limits prevent oversized output.

1. Emit compact hex stream

```bash

hexdump -v -e '1/1 "%02x"' sample.bin

```

Custom format expressions support script-friendly output.

## Guardrails

- Prefer `-C` for human review unless a custom format is explicitly required.

- Be careful with format strings (`-e`); validate on small samples first.

- Document offset and length bounds when reporting observations.

## Reproducibility and reporting

- Record the exact command, flags, input paths, and working directory.

- Capture relevant environment details when they affect behavior (OS, tool version, locale, or shell).

- Summarize key output lines and explicitly note filters, truncation, or assumptions.
