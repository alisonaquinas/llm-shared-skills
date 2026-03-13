# xmllint Cheatsheet

## Core Flags

| Flag | Description |
| --- | --- |
| `--noout` | Suppress output; show errors only (use for validation) |
| `--format` | Pretty-print and re-indent XML |
| `--recover` | Attempt to parse malformed XML and produce best-effort output |
| `--valid` | Validate against DTD embedded in (or referenced from) document |
| `--dtdvalid FILE` | Validate against specified DTD file |
| `--schema FILE` | Validate against W3C XML Schema (XSD) |
| `--relaxng FILE` | Validate against RelaxNG schema |
| `--schematron FILE` | Validate using Schematron rules |
| `--xpath EXPR` | Evaluate XPath expression and print each matching node |
| `--nonet` | Block all network access during parsing (prevents XXE) |
| `--noent` | Substitute entities; do not expand external entity references |
| `--nocatalogs` | Ignore XML catalog mappings |
| `--path "DIR"` | Add directory to entity search path |
| `--output FILE` | Write output to file instead of stdout |

## Environment Variables

| Variable | Description |
| --- | --- |
| `XMLLINT_INDENT` | Characters used for indentation (default: two spaces). Set to `$'\t'` for tabs. |

## Well-Formedness

```bash
# Check and suppress tree output
xmllint --noout file.xml

# Pipe from stdin
cat file.xml | xmllint --noout -
```

## Validation

```bash
# Validate against DTD in document
xmllint --noout --valid document.xml

# Validate against external DTD
xmllint --noout --dtdvalid schema.dtd document.xml

# Validate against XML Schema (XSD)
xmllint --noout --schema schema.xsd file.xml

# Validate against RelaxNG
xmllint --noout --relaxng schema.rng file.xml

# Validate against Schematron
xmllint --noout --schematron rules.xsl file.xml

# Block network during schema validation
xmllint --nonet --noout --schema schema.xsd file.xml
```

## Formatting

```bash
# Re-indent with 2 spaces (default)
xmllint --format file.xml

# Tab indentation
XMLLINT_INDENT=$'\t' xmllint --format file.xml

# 4-space indentation
XMLLINT_INDENT='    ' xmllint --format file.xml

# Format and save
xmllint --format file.xml --output formatted.xml
```

## XPath Queries

```bash
# Select all matching nodes
xmllint --xpath '//book/title' library.xml

# Get text content only
xmllint --xpath '//book/title/text()' library.xml

# Count nodes
xmllint --xpath 'count(//book)' library.xml

# Get attribute value
xmllint --xpath '//book/@isbn' library.xml

# Filter by attribute
xmllint --xpath '//book[@available="yes"]/title/text()' library.xml

# First element
xmllint --xpath '(//book/title)[1]/text()' library.xml
```

## Recovery

```bash
# Try to parse malformed XML
xmllint --recover broken.xml

# Recover and format
xmllint --recover --format broken.xml
```

## Batch Validation

```bash
# Validate multiple files; report failures
for f in *.xml; do
  xmllint --noout --schema schema.xsd "$f" 2>/dev/null || echo "INVALID: $f"
done
```

## Exit Codes

| Code | Meaning |
| --- | --- |
| 0 | No errors |
| 1 | Unclassified error |
| 2 | Error in DTD |
| 3 | Validation error |
| 4 | Validation error |
| 5 | Error in schema compilation |
| 6 | Error writing output |
| 7 | Error in pattern (--pattern) |
| 8 | Error in reader |
| 9 | Out of memory error |
