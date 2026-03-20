---
name: xml2
description: >
  Convert XML documents to flat line-oriented format for Unix pipeline processing,
  and reconstruct XML from flat format using 2xml. Use when the task involves
  extracting fields from XML with grep, sed, or awk; editing XML values in-place
  via pipeline; transforming or filtering XML without an XML-aware tool; or
  performing round-trip XML modification using shell text tools. Also useful when
  flattening RSS/Atom feeds, config files, or data exports to extract specific paths.
---

# xml2 / 2xml

Convert XML to a flat, line-oriented format for shell pipeline processing, and
reconstruct XML with `2xml`.

## Prerequisite Check

Run this before proposing flat XML workflows:

```bash
command -v xml2 >/dev/null 2>&1 && command -v 2xml >/dev/null 2>&1
```

If `xml2` or `2xml` is missing, surface that first and either run `scripts/install.sh` or `scripts/install.ps1`, or fall back to `xmllint` or `xq` when the task can stay XML-aware instead of line-oriented.

## Intent Router

| Request | Reference | Load When |
| --- | --- | --- |
| Install xml2/2xml | `references/install-and-setup.md` | Setting up on a new system |
| Flat format syntax, flags, one-liners | `references/cheatsheet.md` | Need quick command lookup |
| Pipeline patterns, round-trip recipes | `references/examples-and-recipes.md` | Building multi-step workflows |

## Quick Start

```bash
# Flatten XML to inspect structure
xml2 < file.xml

# Extract all values at a path
xml2 < file.xml | grep '/root/item/title='

# Edit a value and reconstruct
xml2 < file.xml | sed 's|/config/host=.*|/config/host=newhost|' | 2xml > modified.xml

# Round-trip (should produce equivalent XML)
xml2 < file.xml | 2xml
```

```bash
# Verify a round-trip with XML-aware tooling
xml2 < file.xml | 2xml | xmllint --format -

# Fallback when xml2 is unavailable
xmllint --xpath '//item/title/text()' file.xml
```

## Flat Format

`xml2` converts XML into one line per node, using path=value notation:

```text
/rss/channel/title=My Blog
/rss/channel/item/title=First Post
/rss/channel/item/@id=42
/rss/channel/item/body=Hello world
```

- Element text becomes `/path/to/element=value`
- Attributes become `/path/to/element/@attr=value`
- Repeated elements produce multiple lines with the same path
- `2xml` reverses the transformation line-by-line

## Core Workflow

1. Flatten: `xml2 < input.xml` — inspect paths and values
2. Filter or edit: pipe through `grep`, `sed`, `awk`
3. Reconstruct: pipe result into `2xml > output.xml`
4. Verify: compare structure with `xmllint --format output.xml`

## Safety Notes

| Area | Guardrail |
| --- | --- |
| **Fidelity** | Round-trip may not preserve XML declaration, whitespace, or namespace prefixes exactly. |
| **Mixed content** | Elements with both text and child elements may lose structure. Test round-trip before relying on output. |
| **Large files** | `xml2` loads the full document into memory. Use streaming tools (e.g., `xq --xml-item-depth`) for very large files. |
| **Encoding** | Input should be UTF-8. Non-UTF-8 files may produce garbled output. |

Recovery note: when `xml2` is unavailable, keep the fallback boundary explicit. `xmllint` and `xq` can query XML, but they do not preserve the same flat line-oriented editing model.

## Resource Index

- `scripts/install.sh` — Install on macOS or Linux
- `scripts/install.ps1` — Install notes for Windows (WSL required)
