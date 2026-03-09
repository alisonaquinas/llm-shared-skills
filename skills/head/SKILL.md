---
name: head-command
description: "Read leading lines or bytes with `head` using explicit limits. Use when users ask to sample large files quickly, validate headers, or preview stream prefixes."
---

# head Command Skill

## Purpose

Use `head` to quickly inspect the beginning of files or streams without loading full content.

## Quick start

```bash

head --help

```

## Common workflows

1. Preview the first 20 lines of a file

```bash

head -n 20 server.log

```

Use explicit `-n` values instead of defaults to make output intent clear.

1. Inspect the first bytes of a binary payload

```bash

head -c 64 payload.bin | xxd

```

Combining with `xxd` makes byte prefixes human-readable.

1. Compare first lines across many files

```bash

head -n 1 logs/*.log

```

Useful for checking headers or timestamp format consistency.

## Guardrails

- Always specify `-n` or `-c` explicitly in automation to avoid ambiguity.

- Use `-q` or `-v` intentionally when reading multiple files so headers are predictable.

- Do not treat `head` output as representative of full-file distributions without stating that limitation.

## Reproducibility and reporting

- Record the exact command, flags, input paths, and working directory.

- Capture relevant environment details when they affect behavior (OS, tool version, locale, or shell).

- Summarize key output lines and explicitly note filters, truncation, or assumptions.
