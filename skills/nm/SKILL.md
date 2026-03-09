---
name: nm-command
description: "Inspect symbol tables with `nm` for link/debug analysis. Use when users ask for exported symbols, unresolved references, or symbol visibility checks."
---

# nm Command Skill

## Purpose

Use `nm` to list and analyze symbols in object files, static libs, and binaries.

## Quick start

```bash

nm --help

```

## Common workflows

1. List symbols sorted by address

```bash

nm -n ./app

```

Address-sorted output helps map symbol layout quickly.

1. Demangle C++ symbol names

```bash

nm -C ./libexample.a | head -n 80

```

Demangling improves readability for templated names.

1. Show undefined symbols only

```bash

nm -u ./module.o

```

Undefined symbol lists are key for linkage troubleshooting.

## Guardrails

- Use demangling (`-C`) when reporting C++ symbols to reduce ambiguity.

- Different binary types expose different symbol subsets; note file type in reports.

- Undefined symbol findings should be correlated with linkage flags and dependency order.

## Reproducibility and reporting

- Record the exact command, flags, input paths, and working directory.

- Capture relevant environment details when they affect behavior (OS, tool version, locale, or shell).

- Summarize key output lines and explicitly note filters, truncation, or assumptions.
