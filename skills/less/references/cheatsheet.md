# less Cheatsheet

## High-value options

- `-N`: Show line numbers for reliable references.

- `-S`: Disable wrapping so long lines stay on one row.

- `-R`: Render raw color control sequences safely.

- `+F`: Start in follow mode for live logs.

## Common one-liners

1. Open with line numbers

```bash

less -N app.log

```

1. Jump to the first match

```bash

less +/'ERROR' app.log

```

1. View compressed log stream

```bash

gzip -dc app.log.gz | less -N

```

## Input/output patterns

- Input: Text files or piped text streams (optionally with ANSI color codes).

- Output: Interactive pager session in the terminal.

## Troubleshooting quick checks

- If terminal formatting looks broken after exit, run `reset`.

- If colors are not visible from a pipe, add `-R`.

- If search misses expected matches, confirm case sensitivity and pattern spelling.

## When not to use this command

- Do not use `less` for non-interactive automation or machine-readable output.
