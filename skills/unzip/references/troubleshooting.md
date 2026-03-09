# unzip Troubleshooting

## Exit Code Reference

| Code | Meaning |
| --- | --- |
| 0 | Success |
| 1 | Warning (some files not extracted) |
| 2 | Fatal error |
| 3 | Bad CRC |
| 50+ | Password issues |

## Common Errors and Solutions

### Error: "Cannot find or open archive"

**Cause:** Archive doesn't exist or wrong path.

**Fix:**

```bash
ls -la archive.zip
unzip -l /full/path/to/archive.zip
```

### Error: "Bad CRC, file probably corrupted"

**Cause:** Archive is damaged or incomplete download.

**Fix:**

```bash
# Re-download archive

# Or extract what's recoverable
unzip -o archive.zip  # Force overwrite/continue

# Verify integrity first
unzip -t archive.zip
```

### Error: "Bad password"

**Cause:** Wrong password for encrypted archive.

**Fix:**

```bash
# Try again
unzip -P - archive.zip

# List without extracting (to verify existence)
unzip -l archive.zip
```

## Path Traversal Issues

### Files Extracted to Parent Directory

**Cause:** Archive contains `../` paths.

**Prevention:**

```bash
unzip -l archive.zip | grep '\.\.'

mkdir safe
unzip archive.zip -d safe/
```

## Permission Issues

### Cannot Create Files (Permission Denied)

**Cause:** Target directory not writable.

**Fix:**

```bash
mkdir -p /tmp/safe && chmod 777 /tmp/safe
unzip archive.zip -d /tmp/safe/
```

### Extracted Files Have Wrong Permissions

**Cause:** ZIP stores different permissions.

**Fix:**

```bash
# Extract and fix
unzip archive.zip
chmod -R 755 extracted/
```

## Corruption and Testing

### Verify Archive Integrity

```bash
unzip -t archive.zip  # Full test

# Verbose output
unzip -tv archive.zip 2>&1 | tail -20
```

### Partial Recovery

```bash
# Extract despite errors
unzip -o archive.zip -d output/

# List successful extractions
ls -la output/
```

## Encoding Issues

### Garbled Filenames

**Cause:** Archive uses different character encoding.

**Fix:**

```bash
# Extract with specific encoding
LC_ALL=en_US.UTF-8 unzip archive.zip

# Or iconv after extraction
find . -type f | while read f; do
  new=$(echo "$f" | iconv -f ISO-8859-1 -t UTF-8)
  [ "$f" != "$new" ] && mv "$f" "$new"
done
```

## Symlink Issues

### Symlinks Broken After Extraction

**Cause:** Symlink targets changed path.

**Fix:**

```bash
# List symlinks in archive
unzip -l archive.zip | grep "^l"

# Extract to expected directory
mkdir -p expected/
unzip archive.zip -d expected/

# Verify symlinks
ls -l expected/ | grep "^l"
```

## Large File Issues

### Disk Space Exhaustion

**Cause:** Archive larger than available space.

**Fix:**

```bash
du -h archive.zip    # Archive size
unzip -l archive.zip | tail -1  # Total uncompressed size

df -h               # Available space

# Extract to different filesystem
unzip archive.zip -d /mnt/large/
```

## Resources

- [info-zip Manual](http://www.info-zip.org/mans/unzip.html)
