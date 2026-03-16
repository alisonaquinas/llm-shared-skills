# mv Troubleshooting

## Silent overwrite of destination

**Symptom:** `mv source dest` replaces `dest` without warning.

```bash
mv -i source dest           # Interactive: prompt before overwrite
mv -n source dest           # No-clobber: refuse if dest exists
```

## "Cannot move: are on different devices"

**Symptom:** `mv: cannot move 'src' to 'dest': Invalid cross-device link`

Source and destination are on different filesystems. `mv` cannot do an atomic rename.

```bash
# Use rsync for a safe cross-filesystem move
rsync -av --remove-source-files src/ dest/

# Or cp + verify + rm
cp -a src dest && diff -r src dest && rm -rf src
```

## File moved inside directory instead of renaming it

**Symptom:** `mv myfile /existing/dir/` creates `/existing/dir/myfile` instead of renaming.

When the destination is an existing directory, `mv` always moves the source *inside* it.

```bash
# To rename: use a full destination path including the new filename
mv myfile /existing/dir/newname

# Check first
test -d /existing/dir/ && echo "is a dir — file will move inside it"
```

## Permission denied

```bash
ls -ld "$(dirname dest)"    # Check write permissions on dest directory
ls -l source                # Check source is accessible
sudo mv source dest         # Move with elevated privileges
```

## "Directory not empty" or "Cannot overwrite"

**Symptom:** `mv srcdir destdir` fails when `destdir` already exists and has content.

```bash
# mv cannot merge directories — use rsync instead
rsync -av --remove-source-files srcdir/ destdir/

# Or remove destdir first (only if safe)
rm -rf destdir && mv srcdir destdir
```

## Move interrupted on cross-filesystem operation

**Symptom:** Large move was interrupted; files are in an inconsistent state.

```bash
# Check what is in source vs destination
ls source/
ls destination/

# Resume safely with rsync (will not re-copy already-transferred files)
rsync -av --remove-source-files source/ destination/

# Remove source only after confirming all files are in dest
diff -r source/ destination/ && rm -rf source/
```

## Files with names starting with `-`

```bash
mv -- "-oddname.txt" normal.txt     # Use -- to stop option parsing
mv "./-oddname.txt" normal.txt      # Prefix with ./
```
