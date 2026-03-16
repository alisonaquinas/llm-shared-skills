# grep / ag Troubleshooting

## grep matches the grep process itself

**Symptom:** `ps aux | grep foo` always shows a result because `grep foo` is also a process.

```bash
ps aux | grep foo | grep -v grep        # Exclude grep itself
pgrep -l foo                            # Use pgrep — does not self-match
ps aux | grep '[f]oo'                   # Bracket trick: regex does not match itself
```

## No results when a match is expected

**Cause candidates:**

1. Special characters in pattern not escaped
2. Case mismatch
3. Binary file silently skipped
4. Wrong file or directory

```bash
grep -i "pattern" file              # Try case-insensitive
grep -F "literal.pattern" file      # Treat as fixed string (no regex)
grep -a "pattern" file              # Force text treatment (binary)
file suspicious.log                 # Check if file is binary
ag "pattern" --all-types            # ag: include binary files
```

## Regex metacharacters matching literally

**Symptom:** `grep "file.txt"` also matches `file_txt`, `filetxt`, etc.

`.` in regex means "any character".

```bash
grep -F "file.txt" log              # Fixed string: dot is literal
grep "file\.txt" log                # Escape the dot in regex
ag -Q "file.txt" log                # ag fixed string
```

## GNU flag not available on macOS

```bash
grep --version                      # Confirm GNU vs BSD

# -P (Perl regex) is not available in BSD grep
grep -P "\d+" file                  # Fails on macOS

# Alternatives on macOS
brew install grep                   # GNU grep as ggrep
ggrep -P "\d+" file                 # Use ggrep
ag "\d+" file                       # ag uses PCRE — works everywhere
```

## ag not respecting .gitignore

```bash
# Confirm ag finds the .gitignore
ag "pattern" --path-to-ignore /path/to/.gitignore

# Check that .gitignore is in a parent of the search dir
ls -la .gitignore
ag --list-file-types                # Confirm ag version/features
```

## Performance: grep is slow on a large directory tree

```bash
# Use ag instead (much faster, skips .git and ignored files)
command -v ag && ag "pattern" || grep -r "pattern" .

# Limit grep search depth
find . -maxdepth 3 -name "*.py" | xargs grep "pattern"

# Restrict file types with --include
grep -r --include="*.py" "pattern" .
```

## Encoding / locale issues

**Symptom:** grep skips lines with non-ASCII characters or gives wrong results.

```bash
export LANG=C grep "pattern" file   # Use byte-level matching
export LC_ALL=C grep "pattern" file # Override all locale settings
file -i suspicious.log              # Check encoding
```

## Accidental abort when no match found in a script

**Symptom:** Script exits with error code 1 when grep finds nothing, triggering `set -e`.

```bash
# Prevent exit on no-match
grep "pattern" file || true
grep "pattern" file || :

# Or check explicitly
if grep -q "pattern" file; then
    echo "found"
else
    echo "not found"
fi
```
