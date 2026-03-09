---
name: nm
description: List symbols from object files and libraries. Use when the agent needs to inspect, analyze, or extract information from binary files or data structures.
---

# Nm

List symbols from object files and libraries

## Quick Start

1. Verify `nm` is available: `nm --version` or `man nm`
2. Establish the command surface: `man nm` or `nm --help`
3. Start with a read-only probe: `nm file`

## Intent Router

Load only the reference file needed for the active request.

- `references/install-and-setup.md` — Installing nm on macOS, Linux, Windows
- `references/cheatsheet.md` — Common options, output formats, usage patterns
- `references/advanced-usage.md` — Advanced patterns, performance optimization
- `references/troubleshooting.md` — Common errors, exit codes, platform differences

## Core Workflow

1. Verify nm is available: `nm --version`
2. Start with safe, read-only operation: `nm [options] file`
3. Validate output on test data before processing at scale
4. Document exact command and flags for reproducibility

## Quick Command Reference

```bash
nm --version                       # Check version
nm --help                          # Show help
nm file                            # Basic usage
nm file | head                     # Limit output
man nm                             # Full manual
```

## Safety Notes

| Area | Guardrail |
| --- | --- |
| **Untrusted input** | Validate files from untrusted sources before processing. |
| **Large files** | May consume memory on large files. Test with smaller samples first. |
| **Output handling** | Pipe output safely. Binary output may corrupt terminal. |
| **Symlinks** | Tool may follow or skip symlinks. Check man page for behavior. |

## Source Policy

- Treat the installed `nm` behavior and `man nm` as runtime truth.
- Use upstream documentation for semantics.

## Resource Index

- `scripts/install.sh` — Install nm on macOS or Linux.
- `scripts/install.ps1` — Install nm on Windows or any platform via PowerShell.
