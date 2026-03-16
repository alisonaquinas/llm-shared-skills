---
name: ln
description: >
  Create hard links and symbolic links with ln for aliasing files, building
  path indirection, and managing shared references without duplication. Use
  when the agent needs to create a symlink to a file or directory, replace a
  broken link, create a hard link between files on the same filesystem, or
  safely update a symlink atomically.
---

# ln

Create hard links and symbolic links between files and directories.

## Quick Start

1. Verify availability: `ln --version` (GNU) or `man ln`
2. Create a symlink: `ln -s /path/to/target link-name`
3. Inspect the result: `ls -l link-name`

## Intent Router

- `references/cheatsheet.md` — Symlinks vs hard links, common flags, creating and replacing links, verification
- `references/advanced-usage.md` — Relative vs absolute symlinks, atomic replacement, directory links, cross-filesystem constraints
- `references/troubleshooting.md` — Broken links, dangling symlinks, circular references, cross-filesystem hard link errors

## Core Workflow

1. Decide: symlink (`-s`) for cross-filesystem, directory, or path-indirection use; hard link for same-filesystem file aliasing
2. Verify the target path exists and is correct before creating the link
3. Use `-v` to confirm what was created
4. Inspect with `ls -l` to confirm link direction and target
5. Use `readlink -f` or `realpath` to resolve the full target chain

## Quick Command Reference

```bash
ln -s /path/to/target link-name        # Create a symbolic link
ln -s ../relative/path link-name       # Relative symlink (portable across moves)
ln -sf /new/target existing-link       # Replace (force) an existing symlink
ln -snf /new/target existing-link      # Replace without following if target is a dir
ln -sv /path/to/target link-name       # Verbose: confirm what was created
ln /path/to/source hard-link           # Create a hard link (same filesystem only)
ls -l link-name                        # Inspect link and its target
readlink link-name                     # Print the symlink target
readlink -f link-name                  # Resolve the full canonical path
man ln                                 # Full manual
```

## Safety Notes

| Area | Guardrail |
| --- | --- |
| **Verify target first** | Creating a symlink to a non-existent path produces a dangling link. Confirm the target exists with `ls` or `test -e` before linking. |
| **Force flag** | `-f` silently removes any existing file or link at the destination. Always check what exists there first with `ls -l`. |
| **Directory symlinks** | When a link destination is a directory, `ln -sf dir link` may link *inside* the directory rather than replace the link. Use `-n` (`--no-dereference`) to treat the link itself as the target. |
| **Hard links and directories** | Hard-linking directories is disallowed on most systems to prevent filesystem cycles. Use symlinks for directories. |
| **Cross-filesystem hard links** | Hard links cannot span different filesystems or mount points. Use symlinks instead. |
| **Relative vs absolute** | Absolute symlinks break when the tree is moved. Prefer relative symlinks for portable layouts. |

## Source Policy

- Treat `man ln` and `ln --help` as runtime truth.
- Verify with `ls -l` and `readlink` after creating links; do not assume success from exit code alone.
- Test symlink validity with `test -L link && test -e link` to distinguish dangling from valid.

## See Also

- `$cp` for actual file copying instead of aliasing
- `readlink` / `realpath` for resolving link chains
- `find -type l` for locating all symlinks in a directory tree
