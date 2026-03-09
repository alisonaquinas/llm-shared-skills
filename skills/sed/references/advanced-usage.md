# sed Advanced Usage

## Address Ranges and Patterns

### Line Numbers

```bash
# Specific line
sed -n '10p' file.txt          # Line 10 only

# Line range
sed -n '10,20p' file.txt       # Lines 10 through 20

# From line to end
sed -n '50,$p' file.txt        # Lines 50 to end of file

# Every Nth line (step)
sed -n '1~3p' file.txt         # Lines 1, 4, 7, 10... (GNU only)
```

### Pattern-Based Addresses

```bash
# Lines matching pattern
sed -n '/ERROR/p' file.txt     # Lines containing ERROR

# Lines NOT matching pattern
sed -n '/ERROR/!p' file.txt    # Lines without ERROR

# Between two patterns
sed -n '/START/,/END/p' file.txt   # From START to END (inclusive)

# Pattern to line number
sed -n '/ERROR/,100p' file.txt     # From first ERROR to line 100

# Line number to pattern
sed -n '10,/END/p' file.txt        # From line 10 to first END
```

## Substitution Advanced

### Address + Substitution

```bash
# Substitute only on matching lines
sed '/ERROR/s/old/new/g' file.txt

# Substitute everywhere except matching lines
sed '/SKIP/!s/old/new/g' file.txt

# Substitute only on lines 10-20
sed '10,20s/old/new/g' file.txt

# Substitute only on last line
sed '$s/old/new/' file.txt
```

### Special Characters in Replacements

```bash
# Use & to reference matched text
sed 's/[0-9]\+/[&]/' file.txt
# "123" becomes "[123]"

# Use captured groups (requires -E or -r)
sed -E 's/([a-z]+)_([0-9]+)/\2-\1/' file.txt
# "var_123" becomes "123-var"

# Multiple groups
sed -E 's/(.)(.)(.)/<\3><\2><\1>/' file.txt
# "abc" becomes "<c><b><a>"
```

### Delimiters

```bash
# Use different delimiter to avoid escaping /
sed 's|/path/to/old|/path/to/new|g' file.txt

# Use # as delimiter
sed 's#old#new#g' file.txt

# Use @ as delimiter
sed 's@pattern@replacement@g' file.txt
```

### Case Conversion (GNU only)

```bash
# Convert to uppercase
sed 's/\(.*\)/\U\1/' file.txt

# Convert to lowercase
sed 's/\(.*\)/\L\1/' file.txt

# Capitalize first letter (GNU only)
sed 's/\b\(.\)/\U\1/g' file.txt
```

## Multi-Line Patterns

### Hold Space (Advanced)

The hold space is a buffer separate from the pattern space:

```bash
# Swap pattern and hold spaces
sed -n 'N;s/\n/ /p' file.txt
# Joins consecutive lines with space

# Reverse line order (classic example)
sed '1!G;h;$!d' file.txt

# Double-space a file
sed 'G' file.txt

# Strip trailing blank lines
sed -e :a -e '/^\s*$/d;N;ba' file.txt
```

### Joining Lines

```bash
# Join every 2 lines with space
sed 'N;s/\n/ /' file.txt

# Join every 3 lines with comma
sed 'N;N;s/\n/, /g' file.txt

# Join all lines
sed -z 's/\n/ /g' file.txt  # GNU only; -z uses NUL delimiter
```

### Appending and Prepending

```bash
# Append text after matching lines
sed '/ERROR/a\Alert sent' file.txt

# Prepend text before matching lines
sed '/ERROR/i\Priority: HIGH' file.txt

# Insert blank line after each line
sed 'a\' file.txt

# Insert blank lines after matching lines
sed '/pattern/a\' file.txt
```

## Deletion Strategies

### Basic Deletion

```bash
# Delete empty lines
sed '/^$/d' file.txt

# Delete lines with whitespace only
sed '/^[[:space:]]*$/d' file.txt

# Delete comment lines
sed '/^#/d' file.txt

# Delete first and last line
sed '1d;$d' file.txt

# Delete lines 2-10
sed '2,10d' file.txt
```

### Conditional Deletion

