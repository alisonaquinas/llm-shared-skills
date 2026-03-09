---
name: jq-command
description: "Query and transform JSON with `jq` filters. Use when users ask for JSON field extraction, reshaping, validation, or compact machine-readable transformations."
---

# jq Command Skill

## Purpose

Use `jq` to parse, filter, and transform JSON data with composable expressions.

## Quick start

```bash

jq --help

```

## Common workflows

1. Pretty-print JSON for inspection

```bash

jq . payload.json

```

Baseline formatting confirms JSON validity and structure.

1. Extract fields from array entries

```bash

jq -r '.items[] | [.id, .status] | @tsv' payload.json

```

Raw output mode is convenient for shell pipelines.

1. Filter objects by condition

```bash

jq '.events[] | select(.severity == "error")' events.json

```

Predicate filters keep downstream results focused.

## Guardrails

- Use `-r` only when raw strings are needed; keep JSON output for structured chaining.

- Validate assumptions about null/missing fields to avoid silent data loss.

- Quote filters in single quotes to prevent shell interpolation issues.

## Reproducibility and reporting

- Record the exact command, flags, input paths, and working directory.

- Capture relevant environment details when they affect behavior (OS, tool version, locale, or shell).

- Summarize key output lines and explicitly note filters, truncation, or assumptions.
