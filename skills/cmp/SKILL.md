---
name: cmp-command
description: "Perform byte-level equality checks with `cmp`. Use when users ask whether files are identical, where first binary differences occur, or fixed-prefix comparisons."
---

# cmp Command Skill

## Purpose

Use `cmp` for fast binary or byte-accurate file comparisons with clear exit codes.

## Quick start

```bash

cmp --help

```

## Common workflows

1. Check whether two files are identical

```bash

cmp file_a.bin file_b.bin

```

Exit code `0` means identical; non-zero indicates differences.

1. Show differing byte positions

```bash

cmp -l file_a.bin file_b.bin | head

```

Byte-level output helps locate divergence quickly.

1. Compare only the first N bytes

```bash

cmp -n 4096 image1.bin image2.bin

```

Use bounded checks for header or prefix validation.

## Guardrails

- Interpret exit codes correctly: `0` equal, `1` different, `2` trouble accessing files.

- Use `-s` in scripts when only status matters and no text output is desired.

- Do not confuse byte offset output with higher-level structure boundaries.

## Reproducibility and reporting

- Record the exact command, flags, input paths, and working directory.

- Capture relevant environment details when they affect behavior (OS, tool version, locale, or shell).

- Summarize key output lines and explicitly note filters, truncation, or assumptions.
