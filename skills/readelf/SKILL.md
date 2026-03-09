---
name: readelf-command
description: "Inspect ELF metadata safely with `readelf`. Use when users ask for headers, sections, symbols, relocations, or dynamic information in Linux binaries."
---

# readelf Command Skill

## Purpose

Use `readelf` to extract ELF structure details without executing binaries.

## Quick start

```bash

readelf --help

```

## Common workflows

1. Inspect ELF header and architecture

```bash

readelf -h ./app

```

Start with headers to confirm class, machine, and endianness.

1. List program and section headers

```bash

readelf -l -S ./app

```

These views show memory layout and named sections.

1. Review symbol and dynamic dependency data

```bash

readelf -Ws -d ./app

```

Symbols and dynamic tags help troubleshoot linkage issues.

## Guardrails

- Use `readelf` over executing unknown binaries when triaging untrusted artifacts.

- Match architecture assumptions before interpreting addresses and flags.

- Keep command output scoped to needed sections to avoid overwhelming logs.

## Reproducibility and reporting

- Record the exact command, flags, input paths, and working directory.

- Capture relevant environment details when they affect behavior (OS, tool version, locale, or shell).

- Summarize key output lines and explicitly note filters, truncation, or assumptions.
