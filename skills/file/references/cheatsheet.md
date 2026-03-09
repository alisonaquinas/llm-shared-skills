# file Cheatsheet

## High-value options

- `--mime-type`: Emit MIME type only.

- `-i`: Emit MIME type and charset.

- `-b`: Brief output without filename prefix.

- `-L`: Follow symlinks and inspect target file.

## Common one-liners

1. Inspect archive candidates

```bash

file *.tar *.zip 2>/dev/null

```

1. Detect text vs binary quickly

```bash

file -b data/* | sort | uniq -c

```

1. Probe compressed files

```bash

file -z dumps/*

```

## Input/output patterns

- Input: Filesystem paths to files, symlinks, or compressed inputs (`-z`).

- Output: Filename plus type description, or MIME-oriented output variants.

## Troubleshooting quick checks

- If classification looks wrong, verify file integrity and truncation status.

- If symlink types are unexpected, compare with and without `-L`.

- If charset appears unknown, inspect raw bytes with `xxd`.

## When not to use this command

- Do not use `file` as the sole security decision gate for untrusted content.
