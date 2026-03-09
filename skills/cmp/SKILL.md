---
name: cmp
description: Byte-level file comparison with position reporting. Use when the agent needs to inspect, analyze, or extract information from binary files or data structures.
---

# Cmp

Byte-level file comparison with position reporting

## Quick Start

1. Verify `cmp` is available: `cmp --version` or `man cmp`
2. Establish the command surface: `man cmp` or `cmp --help`
3. Start with a read-only probe: `cmp file`

## Intent Router

Load only the reference file needed for the active request.

- `references/install-and-setup.md` — Installing cmp on macOS, Linux, Windows
- `references/cheatsheet.md` — Common options, output formats, usage patterns
- `references/advanced-usage.md` — Advanced patterns, performance optimization
- `references/troubleshooting.md` — Common errors, exit codes, platform differences

## Core Workflow

1. Verify cmp is available: `cmp --version`
2. Start with safe, read-only operation: `cmp [options] file`
3. Validate output on test data before processing at scale
4. Document exact command and flags for reproducibility

## Quick Command Reference

```bash
cmp --version                       # Check version
cmp --help                          # Show help
cmp file                            # Basic usage
cmp file | head                     # Limit output
man cmp                             # Full manual
```

## Safety Notes

| Area | Guardrail |
| --- | --- |
| **Untrusted input** | Validate files from untrusted sources before processing. |
| **Large files** | May consume memory on large files. Test with smaller samples first. |
| **Output handling** | Pipe output safely. Binary output may corrupt terminal. |
| **Symlinks** | Tool may follow or skip symlinks. Check man page for behavior. |

## Source Policy

- Treat the installed `cmp` behavior and `man cmp` as runtime truth.
- Use upstream documentation for semantics.

## Resource Index

- `scripts/install.sh` — Install cmp on macOS or Linux.
- `scripts/install.ps1` — Install cmp on Windows or any platform via PowerShell.
