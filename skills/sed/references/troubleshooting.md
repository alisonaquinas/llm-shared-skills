# sed Troubleshooting

## Exit Code Reference

| Code | Meaning | Script Usage |
| --- | --- | --- |
| 0 | Success (file processed) | Script continues |
| 1 | Error (bad regex, file not found, etc.) | Abort and report |

## Common Errors and Solutions

### Error: "sed: bad option"

**Message:** `sed: bad option -- q` or `sed: illegal option -- E`

**Cause:** Using GNU-specific flag on BSD sed (or vice versa).

**Fix:**

```bash
# Check which sed you have
sed --version 2>&1 | grep -q GNU && echo "GNU" || echo "BSD"

# BSD sed: -E works, but no -r
sed -E 's/[0-9]+/NUM/' file.txt

# GNU sed: both -E and -r work
sed -E 's/[0-9]+/NUM/' file.txt

# Portable: use -E (works on both)
sed -E 's/[0-9]+/NUM/' file.txt
```

### Error: "sed: unterminated `s' command"

**Message:** `sed: unterminated 's' command` or `sed: unterminated 's' command: 's/old...`

**Cause:** Mismatched delimiters in substitution command.

**Fix:**

```bash
# Missing closing delimiter
sed 's/old/new file.txt  # Missing final /

# Correct version
sed 's/old/new/' file.txt

# If delimiter appears in pattern, use different delimiter
sed 's|/path/to/old|/path/to/new|' file.txt

# Escape delimiter if used in pattern
sed 's/\/path\/to\/old/\/path\/to\/new/' file.txt
```

### Error: "No such file or directory"

**Message:** `sed: can't read file.txt: No such file or directory`

**Cause:** File doesn't exist or path is incorrect.

**Fix:**

```bash
# Verify file exists
ls -la file.txt

# Check path (relative vs absolute)
pwd
sed 's/old/new/' /full/path/to/file.txt

# Look for similarly-named files
find . -name "*file*" -type f
```

### Error: "Permission denied" (in-place edit)

**Message:** `sed: can't rename file.txt to file.txt.bak: Permission denied`

**Cause:** Insufficient write permissions on directory or file.

**Fix:**

```bash
# Check permissions
ls -l file.txt
ls -ld $(dirname file.txt)

# Add write permission to directory
chmod u+w $(dirname file.txt)

# Add write permission to file
chmod u+w file.txt

# Or use sudo (with caution)
sudo sed -i.bak 's/old/new/g' file.txt

# Or process with output redirect
sed 's/old/new/g' file.txt > file.txt.tmp && mv file.txt.tmp file.txt
```

### Error: "sed: bad option for -i"

**Message:** `sed: bad option for -i` or `sed: 1: "s/old/new/":`

**Cause:** Wrong syntax for in-place editing (BSD vs GNU difference).

**Fix:**

```bash
# BSD sed requires suffix immediately after -i
sed -i.bak 's/old/new/' file.txt  # Correct

# These fail on BSD:
sed -i .bak 's/old/new/' file.txt     # Space between -i and suffix
sed -i 's/old/new/' file.txt          # No backup suffix

# GNU sed accepts both
sed -i.bak 's/old/new/' file.txt      # Works on GNU
sed -i '.bak' 's/old/new/' file.txt   # Works on GNU
sed -i 's/old/new/' file.txt          # Works on GNU (no backup)
```

## Regex Escaping Issues

### Symptom

Substitution doesn't work or produces unexpected output.

### Causes and Solutions

#### Unescaped Special Characters

```bash
# Forward slash in pattern must be escaped
sed 's/\/home\/user/\/var\/user/' file.txt

# Better: use different delimiter
sed 's|/home/user|/var/user|' file.txt

# Backslash in pattern
sed 's/old\\value/new\\value/' file.txt

# Dollar sign (end of line marker)
sed 's/end$/.txt/' file.txt
```

#### Ampersand (&) in Replacement

```bash
# & refers to matched text
sed 's/[0-9]\+/NUM/' file.txt  # "123" → "NUM"

# Use & to reference match
sed 's/[0-9]\+/[&]/' file.txt  # "123" → "[123]"

# Escape & if you want literal &
sed 's/test/\&/' file.txt  # "test" → "&"
```

#### Extended Regex Issues

```bash
# Basic regex: parentheses are literal
sed 's/(abc)/def/' file.txt  # Matches literal "(abc)"

# Extended regex: parentheses create groups
sed -E 's/(abc)/\1def/' file.txt  # Groups and backreferences

# Wrong: mixing basic and extended regex
sed 's/\([0-9]+\)/NUM/' file.txt  # Doesn't work (+ needs -E)

# Correct: use -E with extended regex
sed -E 's/([0-9]+)/NUM/' file.txt  # Works
```

#### Backreference Confusion

```bash
# Backreferences in basic regex use \1, \2, etc.
sed 's/\([a-z]*\)-\([0-9]*\)/\2:\1/' file.txt
# "abc-123" becomes "123:abc"

# In extended regex, no escaping on groups
sed -E 's/([a-z]*)-([0-9]*)/\2:\1/' file.txt
# Same result
```

