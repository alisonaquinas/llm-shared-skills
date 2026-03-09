---
name: strings
description: Extract readable text strings from binary files. Use when the agent needs to inspect, analyze, or extract information from binary files or data structures.
---

# Strings

Extract readable text strings from binary files

## Quick Start

1. Verify `strings` is available: `strings --version` or `man strings`
2. Establish the command surface: `man strings` or `strings --help`
3. Start with a read-only probe: `strings file`

## Intent Router

Load only the reference file needed for the active request.

- `references/install-and-setup.md` — Installing strings on macOS, Linux, Windows
- `references/cheatsheet.md` — Common options, output formats, usage patterns
- `references/advanced-usage.md` — Advanced patterns, performance optimization
- `references/troubleshooting.md` — Common errors, exit codes, platform differences

## Core Workflow

1. Verify strings is available: `strings --version`
2. Start with safe, read-only operation: `strings [options] file`
3. Validate output on test data before processing at scale
4. Document exact command and flags for reproducibility

## Quick Command Reference

```bash
strings --version                       # Check version
strings --help                          # Show help
strings file                            # Basic usage
strings file | head                     # Limit output
man strings                             # Full manual
```

## Safety Notes

| Area | Guardrail |
| --- | --- |
| **Untrusted input** | Validate files from untrusted sources before processing. |
| **Large files** | May consume memory on large files. Test with smaller samples first. |
| **Output handling** | Pipe output safely. Binary output may corrupt terminal. |
| **Symlinks** | Tool may follow or skip symlinks. Check man page for behavior. |

## Source Policy

- Treat the installed `strings` behavior and `man strings` as runtime truth.
- Use upstream documentation for semantics.

## Resource Index

- `scripts/install.sh` — Install strings on macOS or Linux.
- `scripts/install.ps1` — Install strings on Windows or any platform via PowerShell.
