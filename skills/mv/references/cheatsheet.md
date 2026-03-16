# mv Cheatsheet

## Essential flags

| Flag | Meaning |
| --- | --- |
| `-i` | Interactive: prompt before overwriting |
| `-n` | No-clobber: never overwrite existing destination |
| `-f` | Force: do not prompt; override `-i` |
| `-v` | Verbose: print what is being moved |
| `-b` | Backup destination before overwriting (appends `~`) |
| `--backup=numbered` | Numbered backups: `.~1~`, `.~2~`, … |
| `--suffix=.bak` | Custom backup suffix (used with `-b`) |

## Common invocations

```bash
mv old.txt new.txt                  # Rename file in place
mv file.txt /target/dir/            # Move into directory
mv file.txt /target/dir/renamed.txt # Move and rename
mv -i source.txt dest.txt           # Prompt before overwriting
mv -n source.txt dest.txt           # Skip if destination exists
mv -v *.log /archive/               # Verbose batch move
mv -b config.conf /etc/app/         # Back up existing /etc/app/config.conf first
mv --backup=numbered src dest       # Numbered backups
mv dir/ /new/parent/                # Move entire directory
mv -- -weird-name.txt safe.txt      # Move file whose name starts with dash
```

## Rename multiple files (no built-in glob rename)

```bash
# Using a loop (bash)
for f in *.txt; do mv "$f" "${f%.txt}.md"; done

# Using rename (Perl rename, if installed)
rename 's/\.txt$/.md/' *.txt

# Using rename (util-linux rename, if installed)
rename .txt .md *.txt
```

## Checking before moving

```bash
ls -l source dest               # Confirm source exists, check dest
test -e dest && echo "dest exists — use -i or -n"
df -h /destination/             # Check space for large moves
```
