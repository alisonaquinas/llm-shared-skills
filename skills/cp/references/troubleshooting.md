# cp Troubleshooting

## Silent overwrite of destination

**Symptom:** Destination file is replaced without warning.

`cp` overwrites by default. To prevent this:

```bash
cp -i source dest           # Interactive: prompt before overwrite
cp -n source dest           # No-clobber: skip if dest exists
```

## Directory copied inside another directory instead of replacing it

**Symptom:** `cp -r src/ dest/` creates `dest/src/` when `dest` already exists.

```bash
# When dest exists, cp -r places src inside it
# Solution 1: remove dest first
rm -rf dest && cp -r src/ dest/

# Solution 2: copy contents only
cp -r src/. dest/
```

## Permission denied

```bash
# Check write permissions on destination directory
ls -ld /destination/dir/
# Copy with elevated privileges
sudo cp source dest

# Check source is readable
ls -l source
```

## "Omitting directory" warning

**Symptom:** `cp src/ dest/` warns "omitting directory" and skips it.

```bash
# Add -r to copy directories recursively
cp -r src/ dest/
```

## Symlinks not copied as links

**Symptom:** Symlink is replaced by the file it points to, not a link.

By default `cp` follows symlinks. Use `-P` to copy the link itself:

```bash
cp -P symlink dest/         # Copy the link, not the target
cp -a src/ dest/            # Archive mode preserves symlinks
```

## Disk space issues

```bash
# Check available space before copying large trees
df -h /destination/
du -sh /source/

# Dry-run estimate with rsync
rsync -avn src/ dest/       # Shows what would be transferred
```

## Files with special characters in names

```bash
# Glob expansion can miss or mismatch files with spaces
cp "file with spaces.txt" dest/     # Quote the filename
cp -- "-starts-with-dash.txt" dest/ # Use -- to end flag parsing
```

## Cross-filesystem copy loses hardlinks

**Symptom:** Files that were hardlinked in source become independent copies in dest.

```bash
# Use rsync with -H to preserve hardlinks
rsync -aH src/ dest/
```
