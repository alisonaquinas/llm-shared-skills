---
name: exiftool-command
description: "Read and edit file metadata with `exiftool`. Use when users ask for EXIF/IPTC/XMP inspection, metadata cleanup, or structured metadata export."
---

# exiftool Command Skill

## Purpose

Use `exiftool` to inspect, normalize, and edit metadata across images, media, and documents.

## Quick start

```bash

exiftool -ver

```

## Common workflows

1. Inspect all metadata for a file

```bash

exiftool photo.jpg

```

Comprehensive metadata view is useful before modifications.

1. Export metadata in JSON

```bash

exiftool -json photo.jpg

```

JSON mode supports deterministic downstream processing.

1. Remove all metadata from an image

```bash

exiftool -all= -overwrite_original photo.jpg

```

Strip operation is common for privacy-sensitive sharing.

## Guardrails

- By default exiftool creates backups; use `-overwrite_original` only when that is intended.

- Apply metadata edits to copies during testing to avoid irreversible loss.

- Different formats support different tag sets; verify writes actually persist.

## Reproducibility and reporting

- Record the exact command, flags, input paths, and working directory.

- Capture relevant environment details when they affect behavior (OS, tool version, locale, or shell).

- Summarize key output lines and explicitly note filters, truncation, or assumptions.
