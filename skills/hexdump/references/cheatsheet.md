# hexdump Cheatsheet

## High-value options

- `-C`: Canonical hex + ASCII display.

- `-s <OFF>`: Skip bytes before dumping.

- `-n <LEN>`: Limit bytes displayed.

- `-e <FMT>`: Custom output format expression.

## Common one-liners

1. First 64 bytes canonical

```bash

hexdump -C -n 64 sample.bin

```

1. Jump near file end

```bash

hexdump -C -s $((0x1000)) -n 128 sample.bin

```

1. Unsigned byte list

```bash

hexdump -v -e '1/1 "%u\n"' sample.bin | head

```

## Input/output patterns

- Input: Binary files and optional range selectors.

- Output: Hex/ASCII text according to canonical or custom formats.

## Troubleshooting quick checks

- If output appears duplicated, remove accidental repeated format terms.

- If offsets look wrong, confirm decimal vs hex arithmetic in shell expansion.

- If custom format output is unreadable, switch back to `-C` to verify baseline.

## When not to use this command

- Do not use `hexdump` when you need symbolic disassembly or section-level semantics.
