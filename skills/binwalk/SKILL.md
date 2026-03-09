---
name: binwalk
description: Scan files for embedded filesystems and data signatures. Use when the agent needs to inspect, analyze, or extract information from binary files or data structures.
---

# Binwalk

Scan files for embedded filesystems and data signatures

## Quick Start

1. Verify `binwalk` is available: `binwalk --version` or `man binwalk`
2. Establish the command surface: `man binwalk` or `binwalk --help`
3. Start with a read-only probe: `binwalk file`

## Intent Router

Load only the reference file needed for the active request.

- `references/install-and-setup.md` — Installing binwalk on macOS, Linux, Windows
- `references/cheatsheet.md` — Common options, output formats, usage patterns
- `references/advanced-usage.md` — Advanced patterns, performance optimization
- `references/troubleshooting.md` — Common errors, exit codes, platform differences

## Core Workflow

1. Verify binwalk is available: `binwalk --version`
2. Start with safe, read-only operation: `binwalk [options] file`
3. Validate output on test data before processing at scale
4. Document exact command and flags for reproducibility

## Quick Command Reference

```bash
binwalk --version                       # Check version
binwalk --help                          # Show help
binwalk file                            # Basic usage
binwalk file | head                     # Limit output
man binwalk                             # Full manual
```

## Safety Notes

| Area | Guardrail |
| --- | --- |
| **Untrusted input** | Validate files from untrusted sources before processing. |
| **Large files** | May consume memory on large files. Test with smaller samples first. |
| **Output handling** | Pipe output safely. Binary output may corrupt terminal. |
| **Symlinks** | Tool may follow or skip symlinks. Check man page for behavior. |

## Source Policy

- Treat the installed `binwalk` behavior and `man binwalk` as runtime truth.
- Use upstream documentation for semantics.

## Resource Index

- `scripts/install.sh` — Install binwalk on macOS or Linux.
- `scripts/install.ps1` — Install binwalk on Windows or any platform via PowerShell.
