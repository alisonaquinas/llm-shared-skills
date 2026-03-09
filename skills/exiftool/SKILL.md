---
name: exiftool
description: Extract and edit metadata from files. Use when the agent needs to extract, analyze, or transform document and file metadata.
---

# Exiftool

Extract and edit metadata from files

## Quick Start

1. Verify `exiftool` is available: `exiftool --version` or `man exiftool`
2. Establish the command surface: `man exiftool` or `exiftool --help`
3. Start with a read-only probe: `exiftool file`

## Intent Router

- `references/install-and-setup.md` — Installing exiftool
- `references/cheatsheet.md` — Common options and patterns
- `references/advanced-usage.md` — Advanced techniques
- `references/troubleshooting.md` — Common errors and solutions

## Core Workflow

1. Verify exiftool is available: `exiftool --version`
2. Inspect file: `exiftool file`
3. Validate output before batch processing
4. Document exact commands for reproducibility

## Quick Command Reference

```bash
exiftool --version                       # Check version
exiftool --help                          # Show help
exiftool file                            # Basic usage
man exiftool                             # Full manual
```

## Safety Notes

| Area | Guardrail |
| --- | --- |
| **File validation** | Verify files are in expected format. |
| **Output handling** | Validate output before processing further. |
| **Large files** | Test with smaller files first. |

## Source Policy

- Treat installed behavior and man page as truth.

## Resource Index

- `scripts/install.sh` — Install on macOS or Linux.
- `scripts/install.ps1` — Install on Windows or any platform.
