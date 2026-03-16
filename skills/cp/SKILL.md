---
name: cp
description: >
  Copy files and directories with cp for duplicating, backing up, and
  distributing content. Use when the agent needs to copy a single file,
  recursively copy a directory tree, preserve metadata and permissions,
  avoid overwriting newer files, or create a backup before modifying the
  original.
---

# cp

Copy files and directories with control over overwrite behaviour, metadata
preservation, and backup creation.

## Quick Start

1. Verify availability: `cp --version` (GNU) or `man cp`
2. Copy a file: `cp source.txt destination.txt`
3. Recursively copy a directory: `cp -r src/ dest/`

## Intent Router

- `references/cheatsheet.md` — Common flags, recursive copy, metadata preservation, overwrite control
- `references/advanced-usage.md` — Archive mode, backup suffixes, sparse files, reflinks, progress reporting
- `references/troubleshooting.md` — Permission errors, cross-filesystem issues, symlink handling, silent overwrites

## Core Workflow

1. Confirm source path and destination intent before running
2. Use `-i` (interactive) or `-n` (no-clobber) to protect against silent overwrites
3. Use `-r` for directories; add `-a` (archive) to also preserve permissions, timestamps, and symlinks
4. Verify the copy with `diff` or `ls -l` on both sides
5. Clean up the original only after confirming the copy is intact

## Quick Command Reference

```bash
cp source.txt dest.txt              # Copy a single file
cp -r src/ dest/                    # Recursively copy directory
cp -a src/ dest/                    # Archive: preserves permissions, times, symlinks
cp -i source.txt dest.txt           # Prompt before overwriting
cp -n source.txt dest.txt           # Never overwrite existing files
cp -u source.txt dest.txt           # Copy only when source is newer
cp -v source.txt dest.txt           # Verbose: print each file copied
cp -p source.txt dest.txt           # Preserve mode, ownership, timestamps
cp --backup=numbered source.txt d/  # Create numbered backups of overwritten files
cp -r --preserve=all src/ dest/     # Copy tree preserving all metadata (GNU)
man cp                              # Full manual
```

## Safety Notes

| Area | Guardrail |
| --- | --- |
| **Silent overwrite** | By default `cp` overwrites the destination without warning. Use `-i` interactively or `-n` in scripts to prevent data loss. |
| **Directory trailing slash** | `cp -r src dest` behaves differently depending on whether `dest` exists. If `dest` exists, `src` is copied *inside* it. If not, `dest` is created as the copy. Verify intent before running. |
| **Permissions** | Without `-p` or `-a`, copied files inherit the umask of the current process. Use `-a` or `--preserve` when permissions must match the source. |
| **Symlinks** | By default `cp` follows symlinks and copies the referenced file. Use `-P` (or `-d`) to copy the symlink itself. |
| **Cross-filesystem** | Hardlinks are silently converted to copies. Use `rsync -aH` to preserve hardlinks across filesystems. |
| **Disk space** | Verify available space before copying large trees. `df -h` and `du -sh src/` are useful pre-flight checks. |

## Source Policy

- Treat `man cp` and `cp --help` as runtime truth. GNU and BSD `cp` differ in some flags.
- For large or critical copies, prefer `rsync` — it supports resuming, checksums, and dry-run.
- Always verify the result with `diff -r` or `md5sum` for integrity-sensitive copies.

## See Also

- `$rsync` for resumable, checksum-verified, and remote copies
- `$mv` for moving instead of copying
- `$ln` for creating aliases without duplicating data
