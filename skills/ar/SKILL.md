---
name: ar-command
description: "Manage Unix static archives with `ar`. Use when users ask to inspect `.a` contents, add/remove object members, or repair archive symbol indexes."
---

# ar Command Skill

## Purpose

Use `ar` to create, inspect, and update static library archive members.

## Quick start

```bash

ar --help

```

## Common workflows

1. List archive members

```bash

ar t libexample.a

```

Start by enumerating objects before making changes.

1. Extract a specific member

```bash

ar x libexample.a module.o

```

Extraction supports isolated symbol/debug inspection.

1. Create or replace archive contents

```bash

ar rcs libexample.a module1.o module2.o

```

Use `rcs` to add members and refresh index in one step.

## Guardrails

- Rebuild the symbol index (`s` flag) after modifying archives.

- Preserve member ordering when linkers depend on archive sequence.

- Verify architecture compatibility of inserted object files.

## Reproducibility and reporting

- Record the exact command, flags, input paths, and working directory.

- Capture relevant environment details when they affect behavior (OS, tool version, locale, or shell).

- Summarize key output lines and explicitly note filters, truncation, or assumptions.
