# ln Troubleshooting

## Dangling symlink (target does not exist)

**Symptom:** `ls -l` shows the link but operations fail with "No such file or directory".

```bash
ls -la link-name                        # Shows -> nonexistent-path
readlink link-name                      # Print what it points to
test -e link-name && echo ok || echo dangling

# Fix: re-point the link to the correct target
ln -sf /correct/target link-name
```

## Link created inside directory instead of replacing it

**Symptom:** `ln -sf /new/target mylink` creates `/new/target` inside `mylink/` instead of replacing `mylink`.

This happens when `mylink` is a symlink to a directory. `ln -f` follows the link.

```bash
# Fix: add -n to treat the existing link as a file, not a dir
ln -snf /new/target mylink
```

## "Invalid cross-device link" error

**Symptom:** `ln source dest` fails when source and dest are on different filesystems.

```bash
df source dest                          # Confirm they are on different mounts

# Fix: use a symlink instead of a hard link
ln -s /full/path/to/source dest
# Or copy the file
cp source dest
```

## Symlink loop / circular reference

**Symptom:** Operations on the link fail with "Too many levels of symbolic links".

```bash
# Detect the loop
readlink -f link-name                   # Will fail or show the loop
namei -l /path/to/link                  # Trace each component

# Fix: remove the offending link and recreate correctly
rm loop-link
ln -s /correct/non-circular/target loop-link
```

## Permission denied creating a link

**Symptom:** `ln: failed to create symbolic link 'dest': Permission denied`

```bash
ls -ld "$(dirname dest)"                # Check write permission on parent dir
sudo ln -s source dest                  # Create with elevated privileges
```

## Link exists but test -e returns false

**Symptom:** `ls -l` shows the link, but `[ -e link ]` is false.

The link is dangling — it exists as a filesystem entry but its target does not.

```bash
test -L link && echo "is symlink"       # True for any symlink (even dangling)
test -e link && echo "target exists"    # True only if target is reachable
```

Use `-L` to check for "is a symlink" and `-e` to check "target exists".
