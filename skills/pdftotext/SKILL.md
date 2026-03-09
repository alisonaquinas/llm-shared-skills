---
name: pdftotext-command
description: "Extract text from PDFs with `pdftotext` and layout controls. Use when users ask for searchable text output, page-range extraction, or plain-text PDF conversion."
---

# pdftotext Command Skill

## Purpose

Use `pdftotext` to convert PDF page content into text for search, indexing, or review.

## Quick start

```bash

pdftotext -h

```

## Common workflows

1. Extract full document text to file

```bash

pdftotext report.pdf report.txt

```

Default extraction is suitable for basic indexing and grep workflows.

1. Preserve approximate page layout

```bash

pdftotext -layout report.pdf report-layout.txt

```

Layout mode keeps columns and spacing closer to visual structure.

1. Extract a specific page range

```bash

pdftotext -f 5 -l 8 report.pdf section.txt

```

Range extraction limits output to relevant sections.

## Guardrails

- Scanned image PDFs may need OCR before text extraction produces useful output.

- Layout-preserving mode can still lose complex table semantics.

- Record encoding and page-range flags for reproducibility.

## Reproducibility and reporting

- Record the exact command, flags, input paths, and working directory.

- Capture relevant environment details when they affect behavior (OS, tool version, locale, or shell).

- Summarize key output lines and explicitly note filters, truncation, or assumptions.
