# tail Advanced Usage

## GNU vs BSD Differences

### Line Number Syntax

```bash
# Both GNU and BSD support:
tail -n 10 file.txt          # Last 10 lines

# GNU extension: relative to end
tail -n +10 file.txt         # Lines 10 to end (all except first 9)

# BSD also supports this syntax
tail -n +10 file.txt         # Works on BSD too
```

### Follow Mode Behavior

```bash
# Both support -f (follow mode)
tail -f file.txt

# Both support -F (follow by filename, survives rotation)
tail -F /var/log/app.log

# Key difference: behavior after file truncation/rotation
# GNU: -F reopens file by name
# BSD: -F also reopens by name (similar behavior)
```

### Byte Counting

```bash
# Both GNU and BSD support byte extraction
tail -c 100 file.txt         # Last 100 bytes

# GNU supports negative byte counts (all except last N)
tail -c +100 file.txt        # All bytes from byte 100 onward
```

## Follow Mode Details

### Basic Follow

```bash
# Follow file indefinitely
tail -f app.log

# Exit after following for specific count
tail -n 20 -f app.log  # Show last 20 lines, then follow

# Useful for active monitoring
tail -f /var/log/syslog
```

### Follow with Rotation

```bash
# For logs that rotate (rename/compress)
# -f may stop following if file is rotated

# -F (follow by filename) is more robust
tail -F /var/log/app.log

# Recommended for production log monitoring
# Survives: file rotation, truncation, recreation
```

### Follow Mode Best Practices

```bash
# Set bounded startup context
tail -n 50 -F /var/log/app.log
# Shows last 50 lines, then follows new appends

# Without startup context (may miss recent activity)
tail -F /var/log/app.log  # Default 10 lines

# Monitor multiple files with clear separation
tail -n 10 -f file1.log file2.log
# Output includes:
# ==> file1.log <==
# [content]
# ==> file2.log <==
# [content]
```

## Large File Handling

### Efficiency

tail seeks to end of file (efficient even for very large files):

```bash
# Safe on multi-gigabyte files
tail -n 100 /path/to/huge/file.log
# Seeks to end, reads backward for line boundaries
# Performance: O(N) where N = lines to extract (not file size)
```

### Performance Considerations

```bash
# Byte extraction is faster (exact position in file)
time tail -c 100000 huge.bin > /dev/null

# Line extraction requires backward line scanning
time tail -n 1000 huge.log > /dev/null
```

## Partial Line Handling

When using `-c` (bytes), output may end mid-line:

```bash
# If file ends: "line content here"
# And you ask for last 10 bytes
tail -c 10 file.txt
# Output: "content h" (incomplete)

# Subsequent processing expecting complete lines may fail
# Solution: combine with line extraction first
tail -n 5 file.txt | tail -c 100
```

## Combining with Other Tools

### Pipeline Processing

```bash
# Extract last 100 lines and count errors
tail -n 100 app.log | grep "ERROR" | wc -l

# Monitor for errors in real-time
tail -f app.log | grep "ERROR"

# Show last 50 lines and page through
tail -n 50 app.log | less
```

### Monitoring Multiple Sources

```bash
# Watch multiple log files
tail -f app.log worker.log scheduler.log

# Merge and follow multiple files
tail -f *.log

# Follow with filtering
tail -f app.log | grep -E "ERROR|FATAL"
```

## Exit Codes and Error Handling

```bash
# Exit 0: Success
tail -n 5 file.txt
echo $?  # 0

# Exit 1: Error (file not found, permission denied, etc.)
tail -n 5 /nonexistent
echo $?  # 1
```

### Usage in Scripts

```bash
#!/bin/bash

if tail -n 100 logfile.log > /tmp/recent.log 2>&1; then
  echo "Successfully extracted last 100 lines"
  # Process /tmp/recent.log
else
  echo "Error reading file"
  exit 1
fi
```

## Scripting Patterns

### Monitor with Timeout

```bash
#!/bin/bash

# Follow log for 30 seconds, then stop
timeout 30 tail -f app.log
```

### Extract and Transform

```bash
# Extract last lines and process
tail -n 1000 app.log | \
  awk -F',' '{print $1, $3, $5}' | \
  sort | uniq -c
```

### Monitor Application Startup

```bash
#!/bin/bash

# Follow log until specific success message appears
tail -f app.log | grep -q "Application started successfully" && echo "Done!"
```

## Resources

- `man tail` — Full manual and options
- GNU Coreutils: <https://www.gnu.org/software/coreutils/manual/html_node/tail-invocation.html>
- BSD tail: <https://www.freebsd.org/cgi/man.cgi?query=tail>
