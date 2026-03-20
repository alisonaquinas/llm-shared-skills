---
name: 7z
description: Create and extract high-compression archives with 7z format supporting encryption and multiple compression methods. Use when the agent needs maximum compression ratio, encrypted archive handling, or cross-platform archive compatibility.
---

# 7z

High-compression archive creation with strong compression and encryption support.

## Prerequisite Check

Run this before proposing archive work:

```bash
command -v 7z >/dev/null 2>&1 || 7z --help
```

If `7z` is missing, surface that immediately and either:

- run `scripts/install.sh` or `scripts/install.ps1`
- fall back to `unzip` for ZIP extraction only
- fall back to `tar -xf archive.tar.*` for tar-based archives

## Quick Start

1. Verify `7z` is available: `7z --help` or `man 7z`
2. Establish the command surface: `7z --help` or `7z l archive.7z`
3. Start with a read-only probe: `7z l archive.7z`

## Intent Router

Load only the reference file needed for the active request.

- `references/install-and-setup.md` — Installing 7z on macOS, Linux, Windows
- `references/cheatsheet.md` — Common operations, compression levels, encryption
- `references/advanced-usage.md` — Solid archive format, compression algorithms, password handling
- `references/troubleshooting.md` — Extraction failures, corruption detection, path issues

## Core Workflow

1. Verify 7z is available: `7z --help`
2. List archive contents first (safe, read-only): `7z l archive.7z`
3. Extract to explicit destination with path validation: `7z x archive.7z -ooutput/`
4. Test archive integrity before relying on it: `7z t archive.7z`

## Quick Command Reference

```bash
7z --help                              # Show all commands and options
7z l archive.7z                        # List archive contents (read-only)
7z t archive.7z                        # Test archive integrity
7z x archive.7z -ooutput/              # Extract with full path preservation
7z a archive.7z files/                 # Create archive from directory
7z a -mx=9 archive.7z files/           # Maximum compression level
7z a -p archive.7z files/              # Encrypt with password prompt
man 7z                                 # Full manual (if available)
```

```bash
# Verify integrity before extracting an untrusted archive
7z t incoming.7z

# Use a fallback when the archive is ZIP and 7z is unavailable
unzip -l archive.zip
unzip archive.zip -d output/
```

## Safety Notes

| Area | Guardrail |
| --- | --- |
| **Path traversal** | Always specify output directory explicitly with `-o`. Validate paths don't traverse parent directories. Test on sample archive first. |
| **Encryption** | Use interactive password (`-p` without argument) to avoid passwords in history/scripts. Never pass passwords as command-line arguments. |
| **Archive validation** | Always run `7z t` before extracting untrusted archives. Check for embedded scripts or suspicious paths. |
| **Compression algorithms** | Solid archives and certain algorithms may have edge cases. Test extraction on target platform. |
| **Permission preservation** | 7z preserves file permissions; verify extracted permissions match expectations on target system. |
| **Symlinks** | 7z handles symlinks; be cautious with archives from untrusted sources that may create symlinks. |

Recovery note: if the runtime lacks `7z`, confirm the archive type first. Use `unzip` only for ZIP files and `tar` only for tar-based formats rather than guessing from the file extension alone.

## Source Policy

- Treat the installed `7z` behavior and help output as runtime truth.
- Use upstream 7z documentation for format specifications.

## Resource Index

- `scripts/install.sh` — Install 7z on macOS or Linux.
- `scripts/install.ps1` — Install 7z on Windows or any platform via PowerShell.
