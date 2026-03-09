# diff Troubleshooting

## Exit Code Reference

| Code | Meaning | Script Usage |
| --- | --- | --- |
| 0 | Files are identical | `if diff -q file1 file2; then` |
| 1 | Files differ | Standard difference detected |
| 2 | Error (missing file, permission denied, etc.) | Must investigate cause |

## Common Errors and Solutions

### Error: "Permission denied"

**Message:** `diff: cannot open file1: Permission denied`

**Cause:** Insufficient read permissions on one or both files.

**Fix:**

```bash
# Check file permissions
ls -l file1 file2

# Add read permission if you own the file
chmod +r file1

# If owned by another user, use sudo (with caution)
sudo diff file1 file2

# Use a temporary copy with readable permissions (safest)
cat file1 > /tmp/file1.tmp
diff /tmp/file1.tmp file2
```

### Error: "No such file or directory"

**Message:** `diff: file1: No such file or directory`

**Cause:** Typo in filename or file doesn't exist.

**Fix:**

```bash
# Verify file exists
ls -la file1 file2

# Check for case sensitivity issues (especially macOS/Windows)
find . -name "file1" -o -name "FILE1"

# Verify full path if using relative paths
pwd
ls /full/path/to/file1
```

### Error: "Is a directory"

**Message:** `diff: dir1: Is a directory`

**Cause:** Attempting to diff a directory without `-r` flag.

**Fix:**

```bash
# Use -r for recursive directory comparison
diff -r dir1 dir2

# Or compare specific files within directories
diff dir1/file.txt dir2/file.txt
```

## Line Ending Differences (CRLF vs LF)

### Symptom

Every line appears to differ, even though content looks identical.

### Cause

Windows uses CRLF (`\r\n`), Unix/Linux use LF (`\n`). Git or file transfer may convert line endings.

### Detection

```bash
# View line endings (shows $ at end of each line)
cat -A file.txt

# Or use od to see exact bytes
od -c file.txt | grep -E '\\r|\\n'

# Detect CRLF vs LF
file file.txt  # May indicate "CRLF line terminators"
```

### Solutions

#### Option 1: Ignore whitespace in diff

```bash
diff -w file1 file2      # Ignore all whitespace
diff -b file1 file2      # Ignore blank line differences
diff --ignore-space-at-eol file1 file2  # Ignore trailing whitespace
```

#### Option 2: Normalize line endings first

```bash
# Convert CRLF to LF on macOS/Linux
dos2unix file1
dos2unix file2
diff file1 file2

# Convert LF to CRLF on macOS/Linux (less common)
unix2dos file1
unix2dos file2
diff file1 file2

# Using sed (works anywhere)
sed 's/\r$//' file1 > file1.tmp
sed 's/\r$//' file2 > file2.tmp
diff file1.tmp file2.tmp
rm file1.tmp file2.tmp
```

#### Option 3: Configure git to handle line endings

```bash
# Set git to normalize line endings on checkout
echo "* text=auto" > .gitattributes
git config core.safecrlf true

# Or for all files of a type
echo "*.sh text eol=lf" >> .gitattributes
```

## Binary File Detection and Handling

### Symptom (Binary Files)

Output: `Binary files file1 and file2 differ`

### Cause (Binary Files)

diff detects non-text (binary) files and refuses to show differences.

### Solutions (Binary Files)

#### Option 1: Force text comparison (may show garbage)

```bash
# View differences in binary files as text (messy)
diff --text file1.bin file2.bin

# Better: view hex comparison
diff <(xxd file1.bin) <(xxd file2.bin)
```

#### Option 2: Use binary-aware tools

```bash
# Byte-by-byte comparison (efficient)
cmp file1.bin file2.bin

# Hex dump side-by-side comparison
paste <(xxd file1.bin) <(xxd file2.bin) | less -S

# For images, use file-specific tools
identify file1.jpg file2.jpg
pnginfo file1.png file2.png
```

## Character Encoding Issues

### Symptom (Character Encoding)

Output contains garbled characters or mojibake (incorrect character rendering).

### Cause (Character Encoding)

File encoding (UTF-8, Latin-1, UTF-16, etc.) not matching system locale or diff doesn't handle it correctly.

### Detection (Character Encoding)

```bash
# Check file encoding
file file1.txt file2.txt

# View with locale info
locale

# Check file byte signature
xxd file1.txt | head -3
```

### Solutions (Character Encoding)

#### Option 1: Convert to UTF-8

```bash
# Convert from detected encoding to UTF-8
iconv -f ISO-8859-1 -t UTF-8 file1.txt > file1-utf8.txt
iconv -f ISO-8859-1 -t UTF-8 file2.txt > file2-utf8.txt
diff file1-utf8.txt file2-utf8.txt
```

#### Option 2: Set locale before diff

