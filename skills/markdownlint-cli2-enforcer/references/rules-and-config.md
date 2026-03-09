# Markdownlint Rules and Configuration

## Configuration File Formats

Markdownlint supports multiple configuration formats. The tool searches in this order:

### `.markdownlint-cli2.jsonc` (JSON with comments)

```jsonc
{
  "extends": "default",
  "rules": {
    "MD013": { "line_length": 120 },
    "MD026": false,  // Disable rule
    "MD033": { "allowed_elements": ["br"] }
  }
}
```

### `.markdownlint.yaml` or `.markdownlint.yml`

```yaml
extends: default
rules:
  MD013:
    line_length: 120
  MD026: false
  MD033:
    allowed_elements: [br]
```

### `.markdownlint.json`

```json
{
  "extends": "default",
  "rules": {
    "MD013": { "line_length": 120 }
  }
}
```

## Common Rules Reference

| ID | Rule | Detects | How to Configure |
|---|---|---|---|
| MD001 | heading-increment | Non-sequential heading levels | Disable: `MD001: false` |
| MD003 | heading-style | Inconsistent heading syntax | `{ "style": "consistent" \| "atx" \| "setext" }` |
| MD004 | ul-style | Inconsistent unordered list markers | `{ "style": "consistent" \| "-" \| "*" \| "+" }` |
| MD005 | list-indent | Inconsistent list indentation | Disable if inconsistent parent lists |
| MD013 | line-length | Lines exceeding max (default 80) | `{ "line_length": 120 }` or disable for long URLs |
| MD026 | no-trailing-punctuation | Trailing punctuation in headings | Disable with `MD026: false` |
| MD033 | no-inline-html | Raw HTML in Markdown | `{ "allowed_elements": ["br", "img"] }` |
| MD040 | fenced-code-language | Fenced code without language tag | Disable if language-agnostic files |

## Curvecapture Config Explained

The curvecapture `markdownlint-cli2.jsonc` disables:

- **MD013** (line-length) — allows documentation with long URLs and code examples
- **MD026** (no-trailing-punctuation) — allows descriptive headings like "What is This?"
- **MD033** (no-inline-html) — allows `<br>`, `<img>`, and other HTML where Markdown lacks equivalent

All other default rules remain enabled.

## Common Violations with Examples

### MD001: Heading Increment

❌ **Bad:**

```markdown
# Main Title
### Subsection (skips level 2)
```

✅ **Good:**

```markdown
# Main Title
## Subsection
### Sub-subsection
```

### MD013: Line Too Long

❌ **Bad (over 80 chars):**

```markdown
This is a very long line of text that exceeds the default character limit and should be wrapped
```

✅ **Good (under 80 chars):**

```markdown
This is a very long line of text that exceeds the
default character limit and should be wrapped
```

### MD033: Inline HTML

❌ **Bad (raw HTML):**

```markdown
Use <br> to break lines and <img src="x.png"> for images
```

✅ **Good (Markdown native):**

```markdown
Use double space at end of line to break lines
![Image alt text](x.png)
```

## Troubleshooting

### Tool Passes Silently, No Violations Reported

**Cause:** Config file not found or rule disabled.

**Solution:**

1. Check config file exists in search path
2. Run with `--verbose` to see which config loaded
3. Verify rule is not disabled in the config

### Specific Violations Don't Appear

**Cause:** Rule might be disabled in config or not apply to file type.

**Solution:**

1. Check rule isn't set to `false` in config
2. Ensure file is `.md` or `.markdown` extension
3. Run manually: `markdownlint-cli2 --config <path> <file>`

### Exit Code Meanings

| Code | Meaning | Action |
|---|---|---|
| 0 | All files pass | No action needed |
| 1 | Violations found | Review config and fix violations |
| 2 | Invalid arguments or config error | Check command syntax and config validity |
