---
name: readelf
description: Analyze ELF executable and shared object files. Use when the agent needs to inspect, analyze, or extract information from binary files or data structures.
---

# Readelf

Analyze ELF executable and shared object files

## Quick Start

1. Verify `readelf` is available: `readelf --version` or `man readelf`
2. Establish the command surface: `man readelf` or `readelf --help`
3. Start with a read-only probe: `readelf file`

## Intent Router

Load only the reference file needed for the active request.

- `references/install-and-setup.md` — Installing readelf on macOS, Linux, Windows
- `references/cheatsheet.md` — Common options, output formats, usage patterns
- `references/advanced-usage.md` — Advanced patterns, performance optimization
- `references/troubleshooting.md` — Common errors, exit codes, platform differences

## Core Workflow

1. Verify readelf is available: `readelf --version`
2. Start with safe, read-only operation: `readelf [options] file`
3. Validate output on test data before processing at scale
4. Document exact command and flags for reproducibility

## Quick Command Reference

```bash
readelf --version                       # Check version
readelf --help                          # Show help
readelf file                            # Basic usage
readelf file | head                     # Limit output
man readelf                             # Full manual
```

## Safety Notes

| Area | Guardrail |
| --- | --- |
| **Untrusted input** | Validate files from untrusted sources before processing. |
| **Large files** | May consume memory on large files. Test with smaller samples first. |
| **Output handling** | Pipe output safely. Binary output may corrupt terminal. |
| **Symlinks** | Tool may follow or skip symlinks. Check man page for behavior. |

## Source Policy

- Treat the installed `readelf` behavior and `man readelf` as runtime truth.
- Use upstream documentation for semantics.

## Resource Index

- `scripts/install.sh` — Install readelf on macOS or Linux.
- `scripts/install.ps1` — Install readelf on Windows or any platform via PowerShell.
