# xml2 / 2xml Cheatsheet

## Flat Format Anatomy

| XML | Flat line |
| --- | --- |
| `<root><a>hello</a></root>` | `/root/a=hello` |
| `<item id="3">` | `/root/item/@id=3` |
| `<item><a>1</a><a>2</a></item>` | `/root/item/a=1` then `/root/item/a=2` |
| Empty element `<br/>` | `/root/br` (no `=`) |

## xml2 — XML to Flat

```bash
# From file
xml2 < file.xml

# From stdin (e.g., curl)
curl -sf https://example.com/feed.xml | xml2

# Inspect all paths (unique)
xml2 < file.xml | cut -d= -f1 | sort -u
```

## 2xml — Flat to XML

```bash
# From file
2xml < flat.txt

# From pipeline
xml2 < file.xml | grep '/item/' | 2xml

# Round-trip
xml2 < file.xml | 2xml > copy.xml
```

## Common Patterns

### Extract values by path

```bash
# All titles
xml2 < feed.xml | grep '=/rss/channel/item/title=' | cut -d= -f2-

# Specific attribute
xml2 < data.xml | awk -F= '/\/@id=/{print $2}'
```

### Filter elements

```bash
# Keep only item elements and reconstruct
xml2 < feed.xml | grep '^/rss/channel/item/' | 2xml
```

### Edit a value

```bash
# Replace a specific value
xml2 < config.xml \
  | sed 's|/config/db/host=.*|/config/db/host=prod-db.example.com|' \
  | 2xml > config-prod.xml
```

### Add or remove a field

```bash
# Remove all <password> elements
xml2 < users.xml | grep -v '/user/password=' | 2xml > users-clean.xml

# Append a new field to each item (by appending a flat line before 2xml)
xml2 < items.xml | awk '{print} /\/item\/name=/{sub(/name=/,"status="); print "active"}' | 2xml
```

### Batch processing

```bash
for f in *.xml; do
  xml2 < "$f" | grep '/record/status=error' && echo "$f has errors"
done
```

## Exit Codes

| Code | Meaning |
| --- | --- |
| 0 | Success |
| Non-zero | Parse error or I/O failure |

## Limitations

- No namespace-aware path notation — namespaces appear as-is in element names
- No XPath support — use path patterns with grep/awk instead
- No streaming — full document loaded into memory
- CDATA sections are expanded to plain text
