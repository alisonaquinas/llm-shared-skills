---
name: pdfinfo-command
description: "Inspect PDF metadata and page characteristics with `pdfinfo`. Use when users ask for page counts, PDF producer metadata, or encryption/permission details."
---

# pdfinfo Command Skill

## Purpose

Use `pdfinfo` to quickly report PDF document metadata and structural properties.

## Quick start

```bash

pdfinfo -h

```

## Common workflows

1. Read document-level metadata

```bash

pdfinfo report.pdf

```

Provides title, author, page count, and producer info.

1. Inspect a page range

```bash

pdfinfo -f 1 -l 3 report.pdf

```

Page-range mode helps spot section-specific dimensions/boxes.

1. Display raw date fields

```bash

pdfinfo -rawdates report.pdf

```

Raw dates avoid locale conversion ambiguity.

## Guardrails

- Use `pdfinfo` for metadata only; it does not extract full page text.

- If PDF is encrypted, note permission constraints before further processing.

- Capture page range flags used when reporting partial document properties.

## Reproducibility and reporting

- Record the exact command, flags, input paths, and working directory.

- Capture relevant environment details when they affect behavior (OS, tool version, locale, or shell).

- Summarize key output lines and explicitly note filters, truncation, or assumptions.
