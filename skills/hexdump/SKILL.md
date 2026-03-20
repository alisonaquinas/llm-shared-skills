---
name: hexdump
description: Display file contents in hexadecimal and ASCII formats. Use when the agent needs to inspect, analyze, or extract information from binary files or data structures.
---

# Hexdump

Display file contents in hexadecimal and ASCII formats

## Prerequisite Check

Run this before proposing byte-level inspection:

```bash
command -v hexdump >/dev/null 2>&1 || hexdump --version
```

If `hexdump` is missing, surface that immediately and fall back to `xxd` or `od` for equivalent read-only inspection.

## Quick Start

1. Verify `hexdump` is available: `hexdump --version` or `man hexdump`
2. Establish the command surface: `man hexdump` or `hexdump --help`
3. Start with a read-only probe: `hexdump file`

## Intent Router

Load only the reference file needed for the active request.

- `references/install-and-setup.md` — Installing hexdump on macOS, Linux, Windows
- `references/cheatsheet.md` — Common options, output formats, usage patterns
- `references/advanced-usage.md` — Advanced patterns, performance optimization
- `references/troubleshooting.md` — Common errors, exit codes, platform differences

## Core Workflow

1. Verify hexdump is available: `hexdump --version`
2. Start with safe, read-only operation: `hexdump [options] file`
3. Validate output on test data before processing at scale
4. Document exact command and flags for reproducibility

## Quick Command Reference

```bash
hexdump --version                       # Check version
hexdump --help                          # Show help
hexdump file                            # Basic usage
hexdump file | head                     # Limit output
man hexdump                             # Full manual
```

```bash
# Canonical hex + ASCII view
hexdump -C firmware.bin | head

# Fallbacks on minimal systems
xxd -g 1 firmware.bin | head
od -An -tx1 -v firmware.bin | head
```

## Safety Notes

| Area | Guardrail |
| --- | --- |
| **Untrusted input** | Validate files from untrusted sources before processing. |
| **Large files** | May consume memory on large files. Test with smaller samples first. |
| **Output handling** | Pipe output safely. Binary output may corrupt terminal. |
| **Symlinks** | Tool may follow or skip symlinks. Check man page for behavior. |

Recovery note: if `hexdump` is absent, prefer `xxd` for side-by-side hex plus ASCII and `od -tx1` when only POSIX core tools are available.

## Source Policy

- Treat the installed `hexdump` behavior and `man hexdump` as runtime truth.
- Use upstream documentation for semantics.

## Resource Index

- `scripts/install.sh` — Install hexdump on macOS or Linux.
- `scripts/install.ps1` — Install hexdump on Windows or any platform via PowerShell.
