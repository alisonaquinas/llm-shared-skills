# nm Cheatsheet

## High-value options

- `-n`: Sort symbols numerically by address.

- `-C`: Demangle C++ names.

- `-u`: Show undefined symbols only.

- `-D`: Show dynamic symbols for shared objects.

## Common one-liners

1. Global symbols only

```bash

nm -g ./libexample.a

```

1. Dynamic symbol grep

```bash

nm -D ./libexample.so | rg 'openssl|ssl'

```

1. Undefined refs in archive members

```bash

nm -u libfoo.a | sort -u

```

## Input/output patterns

- Input: Object files, archives, executables, and shared libraries.

- Output: Symbol listings with type codes and addresses.

## Troubleshooting quick checks

- If no symbols appear, the binary may be stripped.

- If mangled names are unreadable, add `-C`.

- If undefined symbols persist, inspect linker order and transitive dependencies.

## When not to use this command

- Do not use `nm` as a replacement for runtime dependency resolution checks (`ldd`).
