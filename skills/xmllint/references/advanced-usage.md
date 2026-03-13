# xmllint Advanced Usage

## XPath Query Patterns

### Text Content

```bash
# Get all text values of a specific element
xmllint --xpath '//product/name/text()' catalog.xml

# Get first value only
xmllint --xpath '(//product/name/text())[1]' catalog.xml

# String value of a node (normalized)
xmllint --xpath 'string(//config/host)' config.xml
```

### Attributes

```bash
# Get all id attributes
xmllint --xpath '//@id' file.xml

# Get attribute of specific element
xmllint --xpath '//item[@status="active"]/@id' items.xml

# Combined attribute + text
xmllint --xpath '//book[@lang="en"]/title/text()' books.xml
```

### Counting and Aggregation

```bash
# Count elements
xmllint --xpath 'count(//item)' file.xml

# Count matching elements
xmllint --xpath 'count(//order[@status="open"])' orders.xml
```

### Predicates and Filters

```bash
# Filter by child element value
xmllint --xpath '//user[role="admin"]/name/text()' users.xml

# Filter by position
xmllint --xpath '//item[position()<=3]/title/text()' feed.xml

# Filter by attribute presence
xmllint --xpath '//element[@optional]' file.xml
```

## Schema Validation Workflows

### XSD (XML Schema Definition)

```bash
# Basic schema validation
xmllint --noout --schema schema.xsd document.xml

# Validation with network blocked
xmllint --nonet --noout --schema schema.xsd document.xml

# Validate and see formatted output on success
xmllint --schema schema.xsd --format document.xml
```

### RelaxNG

```bash
# Validate against RelaxNG compact syntax
xmllint --noout --relaxng schema.rng document.xml
```

### DTD

```bash
# Validate using DTD declared in document
xmllint --noout --valid document.xml

# Validate against an external DTD file
xmllint --noout --dtdvalid local.dtd document.xml

# Validate with network blocked (local DTD only)
xmllint --nonet --noout --dtdvalid local.dtd document.xml
```

## Formatting with Custom Indent

```bash
# Two spaces (default)
xmllint --format file.xml

# Four spaces
XMLLINT_INDENT='    ' xmllint --format file.xml

# Tabs
XMLLINT_INDENT=$'\t' xmllint --format file.xml

# Format and overwrite in-place (use with caution)
xmllint --format file.xml --output file.xml
```

## Batch Validation

```bash
# Validate all XML files in a directory, report only failures
find . -name '*.xml' | while read f; do
  xmllint --noout --schema schema.xsd "$f" 2>/dev/null \
    || echo "INVALID: $f"
done

# Count errors across many files
find . -name '*.xml' -exec xmllint --noout {} \; 2>&1 | grep -c 'error'
```

## Piping and Combining with Other Tools

```bash
# Pretty-print from curl
curl -sf https://example.com/api/data.xml | xmllint --format -

# Extract field and process with awk
xmllint --xpath '//price/text()' items.xml | awk '{sum+=$1} END{print sum}'

# Validate and extract in one pass (two invocations)
xmllint --noout --schema schema.xsd file.xml && xmllint --xpath '//id/text()' file.xml
```

## Namespace Handling

XPath in xmllint does not support namespace-aware queries via command line the
same way as full XSLT processors. For namespace-prefixed documents:

```bash
# Strip namespaces first with sed, then query
sed 's/xmlns[^"]*"[^"]*"//g; s/<[a-z]*://g; s/<\/[a-z]*://g' file.xml \
  | xmllint --xpath '//element/text()' -
```

For robust namespace handling, consider `xsltproc` or `xq`.
