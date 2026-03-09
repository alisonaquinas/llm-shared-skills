# tar Advanced Usage

## Compression Formats

```bash
# Gzip (most common, moderate compression)
tar -czf archive.tar.gz directory/

# Bzip2 (better compression, slower)
tar -cjf archive.tar.bz2 directory/

# XZ (best compression, very slow)
tar -cJf archive.tar.xz directory/

# Uncompressed
tar -cf archive.tar directory/

# Auto-detect on extraction
tar -xf archive.tar.*
```

## GNU vs BSD tar

### Key Differences

GNU tar (Linux default):

- More options and extensions
- Handles long filenames better
- Supports incremental backups

BSD tar (macOS default):

- Simpler, POSIX-like
- Works identically for basic operations

### Compatibility

```bash
# Both support basic operations
tar -czf, -tzf, -xzf

# GNU-only features may not work on BSD
# Test cross-platform archives
```

## Path Traversal Safety

```bash
# Always list before extracting
tar -tf archive.tar.gz | head -20

# Check for suspicious entries
tar -tf archive.tar.gz | grep -E '^\.\.|^/'

# Extract safely to new directory
mkdir -p safe_dir
tar -xzf archive.tar.gz -C safe_dir/

# Strip leading directory components
tar -xzf archive.tar.gz --strip-components=1
```

## Symlink Handling

```bash
# tar preserves symlinks
# Check what's in archive
tar -tf archive.tar.gz | grep -l '^l'

# Extract without dereferencing symlinks
tar -xzf archive.tar.gz

# Dereference symlinks during creation
tar -czf archive.tar.gz -h directory/
# 'h' = follow symlinks, store as regular files
```

## Permission and Ownership

```bash
# Extract without preserving ownership
tar -xzf archive.tar.gz --no-same-owner --no-same-permissions

# Useful for archives from other systems
# Prevents permission/ownership mismatches

# Preserve everything
tar -xzpf archive.tar.gz
# 'p' = preserve permissions
```

## Large File Handling

```bash
# tar handles files >2GB efficiently
# Verify disk space before extraction
du -h archive.tar.gz

# Extract incrementally
tar -xzf large_archive.tar.gz | head -100
```

## Real-World Patterns

### Backup Creation

```bash
# Full backup with date
tar -czf backup-$(date +%Y%m%d).tar.gz important_dir/

# Selective backup (exclude .git, node_modules)
tar -czf backup.tar.gz \
  --exclude='.git' \
  --exclude='node_modules' \
  project/
```

### Docker Image Distribution

```bash
# Save docker image
docker save myimage:latest | tar -czf image.tar.gz

# Restore
tar -xzf image.tar.gz | docker load
```

## Resources

- GNU tar Manual: <https://www.gnu.org/software/tar/manual/>
- POSIX tar: <https://pubs.opengroup.org/onlinepubs/9699919799/utilities/tar.html>
