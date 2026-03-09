# head Cheatsheet

## High-value options

- `-n <N>`: Print the first N lines.

- `-c <N>`: Print the first N bytes.

- `-q`: Suppress file name headers when reading multiple files.

- `-v`: Always show file name headers.

## Common one-liners

1. Top 5 lines

```bash

head -n 5 README.md

```

1. First kilobyte

```bash

head -c 1024 sample.dat > prefix.bin

```

1. Quiet multi-file preview

```bash

head -q -n 2 config/*.conf

```

## Input/output patterns

- Input: Regular files, globbed file lists, or stdin streams.

- Output: A truncated prefix of lines or bytes to stdout.

## Troubleshooting quick checks

- If output includes unwanted file headers, add `-q`.

- If byte output appears garbled, pipe through `xxd` for hex view.

- If no output appears, confirm the file has enough lines/bytes for requested limits.

## When not to use this command

- Do not use `head` when tailing live updates or when full-file analysis is required.
