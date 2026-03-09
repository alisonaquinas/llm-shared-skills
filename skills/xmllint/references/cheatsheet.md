# xmllint Cheatsheet

## High-value options

- `--noout`: Suppress normal output; show errors only.

- `--format`: Pretty-print XML output.

- `--xpath <EXPR>`: Evaluate XPath and print result.

- `--schema <XSD>`: Validate against XML Schema.

## Common one-liners

1. XPath extraction

```bash

xmllint --xpath '//item/@id' data.xml

```

1. Recover best-effort parse

```bash

xmllint --recover broken.xml > recovered.xml

```

1. Check DTD validity

```bash

xmllint --noout --valid document.xml

```

## Input/output patterns

- Input: XML documents plus optional XPath/schema files.

- Output: Validation diagnostics, extracted nodes, or formatted XML.

## Troubleshooting quick checks

- If XPath returns empty, verify namespaces and expression context.

- If schema validation fails, inspect line/column diagnostics for element mismatches.

- If parsing fails unexpectedly, check encoding declaration and file encoding.

## When not to use this command

- Do not use `xmllint` for JSON documents or non-XML markup.
