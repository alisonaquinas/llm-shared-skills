---
name: pdfinfo
description: Extract metadata from PDF files. Use when the agent needs to extract, analyze, or transform document and file metadata.
---

# Pdfinfo

Extract metadata from PDF files

## Quick Start

1. Verify `pdfinfo` is available: `pdfinfo --version` or `man pdfinfo`
2. Establish the command surface: `man pdfinfo` or `pdfinfo --help`
3. Start with a read-only probe: `pdfinfo file`

## Intent Router

- `references/install-and-setup.md` — Installing pdfinfo
- `references/cheatsheet.md` — Common options and patterns
- `references/advanced-usage.md` — Advanced techniques
- `references/troubleshooting.md` — Common errors and solutions

## Core Workflow

1. Verify pdfinfo is available: `pdfinfo --version`
2. Inspect file: `pdfinfo file`
3. Validate output before batch processing
4. Document exact commands for reproducibility

## Quick Command Reference

```bash
pdfinfo --version                       # Check version
pdfinfo --help                          # Show help
pdfinfo file                            # Basic usage
man pdfinfo                             # Full manual
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
