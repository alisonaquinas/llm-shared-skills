---
name: tar
description: Archive and compress files with automatic format detection and safe extraction paths. Use when the agent needs to create tarballs, extract archives, or validate archive contents before processing.
---

# tar

Create and extract archives with compression support and explicit path control.

## Quick Start

1. Verify `tar` is available: `tar --version` or `man tar`
2. Establish the command surface: `man tar` or `tar --help`
3. Start with list-only operation: `tar -tf archive.tar.gz`

## Intent Router

Load only the reference file needed for the active request.

- `references/install-and-setup.md` — Installing tar (GNU, BSD) on macOS, Linux, Windows
- `references/cheatsheet.md` — Common operations, compression flags, extraction patterns
- `references/advanced-usage.md` — GNU vs BSD differences, compression formats, symlink handling
- `references/troubleshooting.md` — Path traversal, extraction failures, encoding issues

## Core Workflow

1. Verify tar is available: `tar --version`
2. List archive contents first (safe, read-only): `tar -tf archive.tar.gz`
3. Validate no suspicious paths (../, absolute paths): `tar -tf archive.tar.gz | grep -E '^\.|/'`
4. Extract to explicit directory with path control: `tar -xzf archive.tar.gz -C safe_dir/`

## Quick Command Reference

```bash
tar --version                          # Check version
tar -tf archive.tar.gz                 # List contents (read-only)
tar -tv archive.tar.gz                 # List with details
tar -tzf archive.tar.gz                # Auto-detect compression and list
tar -czf archive.tar.gz directory/     # Create gzip-compressed archive
tar -cjf archive.tar.bz2 directory/    # Create bzip2-compressed archive
tar -xzf archive.tar.gz -C output/     # Extract with path control
tar -xzf archive.tar.gz --strip-components=1  # Strip leading directories
man tar                                # Full manual
```

## Safety Notes

| Area | Guardrail |
| --- | --- |
| **Path traversal** | Always list contents first. Reject archives with `../` or absolute paths. Extract to controlled directory with `-C`. |
| **Symlinks** | tar preserves symlinks. Be cautious with archives from untrusted sources that may link to sensitive files. |
| **Ownership** | tar preserves user/group ownership. Use `--no-same-owner` or `--no-same-permissions` if extracting untrusted archives. |
| **Compression detection** | Modern tar auto-detects compression (`-f`). Explicit flags (`-z`, `-j`) ensure reproducibility. |
| **Large files** | tar supports files >2GB. Verify disk space before extraction. |
| **Sparse files** | tar preserves sparse file structure (GNU tar). Extracted files will expand. |

## Source Policy

- Treat the installed `tar` behavior and `man tar` as runtime truth.
- Use GNU tar documentation (gnu.org/software/tar) for GNU-specific features.
- Use BSD tar manual for BSD variant behavior differences.

## Resource Index

- `scripts/install.sh` — Install tar on macOS or Linux.
- `scripts/install.ps1` — Install tar on Windows or any platform via PowerShell.