```bash
# Delete all but matching lines (keep ERROR lines only)
sed '/ERROR/!d' file.txt

# Delete after first match
sed '/START/,/END/d' file.txt

# Delete everything except between two patterns
sed -n '/START/,/END/p' file.txt
```

## Branching and Labels (Advanced)

### Labels and Jumps

```bash
# Branch to label on match (GNU)
sed '/ERROR/{
  h
  s/.*/Alert!/
  x
  b end
}
:end' file.txt
```

### Test Branch

```bash
# Execute commands only if substitution succeeded (GNU)
sed '/pattern/{ s/old/new/; T skip; d; :skip }' file.txt
```

## GNU vs BSD Differences

### Extended Regex Flag

```bash
# GNU sed: -r or -E
sed -E 's/([0-9]+)/NUM/' file.txt

# BSD sed: -E only (no -r)
sed -E 's/([0-9]+)/NUM/' file.txt
```

### In-Place Edit Suffix

```bash
# GNU sed: -i[SUFFIX] (space optional)
sed -i.bak 's/old/new/g' file.txt
sed -i '.bak' 's/old/new/g' file.txt  # Both work

# BSD sed: -i requires suffix immediately
sed -i.bak 's/old/new/g' file.txt  # Works
sed -i 's/old/new/g' file.txt      # Error on BSD
```

### GNU-Only Features

```bash
# Multi-file in-place edits
sed -i 's/old/new/g' file1.txt file2.txt file3.txt

# Addresses with step
sed -n '1~2p' file.txt  # Odd lines only

# Zero-terminated strings
sed -z 's/\n/,/g' file.txt

# Lowercase conversion
sed 's/.*/\L&/' file.txt  # Convert to lowercase
```

### Portable Patterns

```bash
# Avoid GNU extensions for cross-platform scripts
sed -n 's/old/new/p' file.txt  # Works everywhere

# Don't use:
# sed -r                    (Use sed -E instead, or rewrite regex)
# sed -z                    (Use other tools or manual handling)
# sed 's/.*/\L&/'           (Use tr or awk instead)
```

## Performance Optimization

### Lazy Evaluation

```bash
# Exit after first match (faster)
sed -n '/pattern/{p;q;}' file.txt

# Stop processing after Nth match
sed -n '/pattern/{p;N;N;q;}' file.txt
```

### Batch Processing

```bash
# Process multiple files sequentially
for file in *.log; do
  sed -i.bak 's/old/new/g' "$file"
done

# Or let sed handle multiple files (GNU)
sed -i.bak 's/old/new/g' *.log
```

### Large Files

```bash
# For very large files, consider awk instead
# sed with hold space on gigabyte files = slow
awk '{gsub(/old/, "new"); print}' file.txt > output.txt

# Or use specialized tools
sed 's/old/new/g' huge-file.txt | head -n 1000
```

## Real-World Examples

### Extract JSON Field

```bash
# Extract "name" field from JSON (crude, not recommended)
sed -n 's/.*"name": *"\([^"]*\)".*/\1/p' data.json
# Better: use jq
jq -r '.name' data.json
```

### Config File Processing

```bash
# Uncomment lines in config
sed 's/^# *//' config.conf

# Change variable value
sed 's/TIMEOUT=.*/TIMEOUT=300/' config.conf

# Add variable if missing (append to file)
sed '$ ! { /TIMEOUT=/!b
b
}
a\TIMEOUT=300' config.conf
```

### Log File Analysis

```bash
# Extract ERROR lines with context (3 lines after)
sed -n '/ERROR/{p;N;N;N;p;}' app.log

# Remove timestamps
sed 's/^[0-9-]* [0-9:]*\.[0-9]* //' app.log

# Count errors per type
sed -n 's/.*ERROR: \([^:]*\).*/\1/p' app.log | sort | uniq -c
```

### Batch File Transformation

```bash
# Convert DOS line endings to Unix
sed 's/\r$//' windows_file.txt > unix_file.txt

# Remove trailing whitespace
sed 's/[[:space:]]*$//' file.txt > trimmed.txt

# Convert multiple spaces to single space
sed 's/  */ /g' file.txt
```

## Resources

- `man sed` — Full manual and all options
- GNU sed: <https://www.gnu.org/software/sed/manual/>
- BSD sed: <https://www.freebsd.org/cgi/man.cgi?query=sed>
