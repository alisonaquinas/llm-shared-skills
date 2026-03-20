---
name: less
description: Paginate and search text files interactively. Use when the agent needs to search, filter, or transform data efficiently.
---

# Less

Paginate and search text files interactively

## Prerequisite Check

Run this before choosing an interactive pager workflow:

```bash
command -v less >/dev/null 2>&1 || less --version
```

If `less` is missing, switch to non-interactive fallbacks such as `head`, `tail`, or `sed -n`, and note that search/navigation will be more limited.

## Quick Start

1. Verify `less` is available: `less --version` or `man less`
2. Establish the command surface: `man less` or `less --help`
3. Start with basic usage: `less [options] [input]`

## Intent Router

- `references/install-and-setup.md` — Installing less
- `references/cheatsheet.md` — Common options and patterns
- `references/advanced-usage.md` — Advanced techniques
- `references/troubleshooting.md` — Common errors and solutions

## Core Workflow

1. Verify less is available: `less --version`
2. Test with sample data first
3. Validate output before batch processing
4. Document exact commands for reproducibility

## Quick Command Reference

```bash
less --version                       # Check version
less --help                          # Show help
less [options] [input]               # Basic usage
man less                             # Full manual
```

```bash
# Open a file with line numbers and quit if it fits on one screen
less -N -F build.log

# Fallbacks when less is unavailable
head -n 40 build.log
sed -n '120,180p' build.log
tail -n 40 build.log
```

## Safety Notes

| Area | Guardrail |
| --- | --- |
| **Input validation** | Verify input data format before processing. |
| **Output handling** | Validate output structure. |
| **Large files** | Test with smaller samples first. |

Recovery note: when `less` is unavailable, explain that paging/search commands like `/pattern` and `n` will not work. Use `sed -n` for exact ranges and `grep -n` to locate lines first.

## Source Policy

- Treat installed behavior and man page as truth.

## Resource Index

- `scripts/install.sh` — Install on macOS or Linux.
- `scripts/install.ps1` — Install on Windows or any platform.
