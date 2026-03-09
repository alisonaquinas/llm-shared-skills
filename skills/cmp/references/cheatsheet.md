# cmp Cheatsheet

## High-value options

- `-s`: Silent mode; rely on exit status only.

- `-l`: Print byte number and differing byte values.

- `-n <N>`: Compare only first N bytes.

- `-i <SKIP>`: Skip bytes at beginning before comparison.

## Common one-liners

1. Silent equality check

```bash

cmp -s a.bin b.bin && echo equal || echo different

```

1. Find first mismatch quickly

```bash

cmp a.bin b.bin

```

1. Skip headers before compare

```bash

cmp -i 512 firmwareA.bin firmwareB.bin

```

## Input/output patterns

- Input: Two file paths and optional byte offsets/limits.

- Output: No output on equality by default, or mismatch details with `-l`.

## Troubleshooting quick checks

- If command exits with trouble code, verify paths and read permissions.

- If mismatch occurs unexpectedly, confirm files are from the same build/configuration.

- If output is too verbose, switch from `-l` to `-s` and inspect only first mismatch separately.

## When not to use this command

- Do not use `cmp` for human-friendly text diffs; use `diff -u` for contextual review.
