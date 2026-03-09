---
name: head
description: Quickly sample the beginning of files with head for inspecting headers, previewing content, and validating file prefixes. Use when the agent needs to peek at file starts, limit output to N lines or bytes, or validate file format headers.
---

# head

Sample and display the first lines or bytes of files or streams.

## Quick Start

1. Verify `head` is available: `head --version` or `man head`
2. Establish the command surface: `man head` or `head --help`
3. Start with a read-only probe: `head -n 5 file.txt`

## Intent Router

Load only the reference file needed for the active request.

- `references/install-and-setup.md` — Installing head (GNU, BSD) on macOS, Linux, Windows
- `references/cheatsheet.md` — Common flags, line/byte counts, multiple files, quiet/verbose output
- `references/advanced-usage.md` — GNU vs BSD differences, large file handling, stream processing, performance
- `references/troubleshooting.md` — Encoding issues, binary files, empty output, permission errors

## Core Workflow

1. Verify head version and variant (GNU vs BSD): `head --version` or `man head`
2. Specify count explicitly: `-n <N>` for lines or `-c <N>` for bytes
3. Use `-q` (quiet) for multiple files to suppress file headers
4. Run on sample data first to validate before processing at scale

## Quick Command Reference

```bash
head --version                      # Check version (GNU vs BSD)
head -n 5 file.txt                 # First 5 lines (explicit count)
head -c 1024 file.bin              # First 1024 bytes (explicit count)
head -n -5 file.txt                # All lines except last 5 (GNU only)
head -q -n 2 *.log                 # First 2 lines from all files, no headers
head -v -n 3 file.txt              # First 3 lines with file header (verbose)
man head                            # Full manual and options
```

## Safety Notes

| Area | Guardrail |
| --- | --- |
| **Explicit counts** | Always use `-n` or `-c` with explicit numbers; default values (10 lines) may not match intent. |
| **Multiple files** | When reading multiple files with `-q`, output lacks file name markers; confirm context before processing. |
| **Binary files** | head on binary files may include non-text bytes. Pipe through `xxd` or `od` for safe hex viewing. |
| **GNU vs BSD** | GNU head supports `-n -5` (all except last 5); BSD does not. Avoid for portability or test on target platform. |
| **Incomplete lines** | When using `-c`, output may end mid-line; subsequent processing may fail if expecting complete records. |
| **Large files** | head terminates early (safe) but still reads through file sequentially; not suitable for random access to large files. |

## Source Policy

- Treat the installed `head` behavior and `man head` as runtime truth.
- Use GNU Coreutils documentation (gnu.org/software/coreutils) for GNU-specific extensions.
- Use BSD manual for BSD variant behavior differences.

## Resource Index

- `scripts/install.sh` — Install head (GNU, BSD, or POSIX variant) on macOS or Linux.
- `scripts/install.ps1` — Install head on Windows or any platform via PowerShell.
