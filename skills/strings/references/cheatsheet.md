# strings Cheatsheet

## High-value options

- `-n <N>`: Minimum string length to report.

- `-t x`: Show string offsets in hexadecimal.

- `-a`: Scan entire file instead of data sections only.

- `-e <ENC>`: Decode using specific character encoding mode.

## Common one-liners

1. Find URLs

```bash

strings sample.bin | rg 'https?://'

```

1. Find likely secrets

```bash

strings -n 12 app.bin | rg -i 'token|key|secret'

```

1. Offsets plus grep

```bash

strings -t x app.bin | rg -i 'error|warn'

```

## Input/output patterns

- Input: Binary files or memory dump artifacts.

- Output: Printable character sequences, optionally prefixed with offsets.

## Troubleshooting quick checks

- If output is empty, lower `-n` or verify file is not encrypted/compressed.

- If output is noisy, raise `-n` and filter with `rg`.

- If needed strings are missing, try encoding variants with `-e`.

## When not to use this command

- Do not use `strings` as a replacement for disassembly or structured binary parsing.
