# wget Cheatsheet

## High-value options

- `--spider`: Check reachability without downloading the body.
- `--output-document=<file>`: Save to a specific local file.
- `--directory-prefix=<dir>`: Save into a specific directory tree.
- `--continue`: Resume a partial download.
- `--timestamping`: Skip downloads when the local file is current.
- `--no-clobber`: Avoid overwriting existing files.
- `--limit-rate=<rate>`: Cap transfer rate.
- `--wait=<seconds>`: Pause between retrievals.
- `--mirror`: Mirror a tree with recursive defaults.
- `--no-parent`: Prevent climbing above the starting directory.
- `--domains=<list>`: Restrict recursive downloads to allowed domains.

## Common one-liners

1. Probe before download

```bash
wget --spider https://example.com/file.tar.gz
```

1. Download to a specific file

```bash
wget --output-document artifact.tar.gz https://example.com/file.tar.gz
```

1. Resume a partial download

```bash
wget --continue --output-document artifact.tar.gz https://example.com/file.tar.gz
```

1. Save into a directory

```bash
wget --directory-prefix downloads https://example.com/file.tar.gz
```

1. Skip unchanged files

```bash
wget --timestamping https://example.com/releases/tool.zip
```

1. Polite bulk retrieval

```bash
wget --limit-rate=500k --wait=1 --random-wait https://example.com/file.tar.gz
```

1. Recursive mirror with scope controls

```bash
wget --mirror --no-parent --domains example.com https://example.com/docs/
```

## Input and output patterns

- Input: URL list, input files, or recursive traversal from a starting URL
- Output: Files written to disk plus console or log output

## Logging and inspection

```bash
wget --server-response --output-file wget.log https://example.com/file.tar.gz

wget --debug --output-file wget-debug.log https://example.com/file.tar.gz
```

## Troubleshooting quick checks

- If nothing downloads, start with `--spider`.
- If files overwrite unexpectedly, add `--output-document`, `--directory-prefix`, or `--no-clobber`.
- If recursion runs too wide, add `--domains`, `--no-parent`, and depth controls.
- If HTTPS fails, check CA configuration before using `--no-check-certificate`.

## When not to use this command

- Do not use `wget` when the main task is fine-grained API request construction. Use `curl` instead.
- Do not start recursive downloads without explicit scope limits.
