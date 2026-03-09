---
name: openssl-command
description: "Handle cryptographic operations with `openssl` CLI subcommands. Use when users ask for certificate inspection, hashing, key conversion, or TLS diagnostics."
---

# openssl Command Skill

## Purpose

Use `openssl` for certificate, hashing, random, and TLS troubleshooting tasks with explicit subcommands.

## Quick start

```bash

openssl help

```

## Common workflows

1. Inspect certificate metadata

```bash

openssl x509 -in cert.pem -noout -text

```

Detailed certificate fields help verify issuer, SAN, and validity.

1. Compute SHA-256 digest for a file

```bash

openssl dgst -sha256 artifact.bin

```

Digest output is useful for integrity verification records.

1. Generate cryptographically strong random bytes

```bash

openssl rand -hex 32

```

Use explicit lengths and encoding for deterministic outputs.

## Guardrails

- Never expose private keys or passphrases in logs or terminal history.

- State algorithm choices explicitly (`-sha256`, key sizes, curves).

- Validate certificate trust chains separately from simple field inspection.

## Reproducibility and reporting

- Record the exact command, flags, input paths, and working directory.

- Capture relevant environment details when they affect behavior (OS, tool version, locale, or shell).

- Summarize key output lines and explicitly note filters, truncation, or assumptions.
