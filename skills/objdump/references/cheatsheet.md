# objdump Cheatsheet

## High-value options

- `-d`: Disassemble executable sections.

- `-D`: Disassemble all sections.

- `-x`: Display all headers.

- `-t`: Symbol table listing.

## Common one-liners

1. Intel syntax disassembly

```bash

objdump -d -M intel ./app | less -S

```

1. Dump section headers

```bash

objdump -h ./app

```

1. Find PLT stubs

```bash

objdump -d ./app | rg '@plt'

```

## Input/output patterns

- Input: Object files, archives, executables, and shared libraries.

- Output: Formatted disassembly and metadata reports.

## Troubleshooting quick checks

- If symbols are unreadable, run `nm -C` or use demangling options where available.

- If output is empty, verify the file contains executable sections.

- If addresses seem odd, confirm binary architecture and PIE settings.

## When not to use this command

- Do not use `objdump` alone for full reverse engineering of heavily optimized binaries.
