---
name: diff
description: Compare files and directories line-by-line with diff for detecting changes, generating patches, and reviewing modifications. Use when the agent needs to show differences between versions, generate unified diffs for version control, or verify file identity.
---

# diff

Compare files and directories line-by-line to detect changes and generate patches.

## Quick Start

1. Verify `diff` is available: `diff --version` or `man diff`
2. Establish the command surface: `man diff` or `diff --help`
3. Start with a read-only comparison: `diff file1.txt file2.txt`

## Intent Router

Load only the reference file needed for the active request.

- `references/install-and-setup.md` — Installing diff (GNU, BSD) on macOS, Linux, Windows
- `references/cheatsheet.md` — Common flags, unified diffs, context diffs, side-by-side output, patch generation
- `references/advanced-usage.md` — Recursive directory comparison, ignore patterns, patch application, three-way merge, performance
- `references/troubleshooting.md` — Binary file detection, line ending differences (CRLF vs LF), encoding issues, exit codes

## Core Workflow

1. Verify diff variant (GNU or BSD): `diff --version` or `man diff`
2. Choose comparison format: unified (`-u`), context (`-c`), or normal output
3. Run read-only comparison first: `diff file1 file2` to see changes
4. For patches, use unified format: `diff -u original modified > changes.patch`
5. Verify patch applies cleanly before merging: `patch --dry-run < changes.patch`

## Quick Command Reference

```bash
diff --version                         # Check version (GNU vs BSD)
diff file1 file2                       # Show line-by-line differences
diff -u file1 file2                    # Unified format (readable, useful for patches)
diff -c file1 file2                    # Context format (3 lines of context)
diff -y file1 file2                    # Side-by-side comparison
diff -u file1 file2 > changes.patch    # Generate patch file
diff -r dir1 dir2                      # Recursively compare directories
diff -i file1 file2                    # Ignore case differences
diff --ignore-all-space file1 file2    # Ignore whitespace
man diff                               # Full manual and options
```

## Safety Notes

| Area | Guardrail |
| --- | --- |
| **Line endings** | Windows (CRLF) vs Unix (LF) differences can obscure real changes. Use `--ignore-all-space` or normalize with `dos2unix` first. |
| **Binary files** | diff marks binary files as "Binary files ... differ" and does not show content. Use `xxd`, `hexdump`, or `cmp` for binary inspection. |
| **Large files** | Comparing very large files (>100 MB) can be slow. Use `cmp` for byte-level checking or `diff -q` for existence check. |
| **Patch direction** | Patches are directional: `diff -u original modified` (old → new). Reversed order creates inverting patch (`-R`). |
| **Character encoding** | diff may produce garbled output for non-UTF-8 files. Convert with `iconv` or check with `file`. |
| **Exit codes** | Exit 0 (identical), 1 (differ), 2 (error). Scripts must check `$?` carefully. |

## Source Policy

- Treat the installed `diff` behavior and `man diff` as runtime truth.
- Use GNU Coreutils documentation (gnu.org/software/diffutils) for GNU-specific features.
- Use BSD diff manual for BSD variant behavior differences.

## Resource Index

- `scripts/install.sh` — Install diff (GNU diffutils) on macOS or Linux.
- `scripts/install.ps1` — Install diff on Windows or any platform via PowerShell.
