# tail Cheatsheet

## High-value options

- `-n <N>`: Print the last N lines.

- `-c <N>`: Print the last N bytes.

- `-f`: Follow appended data.

- `-F`: Follow by filename and retry after rotation.

## Common one-liners

1. Last 10 lines

```bash

tail -n 10 app.log

```

1. Follow with initial context

```bash

tail -n 200 -F app.log

```

1. Byte-level suffix sample

```bash

tail -c 256 blob.bin | xxd

```

## Input/output patterns

- Input: Files (including rotating logs) or stdin streams.

- Output: Trailing lines/bytes, optionally continuous updates in follow mode.

## Troubleshooting quick checks

- If follow mode stops after rotation, switch from `-f` to `-F`.

- If output is too noisy, reduce startup context with smaller `-n`.

- If updates are delayed, verify file writes are line-buffered by the producer.

## When not to use this command

- Do not use `tail` for full history analysis or strict batch extraction.
