# exiftool Cheatsheet

## High-value options

- `-json`: Emit metadata as JSON array.

- `-a`: Allow duplicate tags to be shown.

- `-G`: Show tag group names.

- `-overwrite_original`: Modify file without creating `_original` backup.

## Common one-liners

1. Set author tag

```bash

exiftool -Artist="Team" image.jpg

```

1. Batch strip metadata

```bash

exiftool -all= -overwrite_original media/*

```

1. Show GPS tags only

```bash

exiftool -gps:all photo.jpg

```

## Input/output patterns

- Input: Media/document files and tag assignment expressions.

- Output: Tag listings, modified files, and optional JSON exports.

## Troubleshooting quick checks

- If tags do not update, confirm target format supports writable fields.

- If backups accumulate, either manage `_original` files or use overwrite mode intentionally.

- If charset appears wrong, inspect encoding tags and output locale settings.

## When not to use this command

- Do not use `exiftool` for pixel-level image editing.
