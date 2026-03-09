# xxd Cheatsheet

## High-value options

- `-l <LEN>`: Limit output length in bytes.

- `-s <OFF>`: Start at byte offset.

- `-g <N>`: Group bytes by N for readability.

- `-r`: Reverse a hex dump back to binary.

## Common one-liners

1. Plain hex stream

```bash

xxd -p sample.bin | tr -d "\n"

```

1. 16-byte grouped view

```bash

xxd -g 1 -l 64 sample.bin

```

1. Patch first bytes

```bash

printf '00000000: 89504e47\n' | xxd -r > header.bin

```

## Input/output patterns

- Input: Binary files or formatted hex dumps.

- Output: Hex dump text or reconstructed binary in reverse mode.

## Troubleshooting quick checks

- If reverse conversion fails, verify dump formatting and offsets.

- If output is too large, limit with `-l`.

- If grouping is confusing, adjust with `-g 1` for byte-level granularity.

## When not to use this command

- Do not use `xxd` for semantic disassembly; use `objdump` or dedicated reverse-engineering tools.
