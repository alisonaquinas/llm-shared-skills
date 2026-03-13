# xmllint Troubleshooting

## Exit Codes

| Code | Meaning |
| --- | --- |
| 0 | Success — no errors |
| 1 | Unclassified error |
| 2 | Error in DTD |
| 3 | Validation error |
| 4 | Validation error (alternative) |
| 5 | Error in schema compilation |
| 6 | Error writing output |
| 7 | Error in pattern (`--pattern`) |
| 8 | Error in XML reader |
| 9 | Out of memory |

Use `$?` to capture the exit code after a run:

```bash
xmllint --noout file.xml; echo "Exit: $?"
```

## Common Errors

### "failed to load external entity"

**Cause:** xmllint tried to fetch a DTD or entity from a URL or path that is
unavailable (network blocked, file missing, or a remote URI).

**Fix — use a local DTD:**

```bash
xmllint --nonet --noout --dtdvalid ./local-schema.dtd file.xml
```

**Fix — ignore DTD entirely:**

```bash
xmllint --noout file.xml  # skips DTD validation unless --valid is passed
```

**Fix — allow network (only for trusted files):**

```bash
xmllint --valid file.xml  # will attempt network DTD fetch
```

### "Document is not valid" / validation errors

**Cause:** The XML does not conform to the referenced schema or DTD.

**Debug:** Remove `--noout` to see the parsed tree alongside errors, or run
without `--valid`/`--schema` to check for well-formedness first:

```bash
xmllint file.xml 2>&1 | head -30
xmllint --noout file.xml   # well-formedness only
xmllint --noout --schema schema.xsd file.xml  # schema validation
```

### "XPath set is empty" / blank XPath output

**Cause:** The expression does not match any nodes. Possible reasons:

- Wrong path (typo, incorrect nesting)
- Namespace prefix in element names blocking the match
- Missing `/text()` — the node exists but has no text child

**Debug:**

```bash
# Inspect actual structure
xmllint --format file.xml | head -40

# Try broader match to confirm element presence
xmllint --xpath '//*[local-name()="yourElement"]' file.xml
```

### "Start tag expected" / parsing errors

**Cause:** The file is not well-formed XML (HTML, truncated file, encoding issue,
or a byte-order mark).

**Fix — try recovery mode:**

```bash
xmllint --recover --noout file.xml
xmllint --recover --format file.xml > recovered.xml
```

**Fix — check encoding:**

```bash
file file.xml        # check reported encoding
head -1 file.xml     # check XML declaration
```

### Schema validation fails with "unable to parse schema"

**Cause:** The XSD file itself has a syntax error, or it references an import
that cannot be resolved.

**Fix:**

```bash
# Validate the schema file first
xmllint --noout schema.xsd

# Block network schema imports
xmllint --nonet --noout --schema schema.xsd file.xml
```

### Output encoding issues / garbled characters

**Cause:** Input file encoding does not match the declared encoding.

**Fix:** Ensure the file is encoded as declared (`UTF-8` is standard):

```bash
file file.xml
iconv -f ISO-8859-1 -t UTF-8 file.xml | xmllint --format -
```

## Checking Installed Version

```bash
xmllint --version
# xmllint: using libxml version 21200
#    compiled with: ...
```

The version number is `AABBCC` where `AA` = major, `BB` = minor, `CC` = patch.
Version 21200 = libxml2 2.12.0.

## References

- libxml2 error codes: <https://gnome.pages.gitlab.gnome.org/libxml2/devhelp/libxml2-xmlerror.html>
- xmllint manual: <https://gnome.pages.gitlab.gnome.org/libxml2/xmllint.html>
