# sed Cheatsheet

## High-value options

- `-n`: Suppress default printing; print only requested lines.

- `-E`: Enable extended regex syntax.

- `-e <SCRIPT>`: Provide editing script inline.

- `-i[SUFFIX]`: Edit files in place, optionally with backup suffix.

## Common one-liners

1. Delete blank lines

```bash

sed '/^$/d' notes.txt

```

1. Print lines containing ERROR

```bash

sed -n '/ERROR/p' app.log

```

1. Replace first match per line

```bash

sed 's/foo/bar/' input.txt

```

## Input/output patterns

- Input: Text files or stdin; optional in-place file updates with `-i`.

- Output: Transformed text to stdout, or modified files when `-i` is used.

## Troubleshooting quick checks

- If nothing prints, confirm `-n` is paired with explicit `p` commands.

- If replacements fail, check escaping of `/` and regex metacharacters.

- If in-place edits differ by OS, verify BSD vs GNU flag expectations.

## When not to use this command

- Do not use `sed` for nested data formats like JSON or XML; use format-aware tools.
