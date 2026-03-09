---
name: tree-command
description: "Render directory trees with `tree` for fast structure audits. Use when users ask for hierarchical file overviews, depth-limited snapshots, or ignore-pattern directory reports."
---

# tree Command Skill

## Purpose

Use `tree` to visualize directory hierarchy with controllable depth, filters, and metadata.

## Quick start

```bash

tree --help

```

## Common workflows

1. Generate a shallow project map

```bash

tree -L 2

```

Depth limiting keeps output readable on large repositories.

1. Show directories only

```bash

tree -d -L 3

```

Useful for architecture overviews without file noise.

1. Exclude build artifacts

```bash

tree -I 'node_modules|dist|.git'

```

Use ignore patterns to focus on source assets.

## Guardrails

- Always bound depth (`-L`) on large trees to avoid excessive output.

- Use `-I` to suppress generated directories that can drown relevant structure.

- Do not treat `tree` output as authoritative permissions/ownership audit data.

## Reproducibility and reporting

- Record the exact command, flags, input paths, and working directory.

- Capture relevant environment details when they affect behavior (OS, tool version, locale, or shell).

- Summarize key output lines and explicitly note filters, truncation, or assumptions.
