---
name: ssh-keygen-command
description: "Generate, import, and fingerprint SSH keys with secure file permissions."
category: command
version: 1.0.0
requires_git: true
safety_tier: moderate
execution_mode: mutating
labels:
  - ssh
  - credentials
  - security
---

# ssh-keygen Command Skill

## Purpose

Use `ssh-keygen` to create, validate, and fingerprint SSH keypairs safely.

## Quick start

```bash
ssh-keygen -h
```

## Common workflows

1. Generate an Ed25519 key

```bash
ssh-keygen -t ed25519 -f ~/.ssh/id_ed25519 -N "" -C "agent@ai-thinking-cap"
chmod 600 ~/.ssh/id_ed25519
chmod 644 ~/.ssh/id_ed25519.pub
```

Always enforce strict private-key permissions.

1. Inspect key fingerprint

```bash
ssh-keygen -lf ~/.ssh/id_ed25519.pub
```

Fingerprints are used for key registration and verification.

1. Derive public key from private key

```bash
ssh-keygen -y -f ~/.ssh/id_ed25519 > ~/.ssh/id_ed25519.pub
```

Derivation helps recover missing public keys without regenerating secrets.
