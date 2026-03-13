---
name: xq
description: >
  Query and transform XML documents using jq-compatible filter syntax.
  Use when the task involves extracting fields from XML, filtering XML arrays,
  converting XML to JSON, converting JSON back to XML, or applying jq-style
  transformations to XML data. xq is installed alongside yq via pip and works
  identically to jq but accepts XML input. Also supports streaming large XML
  files to avoid loading the full document into memory.
---

# xq

Query and transform XML using jq filter syntax. `xq` transcodes XML to JSON
internally, then passes it through `jq`, giving full access to jq's filter
language on XML input.

## Intent Router

| Request | Reference | Load When |
| --- | --- | --- |
| Install xq, jq dependency | `references/install-and-setup.md` | Setting up on a new system |
| Flags, options, one-liners | `references/cheatsheet.md` | Need quick command lookup |
| Streaming, roundtrip, complex filters | `references/advanced-usage.md` | Large files or multi-step transforms |

## Quick Start

```bash
# Extract a field
xq '.root.item.title' file.xml

# From stdin
cat feed.xml | xq '.rss.channel.title'

# Output as XML instead of JSON
xq -x '.rss.channel' feed.xml

# Get array length
xq '.rss.channel.item | length' feed.xml

# Filter array elements
xq '.catalog.book[] | select(.price | tonumber > 20) | .title' books.xml
```

## How It Works

1. `xq` converts XML → JSON using `xmltodict`
2. The JSON is piped through `jq` with the given filter
3. Output is JSON by default; use `-x` to get XML back

Attributes in XML become `@attr` keys in JSON:

```xml
<item id="42">Hello</item>
```

becomes:

```json
{"item": {"@id": "42", "#text": "Hello"}}
```

## Core Workflow

1. Probe structure: `xq '.' file.xml` — see the full JSON representation
2. Navigate to target: `xq '.root.child' file.xml`
3. Filter or transform with jq syntax
4. Use `-x` to reconstruct XML from the result if needed

## Safety Notes

| Area | Guardrail |
| --- | --- |
| **XXE** | Entity expansion is disabled by default via xmltodict. External entities are not fetched. |
| **Large files** | Use `--xml-item-depth N` to stream without loading full document into memory. |
| **jq dependency** | `jq` must be installed separately before `xq` works. Verify with `jq --version`. |
| **Repeated elements** | XML with repeated sibling elements is converted to a JSON array. A single element produces an object, not an array — use `Arrays` or `--xml-force-list` if needed. |

## Resource Index

- `scripts/install.sh` — Install jq and xq on macOS or Linux
- `scripts/install.ps1` — Install jq and xq on Windows
