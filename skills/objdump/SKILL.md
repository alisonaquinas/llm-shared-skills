---
name: objdump
description: Display and disassemble object file information. Use when the agent needs to inspect, analyze, or extract information from binary files or data structures.
---

# Objdump

Display and disassemble object file information

## Quick Start

1. Verify `objdump` is available: `objdump --version` or `man objdump`
2. Establish the command surface: `man objdump` or `objdump --help`
3. Start with a read-only probe: `objdump file`

## Intent Router

Load only the reference file needed for the active request.

- `references/install-and-setup.md` — Installing objdump on macOS, Linux, Windows
- `references/cheatsheet.md` — Common options, output formats, usage patterns
- `references/advanced-usage.md` — Advanced patterns, performance optimization
- `references/troubleshooting.md` — Common errors, exit codes, platform differences

## Core Workflow

1. Verify objdump is available: `objdump --version`
2. Start with safe, read-only operation: `objdump [options] file`
3. Validate output on test data before processing at scale
4. Document exact command and flags for reproducibility

## Quick Command Reference

```bash
objdump --version                       # Check version
objdump --help                          # Show help
objdump file                            # Basic usage
objdump file | head                     # Limit output
man objdump                             # Full manual
```

## Safety Notes

| Area | Guardrail |
| --- | --- |
| **Untrusted input** | Validate files from untrusted sources before processing. |
| **Large files** | May consume memory on large files. Test with smaller samples first. |
| **Output handling** | Pipe output safely. Binary output may corrupt terminal. |
| **Symlinks** | Tool may follow or skip symlinks. Check man page for behavior. |

## Source Policy

- Treat the installed `objdump` behavior and `man objdump` as runtime truth.
- Use upstream documentation for semantics.

## Resource Index

- `scripts/install.sh` — Install objdump on macOS or Linux.
- `scripts/install.ps1` — Install objdump on Windows or any platform via PowerShell.
