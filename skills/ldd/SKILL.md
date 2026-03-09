---
name: ldd-command
description: "Inspect dynamic library dependencies with `ldd`. Use when users ask why binaries fail to load shared objects, or need dependency resolution checks."
---

# ldd Command Skill

## Purpose

Use `ldd` to enumerate runtime shared-library dependencies and identify missing links.

## Quick start

```bash

ldd --help

```

## Common workflows

1. List linked shared libraries

```bash

ldd ./app

```

Baseline output reveals resolved library paths and load addresses.

1. Find missing dependencies quickly

```bash

ldd ./app | rg 'not found'

```

Filter for unresolved entries to prioritize fixes.

1. Get verbose version/dependency details

```bash

ldd -v ./app

```

Verbose mode can expose versioned symbol requirements.

## Guardrails

- Avoid running `ldd` on untrusted executables in high-risk environments.

- Remember static binaries may not produce useful dependency lists.

- Capture target environment context since linker paths differ by host/container.

## Reproducibility and reporting

- Record the exact command, flags, input paths, and working directory.

- Capture relevant environment details when they affect behavior (OS, tool version, locale, or shell).

- Summarize key output lines and explicitly note filters, truncation, or assumptions.
