---
name: exiftool
description: Extract and edit metadata from files. Use when the agent needs to extract, analyze, or transform document and file metadata.
---

# Exiftool

Extract and edit metadata from files

## Prerequisite Check

Run this before proposing metadata extraction or edits:

```bash
command -v exiftool >/dev/null 2>&1 || exiftool --version
```

If `exiftool` is missing, surface that first and either run `scripts/install.sh` or `scripts/install.ps1`, or fall back to `file` for basic type detection and `mediainfo` for media-only metadata.

## Quick Start

1. Verify `exiftool` is available: `exiftool --version` or `man exiftool`
2. Establish the command surface: `man exiftool` or `exiftool --help`
3. Start with a read-only probe: `exiftool file`

## Intent Router

- `references/install-and-setup.md` — Installing exiftool
- `references/cheatsheet.md` — Common options and patterns
- `references/advanced-usage.md` — Advanced techniques
- `references/troubleshooting.md` — Common errors and solutions

## Core Workflow

1. Verify exiftool is available: `exiftool --version`
2. Inspect file: `exiftool file`
3. Validate output before batch processing
4. Document exact commands for reproducibility

## Quick Command Reference

```bash
exiftool --version                       # Check version
exiftool --help                          # Show help
exiftool file                            # Basic usage
man exiftool                             # Full manual
```

```bash
# Read only a few tags while verifying the file is what you expect
file photo.jpg
exiftool -DateTimeOriginal -Model photo.jpg

# Fallback when exiftool is unavailable and the file is media
mediainfo photo.jpg
```

## Safety Notes

| Area | Guardrail |
| --- | --- |
| **File validation** | Verify files are in expected format. |
| **Output handling** | Validate output before processing further. |
| **Large files** | Test with smaller files first. |

Recovery note: if `exiftool` is unavailable, state the reduced-coverage fallback clearly. `file` can confirm type, but it will not replace full EXIF/XMP/IPTC extraction.

## Source Policy

- Treat installed behavior and man page as truth.

## Resource Index

- `scripts/install.sh` — Install on macOS or Linux.
- `scripts/install.ps1` — Install on Windows or any platform.