```bash
# Force UTF-8 locale
export LC_ALL=en_US.UTF-8
diff file1.txt file2.txt

# Or for specific locale
LANG=en_US.UTF-8 diff file1.txt file2.txt
```

#### Option 3: Ignore encoding differences

```bash
# If only character encoding differs, not content
iconv -f UTF-8 -t ASCII//TRANSLIT file1.txt > file1-ascii.txt
iconv -f UTF-8 -t ASCII//TRANSLIT file2.txt > file2-ascii.txt
diff file1-ascii.txt file2-ascii.txt
```

## Large File Performance

### Symptom (Performance)

diff runs slowly or consumes excessive memory on large files (>100 MB).

### Cause (Performance)

diff builds a full edit script internally; large files require significant memory.

### Solutions (Performance)

#### Option 1: Quick equality check (much faster)

```bash
# Stop at first difference without showing content
diff -q file1 file2

# Even faster: byte-by-byte binary compare
cmp file1 file2
```

#### Option 2: Compare smaller sections

```bash
# Split large files and compare sections
split -l 100000 large1.txt large1-part
split -l 100000 large2.txt large2-part
for i in a b c d; do
  diff large1-part$i large2-part$i
done
```

#### Option 3: Reduce diff output

```bash
# Minimal context (0 lines of surrounding context)
diff -u0 file1 file2

# Just report files that differ
diff -r -q large-dir1 large-dir2
```

## Patch Application Failures

### Symptom (Patch Application)

`patch: **** malformed patch` or `patch: Hunk FAILED`

### Causes

1. Wrong patch direction (applied in reverse)
2. File has been modified since patch was created
3. Line ending differences
4. Incorrect context lines (file changed at hunk location)

### Solutions (Patch Application)

#### Option 1: Test before applying

```bash
# Always use --dry-run first
patch --dry-run < changes.patch

# Review the output carefully
patch --dry-run -v < changes.patch
```

#### Option 2: Reverse a wrongly-applied patch

```bash
# If patch was applied in wrong direction, reverse it
patch -R < changes.patch

# Test reversal first
patch -R --dry-run < changes.patch
```

#### Option 3: Fix line ending before patching

```bash
# Normalize line endings first
dos2unix file.txt
patch < changes.patch
```

#### Option 4: Manual patching if automated fails

```bash
# Review what patch expects
cat changes.patch

# Manually edit the file to match expected state
# Then try patch again with reduced context matching (-l flag)
patch -l < changes.patch  # Fuzzier context matching
```

## Whitespace Confusion

### Symptom (Whitespace)

Small diffs appear when comparing similar-looking files, or expected diffs don't appear.

### Causes (Whitespace)

1. Trailing whitespace invisible in text editor
2. Tabs vs spaces mixed
3. Leading whitespace different

### Detection (Whitespace)

```bash
# Show invisible characters
cat -A file1.txt | head

# Compare with visibility
diff -w file1.txt file2.txt  # Ignores whitespace
diff file1.txt file2.txt     # Shows whitespace differences
```

### Solutions (Whitespace)

```bash
# Remove trailing whitespace
sed 's/[[:space:]]*$//' file.txt > file-trimmed.txt

# Convert tabs to spaces
expand -t 4 file.txt > file-spaces.txt

# Strip all leading/trailing whitespace
sed 's/^[[:space:]]*//;s/[[:space:]]*$//' file.txt > file-clean.txt

# Then compare
diff file1-clean.txt file2-clean.txt
```

## Platform Differences

### macOS (BSD diff)

- `--version` may not work; use `man diff` instead
- Some GNU options not available
- Default behavior may differ on line endings

### Linux (GNU diff)

- Full options support
- `--version` works
- More consistent across distros

### Windows (WSL2, Git Bash, Cygwin)

- Line ending handling differs between tools
- May need to use `--text` flag
- Symbolic links behave differently

### Workaround

```bash
# Detect platform and adjust flags
if diff --version 2>/dev/null | grep -q "GNU"; then
  # GNU diff - use full options
  diff --color=auto file1 file2
else
  # BSD diff - use basic options
  diff file1 file2
fi
```

## Exit Code in Scripts

### Incorrect: Mixing up exit codes

```bash
# BAD: Treats difference as error
if ! diff file1 file2; then
  echo "Files differ"  # This is printed even on legitimate differences
fi
```

### Correct: Check exit code properly

```bash
# GOOD: Exit 0 = identical, 1 = differ, 2 = error
if diff -q file1 file2 > /dev/null; then
  echo "Files are identical"
  exit 0
elif [ $? -eq 1 ]; then
  echo "Files differ"
  exit 1
else
  echo "Error comparing files"
  exit 2
fi
```

## Resources

- `man diff` — Full manual with all options
- `man patch` — Patch application details
- GNU Coreutils: <https://www.gnu.org/software/diffutils/manual/>
- POSIX standard: <https://pubs.opengroup.org/onlinepubs/9699919799/utilities/diff.html>
