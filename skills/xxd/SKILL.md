---
name: xxd
description: Create and reverse hexadecimal dumps. Use when the agent needs to inspect, analyze, or extract information from binary files or data structures.
---

# Xxd

Create and reverse hexadecimal dumps

## Prerequisite Check

Run this before proposing forward or reverse hex workflows:

```bash
command -v xxd >/dev/null 2>&1 || xxd --version
```

If `xxd` is missing, surface that first and fall back to `od` for read-only inspection. Reverse conversion may need Vim or a machine that includes `xxd`.

## Quick Start

1. Verify `xxd` is available: `xxd --version` or `man xxd`
2. Establish the command surface: `man xxd` or `xxd --help`
3. Start with a read-only probe: `xxd file`

## Intent Router

Load only the reference file needed for the active request.

- `references/install-and-setup.md` — Installing xxd on macOS, Linux, Windows
- `references/cheatsheet.md` — Common options, output formats, usage patterns
- `references/advanced-usage.md` — Advanced patterns, performance optimization
- `references/troubleshooting.md` — Common errors, exit codes, platform differences

## Core Workflow

1. Verify xxd is available: `xxd --version`
2. Start with safe, read-only operation: `xxd [options] file`
3. Validate output on test data before processing at scale
4. Document exact command and flags for reproducibility

## Quick Command Reference

```bash
xxd --version                       # Check version
xxd --help                          # Show help
xxd file                            # Basic usage
xxd file | head                     # Limit output
man xxd                             # Full manual
```

```bash
# Read-only inspection with grouped bytes
xxd -g 1 firmware.bin | head

# Reverse a hex dump back into binary
xxd -r payload.hex restored.bin

# Read-only fallback on minimal systems
od -An -tx1 -v firmware.bin | head
```

## Safety Notes

| Area | Guardrail |
| --- | --- |
| **Untrusted input** | Validate files from untrusted sources before processing. |
| **Large files** | May consume memory on large files. Test with smaller samples first. |
| **Output handling** | Pipe output safely. Binary output may corrupt terminal. |
| **Symlinks** | Tool may follow or skip symlinks. Check man page for behavior. |

Recovery note: if `xxd` is unavailable, be explicit that `od` can replace forward inspection but not `xxd -r` round-trips.

## Source Policy

- Treat the installed `xxd` behavior and `man xxd` as runtime truth.
- Use upstream documentation for semantics.

## Resource Index

- `scripts/install.sh` — Install xxd on macOS or Linux.
- `scripts/install.ps1` — Install xxd on Windows or any platform via PowerShell.