## In-Place Edit Failures

### File Not Modified

**Symptom:** File size unchanged after in-place edit.

**Cause:** Pattern didn't match any lines.

**Fix:**

```bash
# Test substitution without -i first
sed 's/old/new/g' file.txt | head

# Verify pattern matches
grep 'old' file.txt

# Check exact case
sed 's/OLD/new/g' file.txt  # Case-sensitive

# Use case-insensitive matching (GNU)
sed 's/old/new/gi' file.txt

# Or use tr for case-insensitive
tr '[:upper:]' '[:lower:]' < file.txt | sed 's/old/new/g'
```

### Partial Modifications

**Symptom:** Some files in directory were modified, others weren't.

**Cause:** Mixed results due to script errors or permission issues.

**Fix:**

```bash
# Process files one at a time with validation
for file in *.txt; do
  if sed 's/old/new/g' "$file" > "${file}.tmp"; then
    mv "${file}.tmp" "$file"
  else
    echo "Error processing $file"
    rm "${file}.tmp"
  fi
done

# Or use find with -exec
find . -name "*.txt" -type f -exec \
  sed -i.bak 's/old/new/g' {} \;
```

### No Backup Created

**Symptom:** Used `-i.bak` but no `.bak` file created.

**Cause:** Modification failed or script had error.

**Fix:**

```bash
# Test syntax first
sed -n 's/old/new/p' file.txt

# If no error, try with backup
sed -i.bak 's/old/new/g' file.txt
ls -la file.txt*  # Check for .bak file

# Check permissions
ls -l file.txt
chmod u+w file.txt
```

## Large File Performance

### Slow Execution or Memory Issues

sed runs very slowly or uses excessive memory.

### Performance Solutions

#### Multi-line Hold Space

```bash
# Hold space operations are slow on large files
# Avoid patterns like:
sed -n 'N;s/\n/ /p' huge.log  # Very slow

# Use awk instead for better performance
awk '{printf "%s ", $0} NR % 2 == 0 {print ""}' huge.log

# Or use paste
paste -d ' ' - - < huge.log
```

#### Large Output

```bash
# If substitution creates huge output
sed 's/tiny/huge_replacement_string/' huge.log

# Process in chunks
split -l 1000000 huge.log part
for file in part*; do
  sed 's/old/new/g' "$file" > "${file}.out"
done
cat part*.out > output.log
```

#### Complex Regex on Large Files

```bash
# Complex regex scanning large files
sed 's/\(.*\)\(.*\)\(.*\)/\3-\2-\1/' huge.log

# Use awk for better performance
awk '{print $3, $2, $1}' huge.log
```

## Character Encoding Issues

### Garbled Output or Silent Failures

Output contains garbled characters or sed fails silently.

### Encoding Mismatch

File encoding doesn't match terminal/sed expectations.

### Detection

```bash
# Check file encoding
file -i file.txt

# Check locale
locale
echo $LANG

# View byte patterns
od -c file.txt | head
```

### Solutions

#### Option 1: Convert encoding

```bash
# Convert from ISO-8859-1 to UTF-8
iconv -f ISO-8859-1 -t UTF-8 file.txt > file-utf8.txt
sed 's/old/new/g' file-utf8.txt
```

#### Option 2: Set locale before sed

```bash
# Force UTF-8 locale
export LC_ALL=en_US.UTF-8
sed 's/old/new/g' file.txt
```

#### Option 3: Handle UTF-8 multibyte characters

```bash
# sed treats bytes, not characters
# UTF-8 multibyte characters may be split

# Process line-by-line to preserve encoding
while IFS= read -r line; do
  echo "$line" | sed 's/old/new/g'
done < file.txt
```

## Multiple Script Issues

### Issue with `-e` Ordering

Using `-e` multiple times doesn't produce expected result.

### How Scripts Are Applied

Scripts are applied sequentially; earlier scripts affect input to later ones.

### Solution

```bash
# Each -e script is a separate edit command
sed -e 's/a/b/' -e 's/b/c/' file.txt
# Result: all "a" become "c" (both scripts applied)

# Order matters
sed -e 's/foo/bar/' -e 's/bar/baz/' file.txt
# "foo" becomes "baz"

# Reverse order changes result
sed -e 's/bar/baz/' -e 's/foo/bar/' file.txt
# "foo" becomes "bar" (second script doesn't match)
```

## Platform Differences

### macOS (BSD sed)

- `--version` not supported
- `-i` requires suffix (no `-i` alone)
- Limited extended features

### Linux (GNU sed)

- `--version` works
- `-i` optional suffix
- Full extended features

### Workaround

```bash
#!/bin/bash

# Detect platform and adjust
if sed --version 2>&1 | grep -q GNU; then
  # GNU sed
  sed -i 's/old/new/g' file.txt
else
  # BSD sed
  sed -i '' 's/old/new/g' file.txt  # Empty string as suffix
fi
```

## Resources

- `man sed` — Full manual and options
- GNU sed: <https://www.gnu.org/software/sed/manual/>
- BSD sed: <https://www.freebsd.org/cgi/man.cgi?query=sed>
