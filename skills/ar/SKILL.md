---
name: ar
description: Manage Unix static library archives for build systems with ar. Use when the agent needs to inspect or modify .a library contents, rebuild symbol tables, or manage object file members.
---

# ar

Create and manage static library archives for C/C++ compilation.

## Quick Start

1. Verify `ar` is available: `ar --version` or `man ar`
2. Establish the command surface: `man ar` or `ar --help`
3. Start with list-only operation: `ar t libexample.a`

## Intent Router

Load only the reference file needed for the active request.

- `references/install-and-setup.md` — Installing ar (GNU binutils) on macOS, Linux, Windows
- `references/cheatsheet.md` — Common operations, member listing, symbol table management
- `references/advanced-usage.md` — Archive format details, symbol handling, GNU vs BSD differences
- `references/troubleshooting.md` — Symbol table issues, member conflicts, build errors

## Core Workflow

1. Verify ar is available: `ar --version`
2. List archive contents (safe, read-only): `ar t libexample.a`
3. Extract specific members if needed: `ar x libexample.a module.o`
4. Rebuild with new members and refresh symbol table: `ar rcs libexample.a module1.o module2.o`

## Quick Command Reference

```bash
ar --version                           # Check version
ar t libexample.a                      # List archive members (contents)
ar tv libexample.a                     # List with details and timestamps
ar x libexample.a                      # Extract all members
ar x libexample.a module.o             # Extract specific member
ar rcs libexample.a module1.o module2.o # Replace/create and rebuild symbol table
ar d libexample.a module.o             # Delete member from archive
ar s libexample.a                      # Rebuild symbol table only
man ar                                 # Full manual and options
```

## Safety Notes

| Area | Guardrail |
| --- | --- |
| **Symbol table** | Always use `s` flag or `rcs` to rebuild symbol table after modifications. Linker depends on accurate index. |
| **Member ordering** | Some linkers depend on member sequence. Verify link order matches expectations after modifications. |
| **Architecture compatibility** | Verify object files target same architecture as archive (32-bit vs 64-bit). Use `file` to check. |
| **Backups** | Create backup before modifying existing archives. Archive damage can break builds. |
| **Member names** | Object file names are limited to 16 characters in archive. Longer names may be truncated. |

## Source Policy

- Treat the installed `ar` behavior and `man ar` as runtime truth.
- Use GNU binutils documentation for GNU ar specifics.

## Resource Index

- `scripts/install.sh` — Install ar (GNU binutils) on macOS or Linux.
- `scripts/install.ps1` — Install ar on Windows or any platform via PowerShell.
