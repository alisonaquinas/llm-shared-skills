---
name: awk-command
description: "Process columnar and line-based text with `awk`. Use when users ask for field extraction, conditional record filtering, or simple aggregations in shell workflows."
---

# awk Command Skill

## Purpose

Use `awk` for concise, scriptable field extraction, filtering, and aggregation on text records.

## Quick start

```bash

awk --help

```

## Common workflows

1. Print selected columns from whitespace-delimited data

```bash

awk '{print $1, $3}' metrics.txt

```

Useful for quick projections without loading external tools.

1. Filter rows by numeric thresholds

```bash

awk '$5 > 100 {print $1, $5}' usage.tsv

```

Numeric predicates are readable and fast for log-style data.

1. Process CSV-like input with explicit separator

```bash

awk -F, 'NR==1 || $3=="ERROR" {print $1, $3, $5}' events.csv

```

Set `-F` to align field parsing with input format.

## Guardrails

- Set `-F` and `OFS` explicitly when delimiters matter to avoid environment-dependent parsing.

- Treat quoted CSV edge cases carefully; basic `awk` is not a full CSV parser.

- Document whether line numbers (`NR`) or file-relative counters (`FNR`) are used in logic.

## Reproducibility and reporting

- Record the exact command, flags, input paths, and working directory.

- Capture relevant environment details when they affect behavior (OS, tool version, locale, or shell).

- Summarize key output lines and explicitly note filters, truncation, or assumptions.
