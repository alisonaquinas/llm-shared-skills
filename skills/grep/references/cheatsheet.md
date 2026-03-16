# grep / ag Cheatsheet

## Choosing between grep and ag

| Situation | Use |
| --- | --- |
| Recursive code/directory search | **ag** (faster, respects .gitignore, grouped output) |
| Pipeline filtering (`cmd \| grep`) | **grep** (ag doesn't read stdin in standard mode) |
| ag not installed | **grep -r** with `--include` globs |
| PCRE regex | **ag** (uses PCRE by default) or `grep -P` (GNU) |
| Fixed-string search | `grep -F` or `ag -Q` |

## ag (Silver Searcher) common flags

| Flag | Meaning |
| --- | --- |
| `-i` | Case-insensitive |
| `-l` | List matching files only |
| `-c` | Count matches per file |
| `-n` | Show line numbers (default on) |
| `-C N` | Show N lines of context |
| `-A N` / `-B N` | Lines after / before match |
| `-w` | Whole-word match |
| `-Q` | Fixed string (no regex) |
| `-G PATTERN` | Restrict to files matching filename regex |
| `--<type>` | Restrict to file type (e.g. `--python`, `--js`) |
| `--ignore-dir=DIR` | Exclude directory |
| `--hidden` | Search hidden files and directories |
| `-s` / `-S` | Case-sensitive / smart-case |

## grep common flags

| Flag | Meaning |
| --- | --- |
| `-i` | Case-insensitive |
| `-r` / `-R` | Recursive directory search |
| `-l` | List matching files only |
| `-c` | Count matching lines per file |
| `-n` | Show line numbers |
| `-v` | Invert: lines that do NOT match |
| `-w` | Whole-word match |
| `-x` | Whole-line match |
| `-F` | Fixed string (no regex interpretation) |
| `-E` | Extended regex (ERE): `+`, `?`, `\|`, `()` without backslash |
| `-P` | Perl-compatible regex (GNU only) |
| `-o` | Print only the matched portion |
| `-A N` / `-B N` / `-C N` | Lines after / before / around match |
| `--include=GLOB` | Restrict to filenames matching glob (GNU) |
| `--exclude-dir=DIR` | Skip directory |
| `-m N` | Stop after N matching lines |

## Common invocations

```bash
# ag — recursive search
ag "pattern"                            # Search from current directory
ag -i "pattern" /path/                  # Case-insensitive in a path
ag -l "pattern"                         # Files with matches only
ag -c "pattern"                         # Count per file
ag -C 3 "pattern"                       # 3 lines of context
ag --python "pattern"                   # Python files only
ag -G '\.ya?ml$' "pattern"             # YAML files only
ag -Q "literal.string"                  # No regex
ag --ignore-dir=vendor "pattern"        # Exclude vendor/

# grep — pipeline + file search
grep "pattern" file.txt                 # Single file
grep -r "pattern" dir/                  # Recursive
grep -ri "pattern" dir/                 # Case-insensitive recursive
grep -rn "pattern" dir/                 # With line numbers
grep -rl "pattern" dir/                 # Files only
grep -v "pattern" file                  # Invert match
grep -F "literal" file                  # Fixed string
grep -E "err(or)?" file                 # Extended regex
grep -P "^\d{4}-\d{2}" file            # Perl regex (GNU)
grep -o "[0-9]\+" file                  # Print matched part only
grep -A 2 -B 2 "pattern" file          # Context lines
grep --include="*.py" -r "pattern" .   # Python files only
command | grep -v "^#"                  # Filter comments from output
```
