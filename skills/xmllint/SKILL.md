---
name: xmllint
description: >
  Parse, validate, format, and query XML documents using xmllint from libxml2.
  Use when the task involves checking XML well-formedness, validating against a
  DTD or XML Schema (XSD), validating against RelaxNG or Schematron, running
  XPath queries to extract values from XML, pretty-printing or reformatting XML,
  or recovering structure from malformed XML. Also use when processing untrusted
  XML and network access must be blocked to prevent XXE attacks.
---

# xmllint

Parse, validate, format, and query XML documents. Part of the libxml2 toolset.

## Intent Router

| Request | Reference | Load When |
| --- | --- | --- |
| Install xmllint | `references/install-and-setup.md` | Setting up on a new system |
| Flags, options, one-liners | `references/cheatsheet.md` | Need quick command lookup |
| XPath queries, schema workflows | `references/advanced-usage.md` | Complex validation or extraction tasks |
| Errors, exit codes, common failures | `references/troubleshooting.md` | Something is failing or output is unexpected |

## Quick Reference

```bash
# Check well-formedness (exit 0 = valid)
xmllint --noout file.xml

# Pretty-print / reformat
xmllint --format file.xml

# Custom indentation (tab)
XMLLINT_INDENT=$'\t' xmllint --format file.xml

# Validate against XML Schema
xmllint --noout --schema schema.xsd file.xml

# Validate against DTD embedded in document
xmllint --noout --valid file.xml

# XPath query
xmllint --xpath '//book/title/text()' file.xml

# Block network access (safe for untrusted XML)
xmllint --nonet --noout file.xml

# Attempt recovery from malformed XML
xmllint --recover file.xml
```

## Core Workflow

1. Check availability: `xmllint --version`
2. Verify well-formedness: `xmllint --noout file.xml`
3. Validate against schema if available: `xmllint --noout --schema schema.xsd file.xml`
4. Query specific values: `xmllint --xpath 'expression' file.xml`
5. Format for readability: `xmllint --format file.xml`

## Security: XXE Prevention

By default, `xmllint` fetches external DTDs and entities from the network. When
processing untrusted XML, always add `--nonet`:

```bash
# Safe invocation for untrusted input
xmllint --nonet --noout file.xml
xmllint --nonet --schema schema.xsd file.xml
```

`--nonet` blocks all network access during parsing and validation.

## Safety Notes

| Area | Guardrail |
| --- | --- |
| **Untrusted XML** | Always use `--nonet` to prevent XXE (XML External Entity) attacks. |
| **Validation output** | Use `--noout` to suppress the parsed tree — show only errors. |
| **Large files** | Test with `--noout` first; full output of large files can be verbose. |
| **Recovery mode** | `--recover` may produce incomplete or structurally incorrect output. Validate the result. |

## Resource Index

- `scripts/install.sh` — Install libxml2-utils on macOS or Linux
- `scripts/install.ps1` — Install on Windows via Chocolatey
