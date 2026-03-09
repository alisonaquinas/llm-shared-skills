# diff Cheatsheet

## High-value options

- `-u`: Unified diff format with context lines.

- `-r`: Recurse through directories.

- `-w`: Ignore all whitespace changes.

- `-N`: Treat absent files as empty during directory diffs.

## Common one-liners

1. Three-line context diff

```bash

diff -U 3 old.cfg new.cfg

```

1. Side-by-side comparison

```bash

diff -y old.txt new.txt

```

1. Exclude matching lines

```bash

diff -u a.txt b.txt | sed '/^ /d'

```

## Input/output patterns

- Input: Two files or directory roots to compare.

- Output: Difference report with exit status indicating equality vs difference.

## Troubleshooting quick checks

- If output is huge, narrow scope to specific files first.

- If file ordering differs, normalize sorted inputs before diffing generated lists.

- If binary notice appears, switch to binary-aware tooling.

## When not to use this command

- Do not use `diff` for semantic-aware code analysis where AST-aware tools are required.
