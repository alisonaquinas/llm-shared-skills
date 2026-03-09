# readelf Cheatsheet

## High-value options

- `-h`: ELF file header.

- `-S`: Section headers.

- `-l`: Program headers.

- `-Ws`: Symbol table (wide output).

## Common one-liners

1. Dynamic section only

```bash

readelf -d ./libexample.so

```

1. Relocation entries

```bash

readelf -r ./app

```

1. Section names

```bash

readelf -S ./app | rg '\.'

```

## Input/output patterns

- Input: ELF executables, shared objects, object files, or archives.

- Output: Structured textual dumps of ELF metadata tables.

## Troubleshooting quick checks

- If tool reports non-ELF data, verify input with `file` first.

- If symbols are missing, check stripped binaries or alternate symbol sources.

- If output wraps heavily, pipe to `less -S` for horizontal scrolling.

## When not to use this command

- Do not use `readelf` for instruction-level disassembly; use `objdump -d`.
