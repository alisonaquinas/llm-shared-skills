# mv Advanced Usage

## Atomic rename on the same filesystem

On the same filesystem, `mv` calls `rename(2)` which is atomic — there is no
window where neither source nor destination exists. This makes `mv` reliable
for safe swap patterns:

```bash
# Atomic config swap: new config replaces old with no gap
cp existing.conf existing.conf.bak
cp new.conf existing.conf.tmp
mv existing.conf.tmp existing.conf      # Atomic on same filesystem
```

## Cross-filesystem move (copy-then-delete)

When source and destination are on different filesystems, `mv` falls back to
`cp` + `rm`. If interrupted, data may be in both or neither location.

```bash
df source /destination/                 # Check filesystems
# Safer cross-filesystem move with rsync
rsync -av --remove-source-files source/ /destination/
```

## Moving multiple files

```bash
mv file1 file2 file3 /target/dir/   # Last argument must be a directory
mv *.log /archive/                  # Shell glob expansion
mv -t /target/dir/ file1 file2 file3  # -t flag: explicit target dir (GNU)
```

## Undo-safe pattern (backup before move)

```bash
# Back up destination automatically before overwriting
mv --backup=numbered source dest
# If dest existed: dest.~1~ is the backup, dest is the new file

# Manual pre-backup
cp -p dest dest.bak && mv source dest
```

## Renaming with patterns

```bash
# Bash loop: rename all .jpeg to .jpg
for f in *.jpeg; do mv "$f" "${f%.jpeg}.jpg"; done

# Perl rename (rename all spaces to underscores)
rename 's/ /_/g' *

# util-linux rename (simpler fixed-string replacement)
rename ' ' '_' *
```

## Moving directories

```bash
mv srcdir/ /new/parent/             # Moves srcdir to /new/parent/srcdir/
mv srcdir/ /exact/new/path          # Renames directory if /exact/new/path doesn't exist

# Moving directory contents (not the dir itself)
mv srcdir/* /target/dir/            # Shell glob (misses hidden files)
find srcdir/ -maxdepth 1 -mindepth 1 -exec mv -t /target/dir/ {} +   # All entries
```

## Handling filenames with special characters

```bash
mv -- "-hyphen-first.txt" normal.txt    # -- ends option parsing
mv "file with spaces.txt" dest/         # Quote names with spaces
mv $'file\nwith\nnewline' dest/         # ANSI-C quoting for newlines
```
