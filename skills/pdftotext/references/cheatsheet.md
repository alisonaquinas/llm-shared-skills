# pdftotext Cheatsheet

## High-value options

- `-layout`: Maintain physical layout as closely as possible.

- `-f <N>`: First page to extract.

- `-l <N>`: Last page to extract.

- `-enc <ENC>`: Set output text encoding.

## Common one-liners

1. Extract to stdout

```bash

pdftotext report.pdf - | head -n 40

```

1. No page breaks

```bash

pdftotext -nopgbrk report.pdf report-flat.txt

```

1. UTF-8 output

```bash

pdftotext -enc UTF-8 report.pdf report-utf8.txt

```

## Input/output patterns

- Input: PDF files and optional extraction/layout/encoding options.

- Output: Plain text files or stdout streams.

## Troubleshooting quick checks

- If output is empty/garbled, verify whether the PDF contains selectable text.

- If table columns collapse, retry with `-layout`.

- If special characters break, set explicit encoding with `-enc`.

## When not to use this command

- Do not use `pdftotext` when exact visual reproduction or table structure fidelity is required.
