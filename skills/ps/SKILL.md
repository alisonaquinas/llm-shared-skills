---
name: ps
description: >
  Inspect running processes with ps for monitoring, debugging, and process
  management. Use when the agent needs to list processes, find a process by
  name or PID, inspect resource usage, show parent-child relationships, or
  identify the owner of a running process before killing or signalling it.
---

# ps

Display information about active processes for monitoring and debugging.

## Quick Start

1. Verify availability: `ps --version` (GNU) or `ps -V`
2. List all processes: `ps aux`
3. Search for a specific process: `ps aux | grep <name>`

## Intent Router

- `references/cheatsheet.md` — Common invocations, BSD vs POSIX syntax, column meanings, and filtering
- `references/advanced-usage.md` — Custom output formats, sorting, parent-child trees, combining with kill/grep, and scripting
- `references/troubleshooting.md` — Zombie processes, permission limitations, macOS vs Linux differences, and high-load interpretation

## Core Workflow

1. Run `ps aux` for a broad snapshot of all running processes
2. Pipe through `grep` to isolate processes by name or command
3. Use `ps -p <PID>` to inspect a specific known process
4. Use `ps --forest` or `ps -ejH` to visualise parent-child trees
5. Check UID/USER and PPID before taking any action on a process

## Quick Command Reference

```bash
ps aux                          # All processes, BSD-style (user, PID, CPU, MEM, command)
ps -ef                          # All processes, POSIX-style (UID, PID, PPID, time, command)
ps aux | grep nginx             # Find processes matching a name
ps -p 1234                      # Details for a specific PID
ps -u alice                     # Processes owned by a specific user
ps aux --sort=-%mem             # Sort by memory usage descending (GNU)
ps aux --sort=-%cpu             # Sort by CPU usage descending (GNU)
ps --forest                     # ASCII tree of parent-child relationships (GNU)
ps -ejH                         # Hierarchical process tree (POSIX-compatible)
ps -o pid,ppid,user,stat,cmd    # Custom output columns
ps -C nginx                     # Processes with a specific command name (GNU)
man ps                          # Full manual
```

## Safety Notes

| Area | Guardrail |
| --- | --- |
| **Read-only** | `ps` never modifies processes. All listings are safe to run. |
| **Before killing** | Always confirm PID, owner, and command string before passing output to `kill`. A wrong PID can terminate critical system processes. |
| **grep false matches** | `ps aux | grep foo` will match the `grep foo` process itself. Use `grep -v grep` or `pgrep foo` to filter it out. |
| **Snapshot timing** | `ps` captures a point-in-time snapshot. Short-lived processes may not appear. Use `top` or `htop` for continuous monitoring. |
| **macOS vs Linux** | macOS uses BSD `ps`. Column names and some flags differ. `--forest` and `--sort` are GNU-only. Use `pstree` or Activity Monitor on macOS for trees. |
| **Permissions** | Non-root users may see truncated command lines for processes owned by other users. |

## Source Policy

- Treat `man ps` as runtime truth. BSD and GNU ps have divergent flag sets.
- Use `pgrep` and `pkill` for scripted process lookup and signalling — they are safer than parsing `ps` output.
- Never embed PIDs from `ps` output in automation without re-validating them first.

## See Also

- `$kill` / `pkill` / `pgrep` for sending signals to processes
- `top` / `htop` for continuous real-time process monitoring
- `lsof` for per-process file and network descriptor listings
