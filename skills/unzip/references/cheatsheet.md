# unzip Cheatsheet

## High-value options

- `-l`: List archive contents.

- `-d <DIR>`: Extract into target directory.

- `-o`: Overwrite existing files without prompting.

- `-n`: Never overwrite existing files.

## Common one-liners

1. Quiet extraction

```bash

unzip -q package.zip -d out

```

1. Extract specific file pattern

```bash

unzip package.zip 'docs/*' -d out

```

1. Print one file to stdout

```bash

unzip -p package.zip README.md | head

```

## Input/output patterns

- Input: ZIP file path plus optional selection patterns and destination flags.

- Output: Extracted files, listing reports, or integrity test results.

## Troubleshooting quick checks

- If CRC errors appear, archive may be corrupted; rerun `unzip -t` and replace source.

- If prompts block automation, add explicit overwrite policy flags.

- If encoding looks wrong for filenames, check locale and zip creator platform.

## When not to use this command

- Do not use `unzip` for 7z/rar formats; use the matching archive tool.
