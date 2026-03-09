# od Cheatsheet

## High-value options

- `-A x`: Display offsets in hexadecimal.

- `-t x1`: Format as single-byte hexadecimal values.

- `-N <LEN>`: Read only LEN bytes.

- `-j <OFF>`: Skip OFF bytes before reading.

## Common one-liners

1. Hex bytes from offset

```bash

od -Ax -tx1 -j 512 -N 64 sample.bin

```

1. Unsigned shorts

```bash

od -An -tu2 -N 32 sample.bin

```

1. Character dump

```bash

od -An -tc -N 80 sample.bin

```

## Input/output patterns

- Input: Binary or text files plus type/range options.

- Output: Numeric or character dumps with configurable offset base.

## Troubleshooting quick checks

- If values look incorrect, verify type width in `-t`.

- If offsets appear odd, check whether address radix (`-A`) matches expectations.

- If output is too verbose, reduce with `-N` and increase selectivity.

## When not to use this command

- Do not use `od` when a canonical hex + ASCII layout (`hexdump -C` or `xxd`) is easier for reviewers.
