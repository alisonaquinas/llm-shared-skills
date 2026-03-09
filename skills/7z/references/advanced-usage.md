# 7z Advanced Usage

## Archive Formats and Solid Archives

### 7z Format (Native)

7z format offers best compression but is less portable:

```bash
# Create 7z archive (highest compression)
7z a archive.7z files/

# Create with specific compression method
7z a -t7z -m0=LZMA2 -mx=9 archive.7z files/

# Solid archive (default): compresses across files
7z a -ms=on archive.7z files/  # All data compressed as one stream

# Non-solid: each file compressed separately
7z a -ms=off archive.7z files/
```

### Multi-Format Archives

7z can handle and create multiple formats:

```bash
# Auto-detect format on extraction
7z x archive.tar.7z      # Extracts to archive.tar, then decompress

# Create ZIP (for compatibility)
7z a -tzip archive.zip files/

# Create tar.7z (tar + 7z compression)
7z a -ttar archive.tar files/
7z a -t7z archive.tar.7z archive.tar

# Create tar.gz
7z a -tgzip archive.tar.gz files/
```

## Compression Methods and Levels

### Compression Algorithms

```bash
# LZMA2 (default, excellent compression)
7z a -m0=LZMA2 -mx=9 archive.7z files/

# LZMA (older, slower)
7z a -m0=LZMA -mx=9 archive.7z files/

# PPMd (better for text)
7z a -m0=PPMd -mx=9 archive.7z files/

# Deflate (fast, compatible)
7z a -m0=Deflate -mx=9 archive.7z files/

# BZip2
7z a -t7z -m0=BZip2 -mx=9 archive.7z files/
```

### Compression Levels

```bash
# Level 0: No compression (fast)
7z a -mx=0 archive.7z files/

# Level 1-3: Fast compression
7z a -mx=1 archive.7z files/  # Fastest

# Level 5: Normal (default)
7z a -mx=5 archive.7z files/

# Level 7-9: Maximum compression (slow)
7z a -mx=9 archive.7z files/  # Best compression, slowest
```

### Multi-threading

```bash
# Use 4 threads for compression
7z a -mmt=4 archive.7z files/

# Auto-detect thread count
7z a -mmt=on archive.7z files/

# Disable multithreading
7z a -mmt=off archive.7z files/
```

## Encryption and Password Handling

### Password Protection

```bash
# Encrypt with interactive password prompt
7z a -p archive.7z files/
# Will ask: Enter password (will not be echoed)

# Test encrypted archive
7z t -pMyPassword archive.7z

# Extract encrypted archive
7z x -pMyPassword archive.7z

# Encrypt file list (header encryption)
7z a -p -mhe=on archive.7z files/
```

### Password Security Best Practices

```bash
# NEVER use passwords in command line (visible in history)
# BAD:
7z a -pMyPassword archive.7z files/

# GOOD: Use interactive prompt
7z a -p archive.7z files/

# GOOD: Use environment variable (still risky)
7z a -p"$PASSWORD" archive.7z files/

# BEST: Use password file with restricted permissions
echo "mypassword" > /tmp/pwd.txt
chmod 600 /tmp/pwd.txt
7z a -p"$(cat /tmp/pwd.txt)" archive.7z files/
rm /tmp/pwd.txt
```

## Solid Archive Handling

### Creating Solid Archives

```bash
# Solid archive (all files treated as one stream)
# Best compression, but can't extract single file efficiently
7z a -ms=on archive.7z files/

# Non-solid archive (each file independent)
# Worse compression, but faster extraction of individual files
7z a -ms=off archive.7z files/
```

### Extraction from Solid Archives

```bash
# Extract entire solid archive
7z x archive.7z

# Extract specific file (requires reading entire archive)
7z x archive.7z file.txt
# Note: Even for one file, 7z must decompress preceding files

# List without extracting (fastest)
7z l archive.7z
```

## Handling Path Traversal and Security

### Safe Extraction

```bash
# Always use explicit output directory
7z x archive.7z -osafe_dir/

# Test archive before extraction
7z t archive.7z
# Check for any "ERROR" messages

# List contents to verify paths
7z l archive.7z | head -20
# Look for entries with ".." or absolute paths

# Extract with path filtering
# Only accept files in subdirectories
7z l archive.7z | grep -v '^\\./' | grep -v '^/' | wc -l
```

### Validation Script

```bash
#!/bin/bash

ARCHIVE="$1"
OUTPUT_DIR="$2"

# Validate archive exists
if [ ! -f "$ARCHIVE" ]; then
  echo "Archive not found"
  exit 1
fi

# Test integrity
if ! 7z t "$ARCHIVE" > /dev/null 2>&1; then
  echo "Archive is corrupted"
  exit 1
fi

# Check for suspicious paths
if 7z l "$ARCHIVE" | grep -E '^\.\.|^/' > /dev/null; then
  echo "Archive contains suspicious paths"
  exit 1
fi

# Safe extraction
7z x "$ARCHIVE" -o"${OUTPUT_DIR}/" -y > /dev/null 2>&1
echo "Extracted successfully to ${OUTPUT_DIR}"
```

## Archive Testing and Validation

### Integrity Testing

```bash
# Test archive completely
7z t archive.7z

# Test with verbose output
7z t -v archive.7z

# Test specific file in archive
7z t archive.7z file.txt
```

### Corruption Detection

```bash
# Compare extracted file with original
7z x archive.7z -so file.txt | sha256sum
sha256sum original_file.txt

# If checksums match, extraction was successful
```

## Batch Operations

### Compress Multiple Directories

```bash
# Create separate archives for each directory
for dir in */; do
  7z a "${dir%.7z}.7z" "$dir"
done

# Create single archive with all
7z a combined.7z */

# Create with date stamp
DATE=$(date +%Y%m%d)
7z a "backup-${DATE}.7z" important_files/
```

### Incremental Backups

```bash
# Create initial backup
7z a -t7z backup_full.7z source_dir/

# Create update archive (only newer files)
7z u backup_full.7z source_dir/

# Extract in order for full recovery
7z x backup_full.7z
# Merge updates as needed
```

## Performance Optimization

### Memory Usage

```bash
# Reduce memory for slow systems
7z a -m0=LZMA2:d=16m archive.7z files/

# Default is 64MB dictionary
7z a -m0=LZMA2:d=64m archive.7z files/

# Larger dictionary for better compression (more memory)
7z a -m0=LZMA2:d=256m archive.7z files/
```

### Parallel Compression

```bash
# Use all CPU cores
7z a -mmt=on archive.7z files/

# Limit to specific thread count
7z a -mmt=8 archive.7z files/
```

## Real-World Examples

### Version Control Backup

```bash
# Exclude version control directories
7z a backup.7z -xr!.git -xr!node_modules project/

# List excluded patterns
7z a -h backup.7z  # Shows help with -x patterns
```

### Docker Image Archival

```bash
# Save docker image to compressed archive
docker save myimage:latest | 7z a -si image.7z

# Restore from archive
7z x -so image.7z | docker load
```

### Log Rotation

```bash
# Compress old logs
7z a logs-2024-01.7z /var/log/app.log.1
# Remove original
rm /var/log/app.log.1

# Extract if needed for analysis
7z x logs-2024-01.7z
```

## Resources

- 7z Official Documentation: <https://www.7-zip.org/7z.html>
- p7zip: <https://sourceforge.net/projects/p7zip/>
- Format specification: <https://www.7-zip.org/7z.html>
