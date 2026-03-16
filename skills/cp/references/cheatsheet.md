# cp Cheatsheet

## Essential flags

| Flag | Meaning |
| --- | --- |
| `-r` / `-R` | Recursive: copy directories and their contents |
| `-a` | Archive: equivalent to `-r -p --no-dereference` — preserves all metadata |
| `-p` | Preserve mode, ownership, and timestamps |
| `-i` | Interactive: prompt before overwriting |
| `-n` | No-clobber: never overwrite an existing file |
| `-u` | Update: copy only when source is newer than destination |
| `-v` | Verbose: print each file as it is copied |
| `-f` | Force: remove destination before copying if needed |
| `--backup=numbered` | Create numbered backups of overwritten files |
| `-L` | Follow symlinks (copy file referenced, not the link) |
| `-P` | Never follow symlinks (copy the link itself) |
| `--progress` | Show per-file progress (GNU cp with pv, or use rsync) |

## Common invocations

```bash
cp source.txt dest.txt              # Copy a single file
cp source.txt /target/dir/          # Copy into a directory
cp a.txt b.txt c.txt /target/dir/   # Copy multiple files into directory
cp -r src/ dest/                    # Recursive directory copy
cp -a src/ dest/                    # Archive copy: preserve all metadata
cp -i source.txt dest.txt           # Prompt before overwriting
cp -n source.txt dest.txt           # Skip if destination exists
cp -u source.txt dest.txt           # Copy only if source is newer
cp -v *.log /archive/               # Verbose batch copy
cp -p config.conf config.conf.bak   # Preserve timestamps in backup
cp --backup=numbered file.txt dir/  # Numbered backup: file.txt.~1~, .~2~, ...
```

## Directory copy behaviour

```bash
# dest does NOT exist → dest is created as a copy of src
cp -r src/ dest/

# dest DOES exist → src is copied INSIDE dest (creates dest/src/)
cp -r src/ dest/

# To always copy contents into dest regardless:
cp -r src/. dest/     # Copy contents of src into dest
cp -r src/* dest/     # Same (but misses hidden files)
```

## Verifying a copy

```bash
diff -r src/ dest/                          # Compare directories recursively
md5sum source.txt && md5sum dest.txt        # Compare checksums
ls -lh source.txt dest.txt                  # Compare sizes and timestamps
```
