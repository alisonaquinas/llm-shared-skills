---
name: ldd
description: List dynamic library dependencies of binaries. Use when the agent needs to search, filter, or transform data efficiently.
---

# Ldd

List dynamic library dependencies of binaries

## Quick Start

1. Verify `ldd` is available: `ldd --version` or `man ldd`
2. Establish the command surface: `man ldd` or `ldd --help`
3. Start with basic usage: `ldd [options] [input]`

## Intent Router

- `references/install-and-setup.md` — Installing ldd
- `references/cheatsheet.md` — Common options and patterns
- `references/advanced-usage.md` — Advanced techniques
- `references/troubleshooting.md` — Common errors and solutions

## Core Workflow

1. Verify ldd is available: `ldd --version`
2. Test with sample data first
3. Validate output before batch processing
4. Document exact commands for reproducibility

## Quick Command Reference

```bash
ldd --version                       # Check version
ldd --help                          # Show help
ldd [options] [input]               # Basic usage
man ldd                             # Full manual
```

## Safety Notes

| Area | Guardrail |
| --- | --- |
| **Input validation** | Verify input data format before processing. |
| **Output handling** | Validate output structure. |
| **Large files** | Test with smaller samples first. |

## Source Policy

- Treat installed behavior and man page as truth.

## Resource Index

- `scripts/install.sh` — Install on macOS or Linux.
- `scripts/install.ps1` — Install on Windows or any platform.
