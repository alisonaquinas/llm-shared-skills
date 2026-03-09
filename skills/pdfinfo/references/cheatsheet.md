# pdfinfo Cheatsheet

## High-value options

- `-f <N>`: First page to inspect.

- `-l <N>`: Last page to inspect.

- `-box`: Report page box geometry.

- `-rawdates`: Emit raw date values from metadata.

## Common one-liners

1. Metadata only for first 10 pages

```bash

pdfinfo -f 1 -l 10 report.pdf

```

1. Print custom metadata XML

```bash

pdfinfo -meta report.pdf

```

1. Check encryption flags

```bash

pdfinfo report.pdf | rg -i 'encrypted|permissions'

```

## Input/output patterns

- Input: PDF file paths and optional page-range flags.

- Output: Document and page metadata summary text.

## Troubleshooting quick checks

- If command fails, confirm file is a valid PDF with `file`.

- If dates look inconsistent, compare normal and `-rawdates` output.

- If permissions block operations, inspect encryption metadata first.

## When not to use this command

- Do not use `pdfinfo` for OCR or text extraction tasks; use `pdftotext` or OCR tools.
