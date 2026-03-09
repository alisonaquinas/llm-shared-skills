---
name: xxd-command
description: "Create and reverse hex dumps with `xxd`. Use when users ask for byte-level inspection, patch-style hex editing, or converting binary to/from plain hex."
---

# xxd Command Skill

## Purpose

Use `xxd` for readable hex views and reversible binary-to-hex transformations.

## Quick start

```bash

xxd -h

```

## Common workflows

1. Generate a canonical hex dump

```bash

xxd sample.bin | head -n 40

```

Hex + ASCII columns are useful for quick visual inspection.

1. Dump only a bounded byte range

```bash

xxd -s 0x200 -l 128 firmware.bin

```

Offset/length controls keep reviews focused.

1. Rebuild binary from hex dump

```bash

xxd -r patch.hex > restored.bin

```

Reverse mode supports deterministic binary reconstruction.

## Guardrails

- When using `-r`, ensure offsets and formatting are valid or reconstruction will fail.

- Prefer bounded dumps (`-l`, `-s`) on large binaries to avoid massive output.

- Do not edit hex manually without preserving byte count and alignment expectations.

## Reproducibility and reporting

- Record the exact command, flags, input paths, and working directory.

- Capture relevant environment details when they affect behavior (OS, tool version, locale, or shell).

- Summarize key output lines and explicitly note filters, truncation, or assumptions.
