---
name: wget
description: >
  Retrieve files and sites non-interactively with wget for single downloads,
  resumable transfers, recursive retrieval, mirroring, timestamping, rate limiting,
  cookies, authentication, and download safety. Use when the agent needs to fetch
  files to disk, mirror a site section, resume partial downloads, preserve timestamps,
  constrain recursive scope, or troubleshoot certificate, redirect, and crawl behavior
  from the command line.
---

# wget

Retrieve files and site content non-interactively with controlled local writes.

## Quick Start

1. Verify `wget` is available: `wget --version`
2. Establish the command surface: `wget --help` or `man wget`
3. Start with a read-only check: `wget --spider https://example.com/file.tar.gz`

## Intent Router

Load only the reference file needed for the active request.

- `references/install-and-setup.md` — Installing wget and verifying runtime behavior
- `references/cheatsheet.md` — Common download flags, naming, resume, timestamping, and rate control
- `references/advanced-usage.md` — Recursive download, mirroring, accept and reject patterns, domain limits, and politeness controls
- `references/troubleshooting.md` — Permission failures, partial downloads, TLS, auth, cookies, and runaway recursion recovery

## Core Workflow

1. Verify the installed build: `wget --version`
2. Probe the target with `--spider` before writing files or crawling recursively
3. Set an explicit destination policy with `--output-document`, `--directory-prefix`, or `--no-clobber`
4. Add safety controls for larger jobs: `--continue`, `--timestamping`, `--limit-rate`, `--domains`, `--no-parent`
5. Review logs and server responses with `--server-response`, `--output-file`, or `--debug` when behavior is unclear

## Quick Workflows

### Read-only availability probe

```bash
wget --spider https://example.com/file.tar.gz
```

### Resumable file download

```bash
wget --continue --output-document artifact.tar.gz https://example.com/file.tar.gz
```

### Scoped recursive mirror

```bash
wget --mirror --no-parent --domains example.com https://example.com/docs/
```

## Quick Command Reference

```bash
wget --version
wget --spider https://example.com/file.tar.gz
wget --output-document artifact.tar.gz https://example.com/file.tar.gz
wget --continue --output-document artifact.tar.gz https://example.com/file.tar.gz
wget --timestamping https://example.com/releases/tool.zip
wget --directory-prefix downloads https://example.com/file.tar.gz
wget --limit-rate=500k --wait=1 https://example.com/file.tar.gz
wget --mirror --no-parent --domains example.com https://example.com/docs/
wget --save-cookies cookies.txt --keep-session-cookies https://example.com/login
man wget
```

## Safety Notes

| Area | Guardrail |
| --- | --- |
| **Initial probe** | Use `--spider` before writing files or starting recursive jobs. |
| **Destination control** | Set output file or directory explicitly to avoid accidental overwrites or writes in the wrong path. |
| **Resume behavior** | Use `--continue` only when resuming the same remote object into the same local file. |
| **Timestamping** | Prefer `--timestamping` for repeat downloads that should skip unchanged content. |
| **Recursive scope** | Pair recursion with `--domains`, `--no-parent`, and sensible depth controls to prevent runaway crawls. |
| **Rate limits** | Use `--limit-rate`, `--wait`, and `--random-wait` for polite bulk retrieval. |
| **Secrets** | Avoid inline passwords and cookie disclosure in shared terminals or logs. |
| **TLS verification** | Keep certificate validation enabled. Use `--no-check-certificate` only for a temporary diagnostic check. |

## Scope Boundary

This skill does not cover fine-grained API request construction or response formatting. Use `curl` for those workflows.

## Source Policy

- Treat the installed `wget` behavior and `wget --help` or `man wget` as runtime truth.
- Use `wget --version` to confirm TLS support, feature flags, and platform-specific behavior.
- Validate recursive and mirroring guidance against the GNU Wget manual before documenting it.
- Document recursion and write behavior explicitly so download scope is reproducible.

## Resource Index

- `scripts/install.sh` — Install wget on macOS or Linux.
- `scripts/install.ps1` — Install wget on Windows or any platform via PowerShell.
