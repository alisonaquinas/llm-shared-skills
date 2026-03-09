---
name: objdump-command
description: "Disassemble and inspect object metadata with `objdump`. Use when users ask for instruction listings, section dumps, or symbol-level binary introspection."
---

# objdump Command Skill

## Purpose

Use `objdump` for disassembly and low-level object inspection across executable formats.

## Quick start

```bash

objdump --help

```

## Common workflows

1. Disassemble executable code sections

```bash

objdump -d ./app | less -S

```

Section-aware disassembly provides address-anchored instruction flow.

1. Inspect headers and section metadata

```bash

objdump -x ./app

```

Header dump is useful for relocation and linkage context.

1. Disassemble with source interleave when debug info exists

```bash

objdump -dS ./app | less -S

```

Source interleave helps map machine code back to source lines.

## Guardrails

- Disassembly can be very large; always scope output or page it through `less`.

- Use architecture-appropriate syntax options (`-M`) when comparing outputs.

- Do not treat disassembly labels as authoritative high-level control flow without validation.

## Reproducibility and reporting

- Record the exact command, flags, input paths, and working directory.

- Capture relevant environment details when they affect behavior (OS, tool version, locale, or shell).

- Summarize key output lines and explicitly note filters, truncation, or assumptions.
