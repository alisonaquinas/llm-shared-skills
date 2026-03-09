---
name: xmllint
description: Validate and format XML documents. Use when the agent needs to extract, analyze, or transform document and file metadata.
---

# Xmllint

Validate and format XML documents

## Quick Start

1. Verify `xmllint` is available: `xmllint --version` or `man xmllint`
2. Establish the command surface: `man xmllint` or `xmllint --help`
3. Start with a read-only probe: `xmllint file`

## Intent Router

- `references/install-and-setup.md` — Installing xmllint
- `references/cheatsheet.md` — Common options and patterns
- `references/advanced-usage.md` — Advanced techniques
- `references/troubleshooting.md` — Common errors and solutions

## Core Workflow

1. Verify xmllint is available: `xmllint --version`
2. Inspect file: `xmllint file`
3. Validate output before batch processing
4. Document exact commands for reproducibility

## Quick Command Reference

```bash
xmllint --version                       # Check version
xmllint --help                          # Show help
xmllint file                            # Basic usage
man xmllint                             # Full manual
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
