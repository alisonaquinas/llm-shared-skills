# unzip Advanced Usage

## Encryption and Password Handling

```bash
# Extract encrypted archive (interactive prompt)
unzip archive.zip

# Or with password via stdin
echo "password" | unzip -P - archive.zip

# NEVER: Don't pass password as argument (visible in history)
# BAD: unzip -P MyPassword archive.zip

# Test encrypted archive
unzip -t -P - archive.zip << 'EOF'
password
EOF
```

## Path Traversal Protection

```bash
# Always list first
unzip -l archive.zip | head -20

# Check for suspicious paths
unzip -l archive.zip | grep '\.\.'

# Extract safely to new directory
mkdir safe
unzip archive.zip -d safe/

# Verify no parent directory extraction
ls -la safe/
```

## Exclusion and Selective Extraction

```bash
# Extract specific files only
unzip archive.zip "*.txt"

# Exclude patterns
unzip archive.zip -x "*.tmp"

# Extract file to stdout (without writing)
unzip -p archive.zip file.txt | head -20
```

## Overwrite Policies

```bash
# Never overwrite
unzip -n archive.zip -d output/

# Always overwrite
unzip -o archive.zip -d output/

# Update only (extract if newer)
unzip -u archive.zip -d output/

# List without extracting
unzip -l archive.zip
```

## Large Archive Handling

```bash
# Verify disk space before extraction
du -h archive.zip
df -h

# Extract subset to save space
unzip -l archive.zip | grep "\.config"
unzip archive.zip "subdir/\.config/*" -d output/

# List file sizes
unzip -l archive.zip | awk '{print $1, $4}' | tail -n +2
```

## Testing and Verification

```bash
# Full integrity test
unzip -t archive.zip

# Verbose test
unzip -tv archive.zip

# Extract and verify checksums
unzip archive.zip
md5sum -c archive.md5
```

## Resources

- [info-zip Manual](http://www.info-zip.org/mans/unzip.html)
- [RFC 1951 (DEFLATE)](https://tools.ietf.org/html/rfc1951)
