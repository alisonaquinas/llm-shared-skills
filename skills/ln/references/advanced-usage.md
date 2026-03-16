# ln Advanced Usage

## Relative vs absolute symlinks

**Absolute symlinks** embed the full path and break when the tree is moved:
```bash
ln -s /home/alice/projects/app/config.json /home/alice/config.json
# If the tree moves to /srv/app, the link breaks
```

**Relative symlinks** are portable — they survive directory moves:
```bash
ln -s ../projects/app/config.json /home/alice/config.json
# Still works after the whole tree is relocated

# GNU auto-relative (computes the relative path for you)
ln -sr /absolute/source /absolute/dest-link
```

## Atomic symlink replacement

The naive `rm link && ln -s new target` has a brief window where the link
does not exist. The atomic pattern avoids this:

```bash
# Create a temp link, then rename atomically
ln -s /new/target /path/.tmp-link
mv -T /path/.tmp-link /path/link-name   # GNU mv -T: overwrite atomically
```

Or with GNU `ln`:
```bash
ln -snf /new/target link-name
```

`-n` prevents `ln` from descending into an existing directory symlink when
applying `-f`. Without `-n`, `ln -sf dir/ link` where `link` is an existing
directory symlink creates the new link *inside* the pointed-to directory.

## Directory symlinks

```bash
ln -s /var/data/uploads /srv/app/uploads

# Verify
ls -la /srv/app/uploads         # -> /var/data/uploads
ls /srv/app/uploads/            # Lists contents of /var/data/uploads

# Danger: rm -r /srv/app/uploads/ will delete contents of /var/data/uploads
# Safe removal of the link itself:
rm /srv/app/uploads             # No trailing slash — removes the link
```

## Finding and auditing links

```bash
find /path -type l                          # All symlinks
find /path -type l ! -e                     # Dangling symlinks
find /path -type l -ls                      # Symlinks with targets
find /path -samefile /target                # All hard links to a file
stat --format="%h %n" file                  # Hard link count
ls -lai | awk '$1==INODE'                   # All names sharing an inode
```

## Cross-filesystem gotchas

Hard links cannot cross filesystems or mount points. Attempting it produces:
```
ln: failed to create hard link 'b': Invalid cross-device link
```

Use a symlink instead, or `cp` if you need independent copies.

## Dotfiles management pattern

```bash
# Link all dotfiles from a repo into HOME
for f in ~/dotfiles/.*; do
    [[ "$(basename "$f")" =~ ^\.(\.)?$ ]] && continue   # skip . and ..
    ln -sfv "$f" ~/"$(basename "$f")"
done
```
