---
name: unzip
description: Extract and test ZIP archives safely with destination validation and path traversal protection. Use when the agent needs to list archive contents, test integrity, or extract files with explicit overwrite policies.
---

# unzip

Extract and inspect ZIP archives with safety checks and destination control.

## Quick Start

1. Verify `unzip` is available: `unzip -h` or `man unzip`
2. Establish the command surface: `man unzip` or `unzip -h`
3. Start with list-only operation: `unzip -l archive.zip`

## Intent Router

Load only the reference file needed for the active request.

- `references/install-and-setup.md` — Installing unzip on macOS, Linux, Windows
- `references/cheatsheet.md` — Common operations, listing, testing, overwrite policies
- `references/advanced-usage.md` — Encryption, path traversal, exclusion patterns
- `references/troubleshooting.md` — Corruption detection, permission issues, encoding

## Core Workflow

1. Verify unzip is available: `unzip -h`
2. List archive contents first (safe, read-only): `unzip -l archive.zip`
3. Validate no suspicious paths (../, absolute paths): `unzip -l archive.zip | grep -E '^\s*\.\.|^/'`
4. Test integrity (without extracting): `unzip -t archive.zip`
5. Extract to explicit directory with policy: `unzip archive.zip -d output/ -o`

## Quick Command Reference

```bash
unzip -h                               # Show help
unzip -l archive.zip                   # List contents (read-only)
unzip -lv archive.zip                  # List with details
unzip -t archive.zip                   # Test integrity (no extraction)
unzip archive.zip -d output/           # Extract to directory
unzip -n archive.zip                   # Never overwrite existing files
unzip -o archive.zip                   # Always overwrite
unzip -u archive.zip                   # Update (extract only newer)
man unzip                              # Full manual
```

## Safety Notes

| Area | Guardrail |
| --- | --- |
| **Path traversal** | Always list before extracting. Reject archives with `../` or absolute paths. Use `-d` to extract to safe directory. |
| **Overwrite policy** | Use explicit policy: `-n` (never), `-o` (always), `-u` (update). Don't mix. |
| **Encryption** | Use interactive password (`-P -` or just `-P`). Never pass passwords as plain arguments. |
| **Permissions** | ZIP may have incorrect permissions. Verify after extraction. Use `chmod` if needed. |
| **Large files** | ZIP supports large files (>2GB). Verify disk space before extraction. |
| **Symlinks** | ZIP info-zip preserves symlinks. Be cautious with untrusted archives. |

## Source Policy

- Treat the installed `unzip` behavior and `man unzip` as runtime truth.
- Use upstream info-zip documentation for semantics.

## Resource Index

- `scripts/install.sh` — Install unzip on macOS or Linux.
- `scripts/install.ps1` — Install unzip on Windows or any platform via PowerShell.
