# 7z Cheatsheet

## High-value options

- `l`: List archive contents and metadata.

- `x`: Extract with full paths.

- `a`: Add files to archive (create/update).

- `-p<PASS>`: Set password for encrypted archives.

## Common one-liners

1. Extract flat (no dirs)

```bash

7z e bundle.7z -oout_flat

```

1. Test archive integrity

```bash

7z t bundle.7z

```

1. Create encrypted archive

```bash

7z a secure.7z secrets/ -pStrongPass -mhe=on

```

## Input/output patterns

- Input: Archive paths, source files/directories, and optional password/compression flags.

- Output: Archive files, extracted paths, listing/test reports.

## Troubleshooting quick checks

- If extraction fails, verify archive format support in local 7z build.

- If wrong files appear, re-check whether `x` or `e` mode was used.

- If password errors occur, confirm both password and header-encryption settings.

## When not to use this command

- Do not use `7z` when strict POSIX tar semantics or metadata fidelity are mandatory.
