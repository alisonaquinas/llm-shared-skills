# ar Cheatsheet

## High-value options

- `t`: List archive table of contents.

- `x`: Extract members from archive.

- `r`: Insert or replace members.

- `s`: Write/update symbol index.

## Common one-liners

1. Delete member

```bash

ar d libexample.a obsolete.o

```

1. Print member to stdout

```bash

ar p libexample.a module.o | head

```

1. List with verbose metadata

```bash

ar tv libexample.a

```

## Input/output patterns

- Input: Archive file plus operation flags and object member paths.

- Output: Archive updates, member listings, or extracted files.

## Troubleshooting quick checks

- If linker cannot find symbols, confirm index refresh via `ar s` or `ranlib`.

- If extraction fails, verify exact member name with `ar t`.

- If archive is rejected, ensure object files share compatible format/arch.

## When not to use this command

- Do not use `ar` for compressed distribution archives; use `tar`, `zip`, or `7z`.
