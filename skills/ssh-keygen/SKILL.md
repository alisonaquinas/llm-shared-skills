---
name: ssh-keygen
description: Generate and manage SSH key pairs with fingerprinting and validation. Use when the agent needs to create SSH credentials, verify key identity, or manage key lifecycle.
---

# ssh-keygen

Generate, validate, and fingerprint SSH keypairs with secure file permissions.

## Quick Start

1. Verify `ssh-keygen` is available: `ssh-keygen -h` or `man ssh-keygen`
2. Establish the command surface: `man ssh-keygen` or `ssh-keygen -h`
3. Start with key generation: `ssh-keygen -t ed25519 -f ~/.ssh/id_ed25519`

## Intent Router

Load only the reference file needed for the active request.

- `references/install-and-setup.md` — Installing OpenSSH on macOS, Linux, Windows
- `references/cheatsheet.md` — Key generation, fingerprinting, key formats
- `references/advanced-usage.md` — Key types (RSA, ECDSA, Ed25519), key conversion, signing
- `references/troubleshooting.md` — Permission errors, key corruption, format issues

## Core Workflow

1. Verify ssh-keygen is available: `ssh-keygen -h`
2. Generate keypair: `ssh-keygen -t ed25519 -f ~/.ssh/id_ed25519 -N passphrase`
3. Set correct permissions: `chmod 600 ~/.ssh/id_ed25519` and `chmod 644 ~/.ssh/id_ed25519.pub`
4. Fingerprint key: `ssh-keygen -lf ~/.ssh/id_ed25519.pub`

## Quick Command Reference

```bash
ssh-keygen -h                          # Show help
ssh-keygen -t ed25519 -f ~/.ssh/id    # Generate Ed25519 key
ssh-keygen -lf ~/.ssh/id.pub          # Show key fingerprint
ssh-keygen -y -f ~/.ssh/id            # Derive public key from private
ssh-keygen -p -f ~/.ssh/id            # Change key passphrase
ssh-keygen -R hostname                # Remove hostname from known_hosts
man ssh-keygen                        # Full manual
```

## Safety Notes

| Area | Guardrail |
| --- | --- |
| **Key permissions** | Private keys must be chmod 600. SSH refuses keys with wrong permissions. Public keys chmod 644. |
| **Key type** | Use Ed25519 (modern, secure, compact). Avoid RSA unless legacy required. Never use DSA. |
| **Passphrase** | Protect keys with strong passphrase. Use ssh-agent to avoid repeated password entry. |
| **Key storage** | Store private keys in secure location (~/.ssh/). Never commit to version control. |
| **Fingerprinting** | Always verify fingerprints when registering public keys on servers. Prevents key substitution. |
| **Key recovery** | Keep secure backup of private keys. Loss means regeneration and server updates. |

## Source Policy

- Treat the installed `ssh-keygen` behavior and `man ssh-keygen` as runtime truth.
- Use OpenSSH documentation for key management best practices.

## Resource Index

- `scripts/install.sh` — Install OpenSSH on macOS or Linux.
- `scripts/install.ps1` — Install OpenSSH on Windows or any platform via PowerShell.
