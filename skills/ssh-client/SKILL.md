---
name: ssh-client-command
description: "Use OpenSSH client tools for strict host verification, connectivity checks, and known_hosts management."
category: command
version: 1.0.0
requires_git: true
safety_tier: moderate
execution_mode: mutating
labels:
  - ssh
  - git
  - security
---

# ssh Client Command Skill

## Purpose

Use `ssh`, `ssh-keyscan`, and host-key workflows to establish secure Git-over-SSH connectivity.

## Quick start

```bash
ssh -V
```

## Common workflows

1. Add host keys before first SSH connection

```bash
ssh-keyscan -p 22 github.com >> ~/.ssh/known_hosts
chmod 600 ~/.ssh/known_hosts
```

Host keys should be captured before cloning over SSH.

1. Probe strict SSH connectivity

```bash
ssh -o BatchMode=yes -o StrictHostKeyChecking=yes git@github.com
```

Strict host checking prevents silent trust-on-first-use behavior.

1. Debug authentication and host verification

```bash
ssh -vvv -o StrictHostKeyChecking=yes git@github.com
```

Verbose logs help isolate key, agent, and trust issues.
