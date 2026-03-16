---
name: mv
description: >
  Move or rename files and directories with mv. Use when the agent needs to
  rename a file or directory in place, relocate files to a different directory,
  reorganise a directory tree, or safely replace a destination file with an
  atomic move on the same filesystem.
---

# mv

Move or rename files and directories, with control over overwrite behaviour
and backup creation.

## Quick Start

1. Verify availability: `mv --version` (GNU) or `man mv`
2. Rename a file: `mv old-name.txt new-name.txt`
3. Move to a directory: `mv file.txt /target/dir/`

## Intent Router

- `references/cheatsheet.md` — Rename, move single and multiple files, overwrite control, verbose mode
- `references/advanced-usage.md` — Atomic replacement, backup suffixes, cross-filesystem behaviour, moving directory trees
- `references/troubleshooting.md` — Cross-filesystem errors, permission denied, destination-exists edge cases

## Core Workflow

1. Confirm source path and destination before running — `mv` is not undoable without a backup
2. Use `-i` (interactive) to prompt before overwriting, or `-n` to refuse to overwrite
3. Use `-v` to confirm each move in batch operations
4. For cross-filesystem moves, be aware that `mv` falls back to a copy-then-delete internally
5. Verify result with `ls -l` on the destination

## Quick Command Reference

```bash
mv old.txt new.txt                  # Rename a file in place
mv file.txt /target/dir/            # Move file to directory
mv file.txt /target/dir/new.txt     # Move and rename in one step
mv -i source.txt dest.txt           # Prompt before overwriting
mv -n source.txt dest.txt           # Never overwrite an existing destination
mv -v *.log /archive/               # Verbose: print each file moved
mv -b source.txt dest.txt           # Back up destination before overwriting
mv --backup=numbered src dest       # Numbered backups (GNU)
mv dir/ /new/parent/                # Move entire directory
man mv                              # Full manual
```

## Safety Notes

| Area | Guardrail |
| --- | --- |
| **Irreversible by default** | Unlike `cp`, `mv` removes the source. There is no built-in undo. Verify destination before running, especially in scripts. |
| **Silent overwrite** | `mv` overwrites the destination without warning by default. Use `-i` interactively or `-n` in scripts to prevent accidental data loss. |
| **Cross-filesystem** | When source and destination are on different filesystems, `mv` performs a copy-then-delete. If interrupted, data can be left in both or neither location. Use `rsync` with `--remove-source-files` for safer cross-filesystem moves. |
| **Directory trailing slash** | `mv src dest` where `dest` is an existing directory moves `src` *inside* `dest`. Omit the trailing slash or check with `test -d dest` to confirm intent. |
| **Root-owned files** | Moving files you do not own requires elevated privileges. Prefer `sudo mv` only after confirming the operation. |

## Source Policy

- Treat `man mv` and `mv --help` as runtime truth. GNU and BSD `mv` differ slightly.
- For large or cross-filesystem moves where atomicity matters, use `rsync --remove-source-files`.
- In scripts, check exit code and destination before deleting any backup.

## See Also

- `$cp` for copying without removing the source
- `$rsync` for resumable, cross-filesystem, or verified moves
- `$ln` for aliasing instead of relocating
