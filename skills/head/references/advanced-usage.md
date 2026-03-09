# head Advanced Usage

## GNU vs BSD Differences

### GNU Extensions

GNU head supports several extensions not available in BSD:

```bash
# Print all lines except the last 5 (GNU only)
head -n -5 file.txt

# Print all bytes except the last 100 (GNU only)
head -c -100 file.bin

# These will fail or behave unexpectedly on BSD
```

### BSD Limitations

BSD head does not support:

- `head -n -5` (all except last N)
- `head -c -100` (all except last N bytes)
- Some GNU-specific options

### Portable Scripts

For cross-platform compatibility:

```bash
#!/bin/bash

# Good: Works on both GNU and BSD
head -n 5 file.txt

# Bad: GNU only, fails on macOS/BSD
head -n -5 file.txt

# Workaround for "all except last N" on BSD:
# Use tail instead
tail -n +6 file.txt  # All from line 6 onward (opposite of head -n 5)
```

## Large File Handling

### Memory Efficiency

head reads through the file sequentially and terminates early:

```bash
# Safe on multi-gigabyte files (stops after 5 lines)
head -n 5 /path/to/huge/file.log

# head does NOT load the entire file into memory
# Performance is O(N) where N = lines to read (not file size)
```

### Performance Considerations

```bash
# Byte counting is faster than line counting for text data
# Byte extraction (exact position in file)
time head -c 1000000 huge.bin > /dev/null

# Line extraction (must scan for newlines)
time head -n 1000 huge.bin > /dev/null
```

### Processing Streams

```bash
# head works efficiently on streams (pipes)
curl https://example.com/large/file.txt | head -n 100

# Stops reading after 100 lines (doesn't download full file)
```

## Partial Line Handling

When using `-c` (bytes), output may end mid-line:

```bash
# If file has line: "The quick brown fox"
# And you ask for first 10 bytes
head -c 10 file.txt
# Output: "The quick "  (incomplete line)

# Subsequent processing expecting complete lines may fail
# Solution: combine with line extraction first
head -n 5 file.txt | head -c 100
```

## Combining with Other Tools

### Hex Viewing

```bash
# Safe inspection of binary file start
head -c 256 binary.bin | xxd

# Shows first 256 bytes in hex format
```

### File Format Detection

```bash
# Check file magic bytes
head -c 4 file.bin | xxd

# Common magic bytes (first 4 bytes):
# ELF binary: 7f 45 4c 46
# ZIP file: 50 4b 03 04
# PNG image: 89 50 4e 47
```

### Pipeline Processing

```bash
# Extract headers from CSV files
head -n 1 data.csv

# Process first N records through tool
head -n 1000 huge.log | grep "ERROR"

# Count lines (stop after reading 100 lines)
head -n 100 file.txt | wc -l
```

### Parallel File Processing

```bash
# Extract first line from multiple files
for file in *.log; do
  echo "=== $file ==="
  head -n 1 "$file"
done

# Quiet mode avoids redundant headers
head -q -n 1 *.log
```

## Stream Redirection

### Handling Multiple Input Streams

```bash
# Reading from stdin (no filename argument)
cat file.txt | head -n 5

# Reading from file (faster, can seek)
head -n 5 file.txt

# Reading from multiple files
head -n 5 file1.txt file2.txt file3.txt

# Output includes file headers by default:
# ==> file1.txt <==
# [content]
# ==> file2.txt <==
# [content]
```

### Suppressing Headers

```bash
# Quiet mode (-q)
head -q -n 5 file1.txt file2.txt file3.txt
# Output: just the lines, no file markers

# Useful when combining multiple files
head -q -n 10 *.log | grep "ERROR"
```

### Forcing Headers

```bash
# Verbose mode (-v)
head -v -n 5 single_file.txt
# Output includes "==> single_file.txt <==" even for one file

# Useful for consistency in scripts
head -v -n 1 file.txt file2.txt | tee /tmp/headers.log
```

## Text Encoding Handling

### UTF-8 Multibyte Characters

head respects UTF-8 line boundaries:

```bash
# File with UTF-8 content
echo -e "Hello\nCafé\n世界" > utf8_file.txt

# head correctly outputs complete lines
head -n 2 utf8_file.txt
# Output: Hello
#         Café

# Byte counting (-c) may split UTF-8 characters
head -c 10 utf8_file.txt  # May cut Unicode char in half
```

### Handling Different Encodings

```bash
# Convert encoding before using head
iconv -f ISO-8859-1 -t UTF-8 file.txt | head -n 5

# Or use file-aware tools
file file.txt  # Shows encoding
```

## Exit Codes

head has simple exit behavior:

```bash
# Exit 0: Success (any output)
head -n 5 file.txt
echo $?  # 0

# Exit 1: Error (file not found, permission denied)
head -n 5 /nonexistent
echo $?  # 1
```

### Usage in Scripts

```bash
#!/bin/bash

if head -n 5 file.txt > /tmp/header.txt 2>&1; then
  echo "Successfully extracted first 5 lines"
  cat /tmp/header.txt
else
  echo "Error reading file"
  exit 1
fi
```

## Performance Profiling

### Comparing Approaches

```bash
# Time different methods for extracting first N lines:

# Method 1: head (fastest for large files)
time head -n 1000 huge.log > /dev/null

# Method 2: awk (flexible but slower)
time awk 'NR<=1000' huge.log > /dev/null

# Method 3: sed (slower still)
time sed -n '1,1000p' huge.log > /dev/null

# head is consistently fastest for this use case
```

### Memory Usage

```bash
# head uses constant memory (reads buffer-by-buffer)
# Safe on files of any size

# Monitor memory while processing
/usr/bin/time -v head -n 100000 huge.log > /dev/null
# Typical memory usage: ~1-10 MB regardless of file size
```

## Scripting Patterns

### Validate File Format

```bash
#!/bin/bash

# Check if file looks like JSON
if head -c 1 "$file" | grep -q '{'; then
  echo "Likely JSON file"
fi

# Check for CSV headers
if head -n 1 "$file" | grep -q 'id.*name.*email'; then
  echo "Likely CSV with email column"
fi
```

### Safe File Inspection

```bash
# Read first lines without loading full file
while IFS= read -r line; do
  echo "Header: $line"
done < <(head -n 5 "$file")
```

### Batch File Processing

```bash
# Extract headers from multiple files
for file in *.txt; do
  echo "Processing $file..."
  head -n 1 "$file" >> combined_headers.txt
done

# Process chunks in parallel
head -n 1000000 huge.log | split -l 10000 - chunk_

# Process chunks independently
for chunk in chunk_*; do
  worker_process "$chunk" &
done
wait
```

## Resources

- `man head` — Full manual and all options
- GNU Coreutils: <https://www.gnu.org/software/coreutils/manual/html_node/head-invocation.html>
- BSD head: <https://www.freebsd.org/cgi/man.cgi?query=head>
