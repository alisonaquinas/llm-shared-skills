---
name: xxd
description: Create and reverse hexadecimal dumps. Use when the agent needs to inspect, analyze, or extract information from binary files or data structures.
---

# Xxd

Create and reverse hexadecimal dumps

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

## Safety Notes

| Area | Guardrail |
| --- | --- |
| **Untrusted input** | Validate files from untrusted sources before processing. |
| **Large files** | May consume memory on large files. Test with smaller samples first. |
| **Output handling** | Pipe output safely. Binary output may corrupt terminal. |
| **Symlinks** | Tool may follow or skip symlinks. Check man page for behavior. |

## Source Policy

- Treat the installed `xxd` behavior and `man xxd` as runtime truth.
- Use upstream documentation for semantics.

## Resource Index

- `scripts/install.sh` — Install xxd on macOS or Linux.
- `scripts/install.ps1` — Install xxd on Windows or any platform via PowerShell.
