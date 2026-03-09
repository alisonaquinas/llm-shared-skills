# ar Troubleshooting

## Exit Code Reference

| Code | Meaning |
| --- | --- |
| 0 | Success |
| 1 | Error (command failed, file not found, etc.) |

## Common Errors and Solutions

### Error: "No such file or directory"

**Message:** `ar: libexample.a: No such file or directory`

**Cause:** Archive file doesn't exist.

**Fix:**

```bash
# Check if file exists
ls -la libexample.a

# Check current directory
pwd

# Look for similarly named files
find . -name "*.a" -type f

# Verify correct path
ar t /full/path/to/libexample.a
```

### Error: "Invalid archive format"

**Message:** `ar: libexample.a is not an archive`

**Cause:** File is not a valid ar archive (corrupted or wrong file type).

**Fix:**

```bash
# Check file type
file libexample.a
# Should show: "ar archive" or "current ar archive"

# Check magic bytes
od -c libexample.a | head -2
# Should start with: ! < a r c h

# Try to list contents
ar t libexample.a

# If file is corrupted, recover from backup
cp libexample.a.backup libexample.a
```

### Error: "No such member in archive"

**Message:** `ar: no such member in archive: module.o`

**Cause:** Member doesn't exist in archive.

**Fix:**

```bash
# List all members
ar t libexample.a

# Check spelling
ar t libexample.a | grep "modul"

# Extract with correct name
ar x libexample.a correct_name.o

# If member is definitely needed, add it
ar r libexample.a missing.o
ar s libexample.a
```

### Error: "Permission denied"

**Message:** `ar: libexample.a: Permission denied`

**Cause:** Insufficient permissions on archive file.

**Fix:**

```bash
# Check permissions
ls -la libexample.a

# Add read permission
chmod +r libexample.a

# Add read-write permission if modifying
chmod +rw libexample.a

# If owned by another user, use sudo
sudo ar r libexample.a module.o
```

## Symbol Table Issues

### Linker Cannot Find Symbol

**Symptom:** Linker says symbol is undefined when it's in archive.

**Cause:** Symbol table is out of date.

**Fix:**

```bash
# Rebuild symbol table
ar s libexample.a

# Verify symbols are present
nm libexample.a | grep symbol_name

# If not present, add the member
ar r libexample.a missing.o
ar s libexample.a

# Re-link program
gcc -o program main.c libexample.a
```

### Ranlib vs ar s

**Note:** On some systems, `ranlib` is used instead of `ar s`:

```bash
# Both do the same thing (rebuild symbol table)
ar s libexample.a
# Or
ranlib libexample.a

# ar s is preferred (modern approach)
```

## Member Conflicts

### Member with Same Name Already Exists

**Symptom:** Adding duplicate member names causes issues.

**Cause:** Archive contains multiple files with same name (rare).

**Fix:**

```bash
# List detailed members
ar tv libexample.a

# Delete old member first
ar d libexample.a old_module.o

# Then add new one
ar r libexample.a new_module.o

# Rebuild symbol table
ar s libexample.a
```

## Archive Corruption

### Corrupted Archive Detection

```bash
# Try to extract
ar x libexample.a
# If this fails, archive may be corrupted

# Rebuild archive from backup members
ar d libexample.a *
# Delete all members

# Or create new archive
ar rcs libexample_new.a *.o

# Verify new archive
nm libexample_new.a
```

### Partial Extraction on Corruption

```bash
# Extract members individually
for member in $(ar t libexample.a); do
  if ar p libexample.a "$member" > "$member"; then
    echo "Extracted: $member"
  else
    echo "Failed: $member"
  fi
done
```

## Linking Issues

### Undefined Reference During Link

**Symptom:** `undefined reference to 'function_name'`

**Cause:** Function not in archive or symbol table outdated.

**Fix:**

```bash
# Check if symbol exists
nm libexample.a | grep function_name

# If not present, add containing module
ar r libexample.a missing_module.o

# Rebuild symbol table
ar s libexample.a

# Verify link order (archive must come after .o files that use it)
gcc -o program main.o libexample.a  # CORRECT

# Not this:
gcc -o program libexample.a main.o  # May fail with some linkers
```

### Circular Dependencies

**Symptom:** Linker errors with interdependent modules.

**Cause:** Circular symbol references between archive members.

**Fix:**

```bash
# List dependencies
nm libexample.a

# For circular deps, try:
# 1. Reorder members
# 2. Link archive multiple times
gcc -o program main.o -lmylib -lmylib

# Or use whole archive (may link unused symbols)
gcc -o program main.o -Wl,--whole-archive libmylib.a -Wl,--no-whole-archive
```

## Platform-Specific Issues

### Object File Architecture Mismatch

**Symptom:** Linking fails with mismatched architecture.

**Cause:** Archive contains 32-bit objects being linked with 64-bit target.

**Fix:**

```bash
# Check archive object architecture
file libexample.a
ar t libexample.a | head -1 | xargs file

# Recompile objects for correct architecture
gcc -m64 -c module.c -o module.o  # 64-bit
gcc -m32 -c module.c -o module.o  # 32-bit

# Rebuild archive
ar rcs libexample.a *.o
```

### Long Filename Handling

**Symptom:** Member names truncated in archive.

**Cause:** ar has 16-character member name limit in some formats.

**Fix:**

```bash
# Use shorter filenames
# Rename: very_long_filename.o → short.o

# Create archive with GNU ar (handles longer names better)
# Or use file lists instead of direct paths

# Check actual member names
ar tv libexample.a
```

## Testing and Validation

### Verify Archive Integrity

```bash
# Extract and check all members
ar x libexample.a

# Check extracted files match timestamps
ar tv libexample.a  # Compare with:
ls -la *.o

# Rebuild and compare sizes
ar rcs libexample_test.a *.o
du -h libexample.a libexample_test.a
```

### Validate Symbol Table

```bash
# Check symbol count
nm libexample.a | wc -l

# Look for undefined symbols
nm libexample.a | grep ' U '

# Verify symbol table is in archive
ar t libexample.a | head -1
# Should not show "__.SYMDEF" (that's old format)
```

## Resources

- ar Manual: <https://sourceware.org/binutils/docs/binutils/ar.html>
- GNU Linker Manual: <https://sourceware.org/binutils/docs/ld/>
