# 7z Troubleshooting

## Exit Code Reference

| Code | Meaning |
| --- | --- |
| 0 | Success |
| 1 | Warning (some data was not compressed) |
| 2 | Fatal error |
| 7 | Bad encoded data |
| 8 | CRC failed |
| 255 | User stop |

## Common Errors and Solutions

### Error: "Command not found"

**Message:** `7z: command not found`

**Cause:** 7z not installed or not in PATH.

**Fix:**

```bash
# Install p7zip
apt-get install -y p7zip-full      # Debian/Ubuntu
dnf install -y p7zip               # Fedora/RHEL
brew install p7zip                 # macOS
pacman -S p7zip                    # Arch

# Verify installation
which 7z
7z --help
```

### Error: "Cannot open file"

**Message:** `7z: Cannot open file as archive`

**Cause:** File is not a valid 7z archive or is corrupted.

**Fix:**

```bash
# Check file exists
ls -la file.7z

# Test archive integrity
7z t file.7z

# Check file type
file file.7z

# Check file size (corrupted if unusually small)
du -h file.7z
```

### Error: "Data Error"

**Message:** `Data Error in archive: ...`

**Cause:** Archive is corrupted or incomplete download.

**Fix:**

```bash
# Re-download archive
# Or use backup copy if available

# Extract with recovery
7z x file.7z -y  # Force overwrite

# Extract to test
7z x file.7z -otest_dir/

# Verify extracted files
ls -la test_dir/
```

### Error: "Encrypted data"

**Message:** `Encrypted 7z archive` or `Encrypted header`

**Cause:** Archive requires password.

**Fix:**

```bash
# Extract with password
7z x file.7z -pYourPassword

# Or interactive prompt
7z x file.7z -p
# Enter password when prompted

# Check if password-protected
7z l file.7z
# Output will mention encryption
```

### Error: "Wrong password"

**Message:** `Wrong password?` or CRC errors after extraction

**Cause:** Incorrect password provided.

**Fix:**

```bash
# Try again with correct password
7z x file.7z -p

# Or use environment variable
export PASSWORD="correct_password"
7z x file.7z -p"$PASSWORD"
```

## Path Traversal and Security Issues

### Symptom: Files extracted to parent directory

**Cause:** Archive contains paths with `..` that traverse directories.

**Example:**

```bash
# Archive contains: ../../../etc/passwd
7z x archive.7z
# May extract to parent directories

# Dangerous!
```

**Prevention:**

```bash
# Always list before extracting
7z l archive.7z | head -20

# Look for suspicious entries starting with ".."
7z l archive.7z | grep '^\.\.'

# Extract to isolated directory
mkdir -p isolated_extract
7z x archive.7z -oisolated_extract/

# Verify extracted paths are safe
find isolated_extract -name ".."
```

## Performance Issues

### Extraction Very Slow

**Cause:** Large solid archive or slow disk.

**Solutions:**

```bash
# For solid archives, entire file must decompress
# Even extracting one file means decompressing all preceding data

# Check archive properties
7z l -v archive.7z | grep "Solid:"

# If you need faster access to individual files, re-archive as non-solid
7z x archive.7z -oextracted/
7z a -ms=off new_archive.7z extracted/
```

### Memory Issues During Compression

**Cause:** Large dictionary size with insufficient RAM.

**Fix:**

```bash
# Reduce dictionary size
7z a -m0=LZMA2:d=16m archive.7z files/

# Disable multithreading to reduce memory
7z a -mmt=off -m0=LZMA2 archive.7z files/

# Check available memory
free -h  # Linux
vm_stat  # macOS
```

## Archive Integrity Problems

### CRC Error After Extraction

**Message:** `CRC Failed in 'filename'`

**Cause:** File was corrupted during download or storage.

**Fix:**

```bash
# Re-download archive

# Or verify and recover
7z t archive.7z

# If archive is salvageable, extract what you can
7z x archive.7z -y  # Force overwrite and continue

# Compare checksums if available
7z h archive.7z  # Show CRC values
```

## File Permission and Ownership Issues

### Extracted Files Have Wrong Permissions

**Cause:** Archive stored different permissions; system restores differently.

**Fix:**

```bash
# After extraction, fix permissions
chmod -R 755 extracted_dir/
chmod -R go-w extracted_dir/  # Remove group/other write

# Or use umask
umask 077
7z x archive.7z

# Then adjust as needed
chmod 644 extracted_files
chmod 755 extracted_dir
```

## Multi-Volume Archive Issues

### Cannot Extract Multi-Volume Archive

**Cause:** Missing volumes or volumes out of order.

**Fix:**

```bash
# List available volumes
ls -la archive.7z.*

# Ensure all volumes are present:
# archive.7z.001
# archive.7z.002
# ...
# archive.7z.N (or final .7z without number)

# Extract from first volume
7z x archive.7z.001

# 7z will automatically use other volumes
```

## Character Encoding Issues

### Garbled Filenames in Archive

**Cause:** Archive created with different character encoding.

**Solutions:**

```bash
# List and check filenames
7z l archive.7z

# Extract and rename if needed
7z x archive.7z

# Use iconv to fix encoding
for f in *; do
  new_name=$(echo "$f" | iconv -f CP437 -t UTF-8)
  [ "$f" != "$new_name" ] && mv "$f" "$new_name"
done
```

## Platform-Specific Issues

### Windows Paths in macOS Archive

**Symptom:** Extracted files in subdirectories or with backslashes.

**Cause:** Archive was created on Windows with different path separators.

**Fix:**

```bash
# Extract and normalize
7z x archive.7z

# Convert backslashes to forward slashes in filenames
find . -name '*\\*' -type f | while read f; do
  dir=$(dirname "$f")
  old=$(basename "$f")
  new=$(echo "$old" | tr '\\' '_')
  mv "$f" "$dir/$new"
done
```

## Sparse File Handling

### Sparse Files Become Full Size

**Cause:** 7z doesn't preserve sparse file blocks.

**Fix:**

```bash
# Before archiving, identify sparse files
find . -type f -sparse

# Note their size differences
du -h file.sparse
ls -la file.sparse | awk '{print $5}'

# After extraction, recreate sparse attribute if needed
# On Linux: fallocate -d file  (if supported)
# On macOS: No direct sparse recreation
```

## Testing and Validation

### Verify Archive Integrity

```bash
# Full integrity test (may take time)
7z t -v archive.7z

# Quick test
7z t archive.7z

# Test specific file
7z t archive.7z file.txt

# Verbose output
7z t -v -y archive.7z 2>&1 | tail -20
```

## Resources

- 7z Manual: <https://www.7-zip.org/7z.html>
- Error codes: <https://sevenzip.osdn.jp/chm/cmdline/exit_codes.htm>
