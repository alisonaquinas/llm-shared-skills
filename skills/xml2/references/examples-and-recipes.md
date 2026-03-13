# xml2 / 2xml Examples and Recipes

## Recipe 1: Extract RSS/Atom Feed Titles

```bash
# Print all article titles from an RSS feed
curl -sf https://example.com/feed.xml | xml2 | grep '/rss/channel/item/title=' | cut -d= -f2-
```

## Recipe 2: Inspect Unknown XML Structure

```bash
# See all unique paths in a document
xml2 < mystery.xml | cut -d= -f1 | sort -u

# Sample first 5 values at each path
xml2 < mystery.xml | awk -F= '!seen[$1]++ && ++c[$1]<=5'
```

## Recipe 3: Edit Config Value In-Place

```bash
# Change database host in a Spring Boot config
xml2 < application-config.xml \
  | sed 's|/beans/bean\[@id="dataSource"\]/property\[@name="url"\]/@value=.*|\0jdbc:mysql://newhost:3306/mydb|' \
  | 2xml > application-config-new.xml
```

## Recipe 4: Filter and Reconstruct Subset

```bash
# Extract only <error> log entries and rebuild XML
xml2 < logs.xml | grep '/log/entry/level=ERROR' -A 5 | 2xml > errors.xml
```

## Recipe 5: Compare Two XML Files via Flat Format

```bash
# Diff two XML files ignoring whitespace and ordering
diff <(xml2 < v1.xml | sort) <(xml2 < v2.xml | sort)
```

## Recipe 6: Strip Sensitive Fields Before Sharing

```bash
# Remove all <ssn> and <password> elements
xml2 < users.xml \
  | grep -Ev '/user/(ssn|password)=' \
  | 2xml > users-redacted.xml
```

## Recipe 7: Count Elements

```bash
# Count how many <item> elements exist
xml2 < feed.xml | grep -c '^/rss/channel/item/@'
```

## Recipe 8: Batch Validate Presence of Required Field

```bash
# Check which XML files are missing a <version> element
for f in *.xml; do
  xml2 < "$f" | grep -q '/package/version=' || echo "MISSING version: $f"
done
```

## Round-Trip Fidelity Notes

Round-trip conversion (`xml2 | 2xml`) preserves:

- Element names and nesting
- Attribute names and values
- Text content

It may not preserve:

- XML declaration (`<?xml version="1.0"?>`) — add manually if needed
- Processing instructions
- Comments
- Namespace prefix aliases (expanded to full URIs or dropped)
- Whitespace-only text nodes

Always validate the output with `xmllint --noout` after round-tripping critical files.
