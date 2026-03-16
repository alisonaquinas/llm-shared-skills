# ln Cheatsheet

## Hard links vs symbolic links

| | Hard link | Symbolic link |
| --- | --- | --- |
| Points to | inode (data itself) | Path (can be relative or absolute) |
| Survives target move/delete | Yes (data stays while any link exists) | No (becomes dangling) |
| Crosses filesystems | No | Yes |
| Works on directories | No (usually) | Yes |
| Shows in `ls -l` | `-` (looks like a regular file) | `l` with `->` target |
| Inode shared | Yes | No |

## Essential flags

| Flag | Meaning |
| --- | --- |
| `-s` | Create a symbolic (soft) link |
| `-f` | Force: remove existing destination before creating link |
| `-n` | No-dereference: treat destination symlink as a file, not a target |
| `-v` | Verbose: print each link created |
| `-r` | Create relative symlink (GNU, auto-computes relative path) |
| `-b` | Backup any overwritten destination file |

## Common invocations

```bash
ln -s /path/to/target link-name         # Create a symlink
ln -s ../relative/target link-name      # Relative symlink
ln -sv /path/to/target link-name        # Verbose confirmation
ln -sf /new/target existing-link        # Replace an existing symlink
ln -snf /new/target existing-link       # Replace when target is a directory
ln -sr /abs/target link-name            # Auto-relative symlink (GNU)
ln /path/to/source hard-link            # Hard link (same filesystem)
ln -fv /new/source existing-hard-link   # Replace hard link
```

## Verifying links

```bash
ls -l link-name                         # Shows -> target for symlinks
readlink link-name                      # Print symlink target
readlink -f link-name                   # Resolve full canonical path
stat link-name                          # Inode, permissions, type detail
test -L link-name && echo "is symlink"
test -L link && test -e link && echo "valid"
test -L link && ! test -e link && echo "dangling"
```

## Typical patterns

```bash
# Config file indirection
ln -s /etc/myapp/production.conf /etc/myapp/active.conf

# Version aliasing
ln -sf /usr/local/python3.12/bin/python3 /usr/local/bin/python3

# Atomic swap: replace link without a broken-link window
ln -snf /new/target link-name

# Link a dotfile from a dotfiles repo into HOME
ln -sv ~/dotfiles/.bashrc ~/.bashrc
```
