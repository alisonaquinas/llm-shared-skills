# ldd Cheatsheet

## High-value options

- `-v`: Verbose dependency and version information.

- `-r`: Relocation check and symbol resolution.

- `-u`: Show unused direct dependencies.

- `--version`: Print ldd version information.

## Common one-liners

1. Missing libs only

```bash

ldd ./app | rg 'not found'

```

1. Sorted library list

```bash

ldd ./app | sort

```

1. Batch scan executables

```bash

find bin -type f -perm -111 -maxdepth 1 -exec ldd {} +

```

## Input/output patterns

- Input: Dynamically linked ELF binaries or shared objects.

- Output: Resolved and unresolved runtime dependency mappings.

## Troubleshooting quick checks

- If output says "not a dynamic executable", verify static linking.

- If libs are missing, inspect `LD_LIBRARY_PATH` and loader cache configuration.

- If symbols fail at runtime, run `ldd -r` for relocation diagnostics.

## When not to use this command

- Do not use `ldd` as a static security scanner for arbitrary untrusted binaries.
