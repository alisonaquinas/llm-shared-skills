# grep / ag Advanced Usage

## ag-specific features

### Smart case

ag uses smart-case by default: if the pattern contains any uppercase, the
search is case-sensitive; otherwise it is case-insensitive:

```bash
ag "error"          # Case-insensitive (no uppercase in pattern)
ag "Error"          # Case-sensitive (uppercase present)
ag -s "error"       # Force case-sensitive
ag -i "Error"       # Force case-insensitive
```

### File type filters

ag has built-in file type definitions:

```bash
ag --list-file-types            # Show all known types
ag --python "import os"         # Python source only
ag --js "require("              # JavaScript only
ag --html "class="              # HTML only
ag --yaml "host:"               # YAML only
```

### Search hidden files

```bash
ag --hidden "pattern"           # Include .dotfiles and .dotdirs
```

### Searching within a git repo with ag

```bash
ag "TODO"                       # Skips .git/ and all .gitignored paths
ag --skip-vcs-ignores "TODO"    # Include gitignored files
```

## Perl regex (grep -P) patterns

```bash
grep -P "^\d{4}-\d{2}-\d{2}" file      # ISO date lines
grep -P "\b\w+@\w+\.\w+\b" file        # Simple email pattern
grep -P "(?<=prefix)\w+" file           # Lookbehind assertion
grep -P "foo(?!bar)" file               # Negative lookahead
grep -oP '"key":\s*"\K[^"]+' file       # Extract JSON values
```

## Extracting matches with -o

```bash
# Print only matched portions
grep -oP '\d+\.\d+\.\d+\.\d+' access.log   # Extract IP addresses
grep -oP '"[^"]*"' config.json              # Extract quoted strings
ag -o '[A-Z]{3,}' file                      # Extract all-caps words
```

## Combining grep with other tools

```bash
# Count total matches (not lines)
grep -o "pattern" file | wc -l

# Search and open in editor
vim $(grep -rl "TODO" src/)

# List unique matching files sorted by count
grep -rc "pattern" . | sort -t: -k2 -rn | head -20

# Chain: find files, then grep within them
find . -name "*.conf" -exec grep -l "port" {} \;
```

## git grep (built-in for repos, no ag needed)

```bash
git grep "pattern"                  # Search working tree (respects .gitignore)
git grep -n "pattern"               # With line numbers
git grep "pattern" HEAD~5           # Search at a historical commit
git grep --count "pattern"          # Count per file
```

## Handling binary files

```bash
grep -a "pattern" binary.bin        # Force text treatment
grep -I "pattern" dir/              # Ignore binary files (GNU)
ag "pattern" --all-types            # Include binary files with ag
```

## Exit codes

| Code | Meaning |
| --- | --- |
| `0` | At least one match found |
| `1` | No match found |
| `2` | Error (bad option, file not found, etc.) |

In scripts, no-match (exit 1) is often expected and not an error:

```bash
# Do not exit the script when grep finds nothing
grep "pattern" file || true

# Distinguish no-match from error
grep "pattern" file
case $? in
  0) echo "found" ;;
  1) echo "not found" ;;
  *) echo "error" ;;
esac
```
