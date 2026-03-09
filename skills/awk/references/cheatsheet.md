# awk Cheatsheet

## High-value options

- `-F <SEP>`: Set input field separator.

- `-v key=value`: Pass variables into the script safely.

- `-f <FILE>`: Load awk program from file.

- `BEGIN/END`: Run setup/summary blocks around record processing.

## Common one-liners

1. Count lines per status

```bash

awk '{count[$2]++} END {for (k in count) print k, count[k]}' app.log

```

1. Print with custom output separator

```bash

awk -F, 'BEGIN{OFS="|"} {print $1,$2,$3}' data.csv

```

1. Show line numbers with matches

```bash

awk '/timeout/ {print NR, $0}' app.log

```

## Input/output patterns

- Input: Line-oriented text records from files or stdin.

- Output: Filtered or transformed records, optionally aggregated summaries.

## Troubleshooting quick checks

- If fields look shifted, verify delimiter assumptions (`-F`).

- If numeric comparisons fail, inspect non-numeric characters in source fields.

- If script quoting breaks, move logic to `-f script.awk`.

## When not to use this command

- Do not use `awk` as a full parser for complex JSON, XML, or quoted CSV edge cases.
