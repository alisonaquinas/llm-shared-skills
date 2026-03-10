---
name: yq
description: >
  Process YAML, XML, and TOML files using jq-like filtering syntax.
  yq wraps jq to handle YAML input/output, xq handles XML transcoding,
  and tomlq handles TOML files. Supports format conversion, data extraction,
  filtering, and in-place file editing across multiple data formats.
---

# yq: Data Format Processor

Process YAML, XML, and TOML files using jq-compatible filtering syntax.
yq acts as a bridge between jq's powerful filtering and the diverse data formats used in modern development.

---

## Intent Router

Load reference files for depth on specific topics:

| Topic | File | Load when... |
| --- | --- | --- |
| Install & Setup | `references/install-and-setup.md` | Getting started with yq installation and initial configuration |
| Quick Reference | `references/quick-reference.md` | Need common flags, commands, and command-line options |
| Usage Patterns | `references/usage-patterns.md` | Learning filtering, format conversion, and data manipulation techniques |
| Examples & Recipes | `references/examples-and-recipes.md` | Looking for practical examples and real-world workflows |

---

## Quick Start

### Basic yq Workflow

1. **Extract data** — Filter YAML/XML/TOML using jq syntax: `yq .foo.bar file.yml`
2. **Convert formats** — Convert between formats: `yq -o json file.yml` or `yq -y file.json`
3. **Edit in place** — Modify files directly: `yq -i '.foo = "new"' file.yml`
4. **Preserve structure** — Use `-Y` (roundtrip) for custom YAML tags and folded strings

### Common Commands

```text
yq .foo.bar file.yml                    # Extract nested field as JSON
yq -y .foo file.yml                     # Extract as YAML output
yq '.[] | select(.status == "active")' file.yml   # Filter array elements
yq -i '.version = "2.0"' file.yml       # Modify and save in-place
yq -o json file.yml                     # Convert YAML to JSON
yq -o yaml file.json                    # Convert JSON to YAML
xq .book.author file.xml                # Process XML with xq
tomlq .database.host file.toml          # Process TOML with tomlq
yq -Y -i '.description |= split("\n")' file.yml   # Preserve tags during edit
```

### Key Features

- **jq-compatible filtering** — All jq syntax works on YAML/TOML/XML
- **Roundtrip mode** — `-Y` preserves custom YAML tags and formatted strings
- **Format conversion** — Seamlessly convert between JSON, YAML, TOML, XML
- **In-place editing** — `-i` flag modifies files directly, with backup if needed
- **Streaming** — Process stdin/stdout like jq for pipeline chaining

---

## Related References

- Load **Quick Reference** for command flags, options, and jq filter examples
- Load **Usage Patterns** to understand filtering, modification, and format conversion techniques
- Load **Examples & Recipes** for practical workflows and troubleshooting
