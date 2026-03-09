---
name: file
description: Identify file types using magic numbers and content analysis. Use when the agent needs to inspect, analyze, or extract information from binary files or data structures.
---

# File

Identify file types using magic numbers and content analysis

## Quick Start

1. Verify `file` is available: `file --version` or `man file`
2. Establish the command surface: `man file` or `file --help`
3. Start with a read-only probe: `file file`

## Intent Router

Load only the reference file needed for the active request.

- `references/install-and-setup.md` — Installing file on macOS, Linux, Windows
- `references/cheatsheet.md` — Common options, output formats, usage patterns
- `references/advanced-usage.md` — Advanced patterns, performance optimization
- `references/troubleshooting.md` — Common errors, exit codes, platform differences

## Core Workflow

1. Verify file is available: `file --version`
2. Start with safe, read-only operation: `file [options] file`
3. Validate output on test data before processing at scale
4. Document exact command and flags for reproducibility

## Quick Command Reference

```bash
file --version                       # Check version
file --help                          # Show help
file file                            # Basic usage
file file | head                     # Limit output
man file                             # Full manual
```

## Safety Notes

| Area | Guardrail |
| --- | --- |
| **Untrusted input** | Validate files from untrusted sources before processing. |
| **Large files** | May consume memory on large files. Test with smaller samples first. |
| **Output handling** | Pipe output safely. Binary output may corrupt terminal. |
| **Symlinks** | Tool may follow or skip symlinks. Check man page for behavior. |

## Source Policy

- Treat the installed `file` behavior and `man file` as runtime truth.
- Use upstream documentation for semantics.

## Resource Index

- `scripts/install.sh` — Install file on macOS or Linux.
- `scripts/install.ps1` — Install file on Windows or any platform via PowerShell.
