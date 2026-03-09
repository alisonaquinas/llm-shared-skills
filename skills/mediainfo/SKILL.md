---
name: mediainfo
description: Display comprehensive media file information. Use when the agent needs to extract, analyze, or transform document and file metadata.
---

# Mediainfo

Display comprehensive media file information

## Quick Start

1. Verify `mediainfo` is available: `mediainfo --version` or `man mediainfo`
2. Establish the command surface: `man mediainfo` or `mediainfo --help`
3. Start with a read-only probe: `mediainfo file`

## Intent Router

- `references/install-and-setup.md` — Installing mediainfo
- `references/cheatsheet.md` — Common options and patterns
- `references/advanced-usage.md` — Advanced techniques
- `references/troubleshooting.md` — Common errors and solutions

## Core Workflow

1. Verify mediainfo is available: `mediainfo --version`
2. Inspect file: `mediainfo file`
3. Validate output before batch processing
4. Document exact commands for reproducibility

## Quick Command Reference

```bash
mediainfo --version                       # Check version
mediainfo --help                          # Show help
mediainfo file                            # Basic usage
man mediainfo                             # Full manual
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
