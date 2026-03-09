---
name: tree
description: Display directory structure in tree format. Use when the agent needs to search, filter, or transform data efficiently.
---

# Tree

Display directory structure in tree format

## Quick Start

1. Verify `tree` is available: `tree --version` or `man tree`
2. Establish the command surface: `man tree` or `tree --help`
3. Start with basic usage: `tree [options] [input]`

## Intent Router

- `references/install-and-setup.md` — Installing tree
- `references/cheatsheet.md` — Common options and patterns
- `references/advanced-usage.md` — Advanced techniques
- `references/troubleshooting.md` — Common errors and solutions

## Core Workflow

1. Verify tree is available: `tree --version`
2. Test with sample data first
3. Validate output before batch processing
4. Document exact commands for reproducibility

## Quick Command Reference

```bash
tree --version                       # Check version
tree --help                          # Show help
tree [options] [input]               # Basic usage
man tree                             # Full manual
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
