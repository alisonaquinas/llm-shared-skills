# tree Cheatsheet

## High-value options

- `-L <N>`: Limit recursion depth.

- `-d`: Show directories only.

- `-a`: Include dotfiles and hidden entries.

- `-I <PATTERN>`: Exclude matching paths.

## Common one-liners

1. Two-level map

```bash

tree -L 2

```

1. Directory-only map

```bash

tree -d src

```

1. Include hidden files

```bash

tree -a -L 2

```

## Input/output patterns

- Input: A directory path and optional filter/depth flags.

- Output: Formatted hierarchical listing to stdout.

## Troubleshooting quick checks

- If output is too large, lower `-L` or tighten `-I` patterns.

- If hidden files are missing, add `-a`.

- If path names appear truncated in narrow terminals, redirect output to a file.

## When not to use this command

- Do not use `tree` when exact metadata extraction is required; use `find` or `stat` pipelines.
