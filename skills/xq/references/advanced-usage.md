# xq Advanced Usage

## Streaming Large XML Files

For files too large to load into memory, use `--xml-item-depth` to stream the
document by descending only N levels before emitting items:

```bash
# Stream at depth 2 — process each top-level child without loading siblings
xq '.' large.xml --xml-item-depth=2

# Extract specific fields from a large export
xq '.record | {id: .["@id"], name: .name}' export.xml --xml-item-depth=2

# Wikipedia dump — process each <page> element independently
bunzip2 -c enwiki-latest-articles.xml.bz2 \
  | xq '{title: .page.title, id: .page.id}' --xml-item-depth=2
```

`--xml-item-depth=2` means: emit one JSON object per child of the root element,
rather than building one giant JSON document.

## Roundtrip XML → JSON → XML

Use `-x` / `--xml-output` to get XML back from a jq transformation:

```bash
# Filter elements and reconstruct XML
xq -x '.catalog.book[] | select(.price | tonumber < 15)' books.xml

# Wrap result in a root element
xq -x --xml-root filtered '.catalog.book[] | select(.in_stock == "true")' books.xml
```

Note: the reconstructed XML uses xmltodict's serialization, which may differ in
whitespace and namespace handling from the original.

## Handling the Single-Element Array Problem

When XML has a single child element, xq produces an object. When there are
multiple, it produces an array. To always get an array:

```bash
# Wrap single result in array if needed
xq '[.catalog.book] | flatten' books.xml

# Or use jq's arrays filter
xq '.catalog.book | if type == "array" then . else [.] end' books.xml
```

## Accessing Attributes

Attributes appear as `@name` keys in JSON:

```bash
# Get the id attribute of each item
xq '.items.item[] | .["@id"]' items.xml

# Filter by attribute value
xq '.items.item[] | select(.["@status"] == "active") | .name' items.xml

# Mix attribute and text content
xq '.items.item[] | {id: .["@id"], value: .["#text"]}' items.xml
```

## Combining with jq Filters

All jq filters work directly on the transcoded XML:

```bash
# group_by
xq '.orders.order | group_by(.status)' orders.xml

# Reduce / accumulate
xq '[.items.item[].price | tonumber] | add' items.xml

# sort_by
xq '.catalog.book | sort_by(.price | tonumber)' books.xml

# map and select
xq '.catalog.book | map(select(.author == "J.K. Rowling"))' books.xml
```

## DTD Preservation

```bash
# Preserve the DTD when roundtripping
xq --xml-dtd '.' document.xml
```

## Format Conversion Recipes

### XML → YAML

```bash
xq '.' input.xml | yq -y '.'
```

### XML → CSV (with jq)

```bash
xq -r '.catalog.book[] | [.title, .author, .price] | @csv' books.xml
```

### JSON → XML

```bash
# Pipe JSON through xq with -x and a root wrapper
cat data.json | xq -x --xml-root root '.'
```

## Security Notes

- External entity expansion is disabled by default (via xmltodict's safe defaults).
- DTD network fetching does not occur.
- For fully untrusted XML, `xq` is generally safer than tools that resolve external entities.
