# diff Advanced Usage

## Recursive Directory Comparison

Compare entire directory trees with `-r`:

```bash
# Recursively compare two directories
diff -r /path/to/old /path/to/new

# Recursively compare, ignoring whitespace
diff -r -w /path/to/old /path/to/new

# Report only files that differ (not detailed diff)
diff -r -q /path/to/old /path/to/new
```

### Handling Missing Files

Use `-N` to treat absent files as empty during recursive comparison:

```bash
# Include new files in output (treat missing as empty)
diff -r -N /path/to/old /path/to/new
```

Without `-N`, missing files are simply reported as "only in" messages. With `-N`, you see the full file contents as additions.

## Ignore Patterns

### Whitespace Handling

- `-w`: Ignore all whitespace (spaces, tabs, newlines)
- `-b`: Ignore changes in the amount of whitespace
- `-B`: Ignore blank lines
- `--ignore-space-at-eol`: Ignore trailing whitespace only

```bash
# Configuration files often differ only in spacing
diff -w old.conf new.conf

# Log files with different indentation
diff -b logfile1 logfile2
```

### Blank Line Differences

```bash
# Ignore all blank line changes
diff -B old.py new.py

# Useful for Python, JSON, and other formatted languages
```

### Case Insensitive

```bash
# Useful for filenames on case-insensitive systems
diff -i old.txt new.txt
```

## Patch Generation and Application

### Creating Unified Patches

Unified format (`-u`) is the standard for patches:

```bash
# Generate patch (always old → new order)
diff -u original.txt modified.txt > changes.patch

# Create patch for entire directory
diff -u -r old-dir new-dir > full-changes.patch
```

### Applying Patches

```bash
# Test patch application first (no changes)
patch --dry-run < changes.patch

# Apply patch if test succeeds
patch < changes.patch

# Apply patch with validation
patch -p1 < changes.patch  # Strip 1 directory level

# Reverse a patch
patch -R < changes.patch
```

### Context Diffs

Context diffs (`-c`) are older but more human-readable:

```bash
# Generate context diff (3 lines of context by default)
diff -c original.txt modified.txt > changes.ctx

# Generate with custom context lines
diff -C 5 original.txt modified.txt > changes.ctx
```

## Three-Way Merge

Use `diff3` for merging two modified versions of a base file:

```bash
# Compare three files: base, version1, version2
diff3 base.txt modified1.txt modified2.txt

# Output shows conflicts marked with:
# <<<<<<< modified1.txt
# ... changes from modified1
# =======
# ... changes from modified2
# >>>>>>> modified2.txt
```

## Output Formats

### Unified Format (`-u`)

```diff
--- original   2025-03-09 10:00:00.000000000 -0800
+++ modified   2025-03-09 10:01:00.000000000 -0800
@@ -1,5 +1,6 @@
 line 1 (unchanged)
-line 2 (removed)
+line 2 (modified)
 line 3 (unchanged)
+line 4 (added)
```

### Context Format (`-c`)

```diff
*** original   2025-03-09 10:00:00.000000000 -0800
--- modified   2025-03-09 10:01:00.000000000 -0800
***************
*** 1,5 ****
  line 1
! line 2 (changed)
  line 3
--- 1,6 ----
  line 1
! line 2 (modified)
  line 3
+ line 4 (added)
```

### Normal Format (default)

```diff
1d0
< original line 1
3c2
< original line 3
---
> modified line 3
5a5
> new line 5
```

### Side-by-Side Format (`-y`)

```bash
# Show differences side-by-side
diff -y old.txt new.txt

# Suppress identical lines
diff -y --suppress-common-lines old.txt new.txt
```

## Performance Optimization

### Large Files

For very large files, specialized tools may be faster:

```bash
# Quick equality check (byte-by-byte, stops at first difference)
cmp file1 file2

# Summary comparison without line-by-line diff
diff -q file1 file2
```

### Limiting Output

```bash
# Stop after finding N differences
diff -q file1 file2  # Just report if different

# Limit context lines to reduce output
diff -u0 old.txt new.txt  # No context lines

# Show only files that differ (recursive)
diff -r -q dir1 dir2
```

## GNU vs BSD Differences

### GNU diff

- Extended options: `--new-file`, `--text`, `--binary`
- Color output: `--color=auto` (GNU diffutils)
- Timestamp handling more consistent

```bash
# GNU-specific: color output
diff --color=auto old.txt new.txt
```

### BSD diff

- Fewer extended options
- Default behavior may differ on line ending handling
- Some options use different syntax

```bash
# Test for GNU vs BSD
diff --version 2>/dev/null || echo "BSD diff"
```

## Scripting Integration

### Check Differences in Scripts

```bash
#!/bin/bash

if diff -q "$file1" "$file2" > /dev/null; then
  echo "Files are identical"
  exit 0
else
  echo "Files differ"
  diff -u "$file1" "$file2"
  exit 1
fi
```

### Generate Changeset for Version Control

```bash
# Create dated patch file
timestamp=$(date +%Y%m%d-%H%M%S)
diff -u old/ new/ > "changes-${timestamp}.patch"

# Apply with logging
if patch --dry-run < "changes-${timestamp}.patch" > /tmp/patch-test.log 2>&1; then
  patch < "changes-${timestamp}.patch"
  echo "Patch applied successfully"
else
  echo "Patch application failed; see /tmp/patch-test.log"
fi
```

### Batch Processing

```bash
# Find differences across multiple file pairs
for original in *.old; do
  modified="${original%.old}.new"
  if [ -f "$modified" ]; then
    echo "Comparing $original to $modified:"
    diff -u "$original" "$modified" | head -20
  fi
done
```

## Edge Cases

### Files with Very Long Lines

diff works with very long lines but output becomes unwieldy. Consider preprocessing:

```bash
# Use wc to check line lengths first
wc -L old.txt new.txt

# Limit output width
diff old.txt new.txt | cut -c 1-200
```

### Symbolic Links

diff compares link targets, not the links themselves:

```bash
# diff follows symlinks by default
# To compare symlinks as objects, use specialized tools
ls -l  # See symlink targets
```

### Empty Files

```bash
# Comparing with empty file shows full content of non-empty
diff empty.txt full.txt
# Output shows all lines of full.txt as additions
```

## Resources

- `man diff` — Full manual
- `man patch` — Patch application
- `man diff3` — Three-way merge
- GNU Coreutils: <https://www.gnu.org/software/diffutils/manual/>
