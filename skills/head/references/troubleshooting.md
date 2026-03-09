# head Troubleshooting

## Exit Code Reference

| Code | Meaning | Script Usage |
| --- | --- | --- |
| 0 | Success (file read, N lines/bytes extracted) | Script continues |
| 1 | Error (file not found, permission denied, etc.) | Abort and report |

## Common Errors and Solutions

### Error: "No such file or directory"

**Message:** `head: cannot open 'file.txt' for reading: No such file or directory`

**Cause:** File doesn't exist or path is incorrect.

**Fix:**

```bash
# Verify file exists
ls -la file.txt

# Check path (relative vs absolute)
pwd
head -n 5 /full/path/to/file.txt

# Look for similarly-named files
find . -name "*file*" -type f
```

### Error: "Permission denied"

**Message:** `head: cannot open 'file.txt' for reading: Permission denied`

**Cause:** User lacks read permission on file.

**Fix:**

```bash
# Check permissions
ls -l file.txt

# Check ownership
ls -l file.txt | awk '{print $3, $4}'

# Add read permission if you own the file
chmod +r file.txt

# If owned by another user, use sudo (with caution)
sudo head -n 5 file.txt

# Or use a temporary copy
cat file.txt > /tmp/file.tmp
head -n 5 /tmp/file.tmp
```

### Error: "--version: illegal option"

**Message:** `head: --version: illegal option -- -`

**Cause:** Using BSD head (macOS default), which doesn't support `--version`.

**Fix:**

```bash
# Verify which head you have
which head
ls -l /usr/bin/head

# BSD head doesn't recognize --version, but still works
head -n 5 file.txt

# To check if it's GNU or BSD head
if head --version 2>&1 | grep -q "GNU"; then
  echo "GNU head"
else
  echo "BSD head"
fi

# If you need GNU head on macOS
brew install coreutils
ghead --version
```

### Error: "No space left on device" (when redirecting output)

**Message:** `head: write error: No space left on device`

**Cause:** Disk full when writing output to file.

**Fix:**

```bash
# Check disk space
df -h

# Clean up space
rm /path/to/large/temp/files

# Use different output location
head -n 1000 huge.log > /mnt/larger/disk/output.txt

# Pipe to another tool instead of file
head -n 1000 huge.log | process_data
```

## No Output Issues

### Symptom

Running `head -n 5 file.txt` produces no output.

### Causes and Solutions

#### File is completely empty

```bash
# Check file size
ls -la file.txt
wc -l file.txt

# Verify it has content
cat file.txt
```

#### File has fewer lines than requested

```bash
# Requesting 5 lines from 3-line file
head -n 5 short.txt
# Outputs all 3 lines (not an error)

# Verify line count
wc -l short.txt
```

#### Binary file with no newlines

```bash
# Binary files may not have line separators
file binary.bin
hexdump -C binary.bin | head

# Use byte extraction instead of line extraction
head -c 256 binary.bin | xxd
```

#### stdin not connected

```bash
# head waiting for input from stdin
head -n 5
# (waiting for input; press Ctrl+C to abort)

# Provide input
echo "data" | head -n 1

# Or specify a file
head -n 5 file.txt
```

## Garbled or Corrupted Output

### Symptom (Garbled Output)

Output contains weird characters or appears corrupted.

### Causes and Solutions (Garbled Output)

#### Binary data as text

```bash
# Trying to read binary as text
head -c 100 binary.bin
# Output: garbled characters

# View binary data safely
head -c 100 binary.bin | xxd

# Or use od
head -c 100 binary.bin | od -c
```

#### Encoding mismatch

```bash
# File in ISO-8859-1, terminal expects UTF-8
# Output appears corrupted

# Check file encoding
file file.txt
# Output: "file.txt: ISO-8859-1 Unicode text"

# Convert before viewing
iconv -f ISO-8859-1 -t UTF-8 file.txt | head -n 5
```

#### Terminal width too narrow

```bash
# Long lines wrap and output looks confused
head -n 5 long_lines.txt | cut -c 1-80

# Or set terminal width
stty cols 200
head -n 5 long_lines.txt
```

## Unexpected File Header Output

### Symptom (File Headers)

When reading multiple files, output includes file markers like `==> file1.txt <==`.

### Cause

Default behavior of head with multiple files is to show file headers.

### Solution

Use `-q` (quiet) to suppress file headers:

```bash
# With headers (default)
head -n 3 file1.txt file2.txt
# Output:
# ==> file1.txt <==
# [content]
# ==> file2.txt <==
# [content]

# Without headers (quiet)
head -q -n 3 file1.txt file2.txt
# Output:
# [content from file1]
# [content from file2]
```

## Incomplete Line at EOF

### Symptom (Incomplete Lines)

When using `-c` (byte count), output ends in middle of a line.

### Cause (Incomplete Lines)

Byte counting doesn't respect line boundaries.

```bash
# File content: "Hello World\nSecond Line"
head -c 10 file.txt
# Output: "Hello Worl" (incomplete)
```

### Solution (Incomplete Lines)

```bash
# Extract by lines first, then limit bytes
head -n 5 file.txt | head -c 100

# Or accept incomplete output as-is
head -c 100 file.txt | tr -d '\0'
```

## Performance Issues

### Symptom (Performance)

head seems slow or unresponsive.

### Causes and Solutions (Performance)

#### Reading from slow storage

```bash
# Network file system or slow disk
# head still works; may just be slow

# Monitor progress with strace
strace -e read head -n 5 /mnt/slow/network/file

# Consider caching locally
cp /slow/file /tmp/file.tmp
head -n 5 /tmp/file.tmp
```

#### Very large line counts

```bash
# Requesting huge number of lines
head -n 1000000000 file.txt  # May take time

# Use line count first to find realistic number
wc -l file.txt
```

#### Piped input source is slow

```bash
# Piped source is slow (curl, database query, etc.)
curl https://slow.api/data | head -n 100
# head terminates after 100 lines, but pipe source may still be running

# This is normal and expected behavior
```

## Platform Differences

### macOS (BSD head)

- Doesn't support `--version` flag
- Doesn't support `-n -N` (all except last N)
- Basic options work identically to GNU

### Linux (GNU head)

- Full option support
- `--version` available
- `-n -N` for "all except last N"

### Windows (Git Bash, WSL2, Cygwin)

- Git Bash: includes GNU head
- WSL2: uses Linux (GNU head by default)
- Cygwin: can install GNU head

### Workaround for Portability

```bash
#!/bin/bash

# Detect platform and adjust
if head --version 2>&1 | grep -q "GNU"; then
  # GNU head - full options available
  head -n -5 file.txt  # All except last 5
else
  # BSD head - use tail instead
  tail -n +6 file.txt  # All from line 6 onward
fi
```

## Scripting Issues

### head Not Found in Script

```bash
# Script fails with: command not found: head

# Cause: head not in PATH or not installed

# Fix: Use full path
/usr/bin/head -n 5 file.txt

# Or verify PATH
echo $PATH
which head

# Install if missing
apt-get install -y coreutils
```

### Exit Code Not Checked

```bash
# Bad: Script continues after error
head -n 5 /nonexistent && process_output
# "process_output" never runs (good)

# Explicitly handle errors
if ! head -n 5 "$file"; then
  echo "Failed to read file"
  exit 1
fi
```

## Resources

- `man head` — Full manual and options
- BSD head: <https://www.freebsd.org/cgi/man.cgi?query=head>
- GNU head: <https://www.gnu.org/software/coreutils/manual/html_node/head-invocation.html>
