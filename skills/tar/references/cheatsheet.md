# tar Cheatsheet

## High-value options

- `-c`: Create archive.

- `-x`: Extract archive.

- `-t`: List archive contents.

- `-f <FILE>`: Archive file path (required with most commands).

## Common one-liners

1. Create from file list

```bash

tar -czf subset.tar.gz -T files.txt

```

1. Strip first path component on extract

```bash

tar -xzf pkg.tar.gz --strip-components=1 -C out

```

1. Verbose list with permissions

```bash

tar -tvf pkg.tar.gz | head

```

## Input/output patterns

- Input: Filesystem paths and tar archives with optional compression layers.

- Output: Archive files, extracted directories, or listing output.

## Troubleshooting quick checks

- If extraction fails, verify compression type matches flags (`-z`, `-j`, `-J`).

- If ownership/permissions are unexpected, inspect archive metadata with `tar -tvf`.

- If paths look unsafe, reject extraction and sanitize source archive.

## When not to use this command

- Do not use `tar` when random access updates inside compressed archives are required.
