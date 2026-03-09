---
name: pdftotext
description: Convert PDF documents to plain text. Use when the agent needs to extract, analyze, or transform document and file metadata.
---

# Pdftotext

Convert PDF documents to plain text

## Quick Start

1. Verify `pdftotext` is available: `pdftotext --version` or `man pdftotext`
2. Establish the command surface: `man pdftotext` or `pdftotext --help`
3. Start with a read-only probe: `pdftotext file`

## Intent Router

- `references/install-and-setup.md` — Installing pdftotext
- `references/cheatsheet.md` — Common options and patterns
- `references/advanced-usage.md` — Advanced techniques
- `references/troubleshooting.md` — Common errors and solutions

## Core Workflow

1. Verify pdftotext is available: `pdftotext --version`
2. Inspect file: `pdftotext file`
3. Validate output before batch processing
4. Document exact commands for reproducibility

## Quick Command Reference

```bash
pdftotext --version                       # Check version
pdftotext --help                          # Show help
pdftotext file                            # Basic usage
man pdftotext                             # Full manual
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
