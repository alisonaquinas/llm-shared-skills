# binwalk Cheatsheet

## High-value options

- `-e`: Extract known embedded files automatically.

- `-M`: Recursively scan extracted files.

- `-E`: Compute and display entropy analysis.

- `-y <TYPE>`: Include only specified signature types.

## Common one-liners

1. Recursive extraction

```bash

binwalk -eM firmware.bin

```

1. Only squashfs signatures

```bash

binwalk -y squashfs firmware.bin

```

1. Custom signature scan

```bash

binwalk -R '\x50\x4b\x03\x04' firmware.bin

```

## Input/output patterns

- Input: Firmware images or binary blobs.

- Output: Signature tables, entropy data, and optional extracted artifact directories.

## Troubleshooting quick checks

- If no signatures are found, verify sample integrity and expected format.

- If extraction fails, check required external extractors/dependencies.

- If many false positives appear, narrow signature classes with `-y` filters.

## When not to use this command

- Do not use `binwalk` as a malware verdict engine; it is a signature-oriented triage tool.
