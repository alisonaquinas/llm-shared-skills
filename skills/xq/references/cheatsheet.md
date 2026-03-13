# xq Cheatsheet

## Key Flags

| Flag | Description |
| --- | --- |
| `-x` / `--xml-output` | Output XML instead of JSON |
| `--xml-item-depth N` | Stream document N levels deep without full load |
| `--xml-dtd` | Preserve XML Document Type Definition in output |
| `--xml-root NAME` | Wrap JSON-to-XML output in a root element named NAME |
| `-r` | Raw output (string without JSON quotes) — passed to jq |
| `-c` | Compact JSON output — passed to jq |

## XML-to-JSON Mapping

| XML | JSON key |
| --- | --- |
| `<elem>text</elem>` | `"elem": "text"` |
| `<elem attr="v">` | `"elem": {"@attr": "v", "#text": null}` |
| `<elem attr="v">t</elem>` | `"elem": {"@attr": "v", "#text": "t"}` |
| Multiple `<item>` siblings | `"item": [...]` array |
| Single `<item>` | `"item": {...}` object (not array) |

## Common Queries

```bash
# See full structure as JSON
xq '.' file.xml

# Extract text field
xq '.root.child' file.xml
xq -r '.root.child' file.xml        # without quotes

# Navigate attributes
xq '.items.item[] | .["@id"]' file.xml

# Array operations
xq '.catalog.book | length' books.xml
xq '.catalog.book[0]' books.xml
xq '.catalog.book[-1]' books.xml    # last element

# Filter by condition
xq '.catalog.book[] | select(.price | tonumber > 20)' books.xml
xq '.items.item[] | select(.["@status"] == "active")' items.xml

# Extract multiple fields
xq '.catalog.book[] | {title, price}' books.xml

# Convert XML to JSON file
xq '.' file.xml > file.json

# Convert JSON to XML (requires --xml-root if no natural root)
jq '.' data.json | xq -x --xml-root root '.'
```

## Format Conversion

```bash
# XML → JSON
xq '.' input.xml > output.json

# XML → YAML (pipe through yq)
xq '.' input.xml | yq -y '.'

# JSON → XML
cat data.json | xq -x --xml-root root '.'
```

## Streaming Large Files

```bash
# Process Wikipedia dump without loading full file
bunzip2 -c enwiki-latest-articles.xml.bz2 | xq '.' --xml-item-depth=2

# Extract specific fields at depth 2
bunzip2 -c enwiki-latest-articles.xml.bz2 \
  | xq '.page | {title, id}' --xml-item-depth=2
```

## Multiple Files

```bash
# Process multiple XML files
xq '.root.version' config1.xml config2.xml config3.xml
```

## Troubleshooting

| Error | Cause | Fix |
| --- | --- | --- |
| `jq: command not found` | jq not installed | `brew install jq` or `apt install jq` |
| `null` output | Wrong path | Use `xq '.'` to inspect full structure |
| Object instead of array | Only one sibling element | Access with `.elem` not `.elem[]` |
| `KeyError: '#text'` | Mixed content element | Access with `.["#text"]` |
