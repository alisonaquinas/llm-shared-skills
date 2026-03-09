---
name: xmllint-command
description: "Validate, format, and query XML with `xmllint`. Use when users ask for XML schema validation, XPath extraction, or normalized XML formatting checks."
---

# xmllint Command Skill

## Purpose

Use `xmllint` for XML well-formedness checks, XPath queries, and schema validation.

## Quick start

```bash

xmllint --help

```

## Common workflows

1. Check well-formed XML without output

```bash

xmllint --noout data.xml

```

Fast parse validation catches malformed XML early.

1. Pretty-print XML for review

```bash

xmllint --format data.xml > data.formatted.xml

```

Formatting helps visual diff and manual inspection.

1. Validate against an XSD schema

```bash

xmllint --noout --schema schema.xsd data.xml

```

Schema checks enforce structural constraints beyond well-formedness.

## Guardrails

- Be explicit with namespaces in XPath queries; defaults can miss matches.

- Use `--noout` in validation pipelines to avoid mixing output with diagnostics.

- Do not rely on formatted output as proof of schema correctness.

## Reproducibility and reporting

- Record the exact command, flags, input paths, and working directory.

- Capture relevant environment details when they affect behavior (OS, tool version, locale, or shell).

- Summarize key output lines and explicitly note filters, truncation, or assumptions.
