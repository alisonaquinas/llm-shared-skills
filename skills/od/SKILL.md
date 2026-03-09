---
name: od
description: Dump files in octal, hex, or ASCII formats. Use when the agent needs to inspect, analyze, or extract information from binary files or data structures.
---

# Od

Dump files in octal, hex, or ASCII formats

## Quick Start

1. Verify `od` is available: `od --version` or `man od`
2. Establish the command surface: `man od` or `od --help`
3. Start with a read-only probe: `od file`

## Intent Router

Load only the reference file needed for the active request.

- `references/install-and-setup.md` — Installing od on macOS, Linux, Windows
- `references/cheatsheet.md` — Common options, output formats, usage patterns
- `references/advanced-usage.md` — Advanced patterns, performance optimization
- `references/troubleshooting.md` — Common errors, exit codes, platform differences

## Core Workflow

1. Verify od is available: `od --version`
2. Start with safe, read-only operation: `od [options] file`
3. Validate output on test data before processing at scale
4. Document exact command and flags for reproducibility

## Quick Command Reference

```bash
od --version                       # Check version
od --help                          # Show help
od file                            # Basic usage
od file | head                     # Limit output
man od                             # Full manual
```

## Safety Notes

| Area | Guardrail |
| --- | --- |
| **Untrusted input** | Validate files from untrusted sources before processing. |
| **Large files** | May consume memory on large files. Test with smaller samples first. |
| **Output handling** | Pipe output safely. Binary output may corrupt terminal. |
| **Symlinks** | Tool may follow or skip symlinks. Check man page for behavior. |

## Source Policy

- Treat the installed `od` behavior and `man od` as runtime truth.
- Use upstream documentation for semantics.

## Resource Index

- `scripts/install.sh` — Install od on macOS or Linux.
- `scripts/install.ps1` — Install od on Windows or any platform via PowerShell.
