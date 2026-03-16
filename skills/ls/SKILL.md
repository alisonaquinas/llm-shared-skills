---
name: ls
description: >
  List directory contents with ls for exploring file systems, inspecting
  permissions, ownership, sizes, timestamps, and hidden files. Use when the
  agent needs to survey what exists in a directory, check file attributes,
  sort by time or size, or feed a file list into a pipeline.
---

# ls

List directory contents with flexible formatting, sorting, and filtering.

## Quick Start

1. Verify availability: `ls --version` (GNU) or `ls --help`
2. List current directory: `ls`
3. Long listing with hidden files: `ls -lah`

## Intent Router

- `references/cheatsheet.md` — Common flags, long listing, hidden files, sorting, and output formats
- `references/advanced-usage.md` — Recursive listing, combining with pipelines, GNU vs BSD differences, scripting patterns
- `references/troubleshooting.md` — Color issues, broken symlinks, special characters in filenames, cross-platform differences

## Core Workflow

1. Start with a plain `ls` to survey the directory
2. Add `-l` for permissions, ownership, size, and timestamp
3. Add `-a` to include hidden (dot) files
4. Add `-h` to make sizes human-readable
5. Sort by time (`-t`), size (`-S`), or reverse (`-r`) as needed
6. Verify paths before acting on listed files

## Quick Command Reference

```bash
ls                          # List current directory
ls -l                       # Long format: permissions, owner, size, date
ls -a                       # Include hidden files (dotfiles)
ls -lah                     # Long, all files, human-readable sizes
ls -lt                      # Sort by modification time, newest first
ls -lS                      # Sort by size, largest first
ls -ltr                     # Sort by time, oldest first (useful for logs)
ls -R                       # Recursive listing
ls -1                       # One entry per line (good for pipelines)
ls -d */                    # List directories only
ls -lh *.log                # Long listing filtered by glob
ls --color=auto             # Colorised output (GNU only)
man ls                      # Full manual
```

## Safety Notes

| Area | Guardrail |
| --- | --- |
| **Read-only** | `ls` never modifies files. It is safe to run in any directory. |
| **Glob expansion** | Shell globs expand before `ls` sees them. Unexpected matches can list unintended files. Quote globs when passing to scripts. |
| **Broken symlinks** | `ls -l` shows symlink targets; broken links display in red (with `--color`) but do not cause errors by default. |
| **Special characters** | Filenames with spaces or newlines can break pipelines. Use `ls -1` combined with `find -print0` / `xargs -0` for robust scripting. |
| **GNU vs BSD** | macOS ships BSD `ls`. Many GNU flags (`--color`, `--group-directories-first`) are unavailable. Use `gls` (from coreutils) on macOS for GNU behaviour. |

## Source Policy

- Treat `man ls` and `ls --help` as runtime truth for available flags.
- Check `ls --version` to confirm GNU vs BSD variant before using GNU-only flags.
- For reliable scripting over arbitrary filenames, prefer `find` with `-print0` over `ls` output parsing.

## See Also

- `$find` for recursive file location and `-exec` pipelines
- `$tree` for visual directory hierarchy display
- `$stat` for detailed per-file metadata
