# cp Advanced Usage

## Archive mode vs selective preservation

```bash
cp -a src/ dest/            # All: permissions, ownership, timestamps, symlinks, special files
cp -p src/ dest/            # Preserve mode, ownership, timestamps only
cp --preserve=mode src dest # Selectively preserve mode only
cp --preserve=timestamps src dest
cp --preserve=ownership src dest
cp --preserve=all src dest  # Same as -a but does not imply -r
```

## Copying with progress (large files)

GNU `cp` does not have a built-in progress bar. Use `rsync -P` or `pv`:

```bash
rsync -ah --progress src/ dest/         # rsync with per-file progress

pv source.iso > dest.iso                # pv pipe for single-file progress
dd if=source.iso bs=4M | pv > dest.iso  # dd with pv for raw copy
```

## Sparse file handling

```bash
cp --sparse=auto src.img dest.img       # Detect and preserve sparse regions (GNU)
cp --sparse=always src.img dest.img     # Always create sparse dest (saves disk space)
```

## Reflinks (copy-on-write, Linux btrfs/XFS)

```bash
cp --reflink=auto src dest              # Use reflink if filesystem supports it (fast, space-efficient)
cp --reflink=always src dest            # Fail if reflink not supported
```

## Backup strategies

```bash
# Numbered backups (keeps all old versions)
cp --backup=numbered config.conf /etc/app/config.conf
# Creates: config.conf.~1~, config.conf.~2~, ...

# Simple backup (appends ~)
cp --backup=simple config.conf /etc/app/config.conf

# Custom suffix
cp --backup=simple --suffix=.bak config.conf /etc/app/config.conf
```

## Hardlinks in copies

By default `cp -r` breaks hardlinks — linked files become independent copies.
Use `rsync -aH` to preserve hardlinks:

```bash
rsync -aH src/ dest/                    # Preserve hardlinks across copy
```

## Copying to a remote host

`cp` only works locally. For remote copies:

```bash
scp -r src/ user@host:/remote/dest/     # Secure copy over SSH
rsync -av src/ user@host:/remote/dest/  # Preferred: resumable, checksum
```

## Safe copy-then-verify pattern

```bash
cp -a src/ dest/ && diff -r src/ dest/ && echo "Copy verified"
```
