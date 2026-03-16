---
name: grep
description: >
  Search file contents and pipeline output with grep (or ag when available)
  for pattern matching, log analysis, code search, and filtered pipelines.
  Use when the agent needs to find lines matching a pattern, search
  recursively through a directory, extract fields, count matches, or
  highlight occurrences. Prefer ag (the Silver Searcher) over grep for
  recursive code and text searches when ag is installed — it is faster,
  respects .gitignore automatically, and has cleaner output.
---

# grep

Search for patterns in files and streams. **When ag is available, prefer it
for recursive searches** — it is significantly faster, respects `.gitignore`
by default, and produces readable grouped output.

## Quick Start

1. Check if `ag` is available: `command -v ag`
2. If ag is available, use it for code/directory searches: `ag "pattern" .`
3. Use `grep` for pipeline filtering and when ag is not present: `grep "pattern" file`

## Intent Router

- `references/cheatsheet.md` — grep and ag common flags, recursive search, context lines, invert match, and count
- `references/advanced-usage.md` — Extended and Perl regex, multiline matching, binary files, ag-specific features, and scripting patterns
- `references/troubleshooting.md` — Fixed-string vs regex, special character escaping, binary matches, and cross-platform differences

## Core Workflow

### When ag is installed (preferred for directory/code search)

1. Search recursively: `ag "pattern"` (searches `.` by default, skips `.git` and ignored files)
2. Search specific file type: `ag --python "pattern"` or `ag -G '\.py$' "pattern"`
3. Show context: `ag -C 3 "pattern"`
4. Case-insensitive: `ag -i "pattern"`

### When using grep (pipeline filtering or ag unavailable)

1. Filter pipeline output: `command | grep "pattern"`
2. Recursive search: `grep -r "pattern" dir/`
3. Add context: `grep -C 2 "pattern" file`
4. Invert match: `grep -v "unwanted" file`

## Quick Command Reference

```bash
# ag (Silver Searcher) — prefer for recursive/code search
ag "pattern"                        # Recursive search from current dir
ag "pattern" /path/to/dir           # Search a specific directory
ag -i "pattern"                     # Case-insensitive
ag -l "pattern"                     # List matching files only
ag -c "pattern"                     # Count matches per file
ag -C 3 "pattern"                   # Show 3 lines of context
ag --python "pattern"               # Restrict to Python files
ag -G '\.txt$' "pattern"            # Restrict by filename regex
ag -w "word"                        # Whole-word match
ag --ignore-dir=vendor "pattern"    # Exclude a directory

# grep — pipeline filtering and fallback
grep "pattern" file.txt             # Search a file
grep -r "pattern" dir/              # Recursive search
grep -i "pattern" file              # Case-insensitive
grep -v "pattern" file              # Invert: lines that do NOT match
grep -n "pattern" file              # Show line numbers
grep -c "pattern" file              # Count matching lines
grep -l "pattern" dir/              # List files with matches
grep -E "regex+" file               # Extended regex (ERE)
grep -P "perl\d+regex" file         # Perl-compatible regex (GNU)
grep -F "literal.string" file       # Fixed string (no regex)
grep -A 2 -B 2 "pattern" file       # 2 lines after and before match
grep -o "pattern" file              # Print only the matched part
grep --include="*.py" -r "pat" .    # Restrict to file glob (GNU)
command | grep -v "^#"              # Filter comments from command output
man grep                            # Full manual
```

## When to use ag vs grep

| Task | Prefer |
| --- | --- |
| Recursive code/text search | **ag** (faster, respects .gitignore, grouped output) |
| Pipeline output filtering | **grep** (ag does not read stdin in standard mode) |
| ag not installed | **grep -r** with `--include` for type filtering |
| Fixed-string search in a file | `grep -F` or `ag -Q` |
| Perl-compatible regex | `grep -P` (GNU) or `ag` (uses PCRE by default) |

## Safety Notes

| Area | Guardrail |
| --- | --- |
| **Regex vs fixed string** | Dots, brackets, and other regex metacharacters in search patterns have special meaning. Use `-F` (grep) or `-Q` (ag) for literal string searches. |
| **Binary files** | grep and ag skip or warn on binary files by default. Use `grep -a` to force text treatment; be aware output may be garbled. |
| **Exit codes** | Exit 0 = match found, 1 = no match, 2 = error. Scripts must distinguish no-match (expected) from error. Use `grep ... || true` when no-match is acceptable. |
| **Sensitive data in patterns** | Search patterns appear in process listings. Avoid embedding secrets in grep/ag arguments. |
| **`.gitignore` respect** | `ag` respects `.gitignore` automatically; `grep -r` does not. Add `--exclude-dir=.git` or use `git grep` when searching repos with grep. |

## Source Policy

- Treat `man grep`, `grep --help`, and `ag --help` as runtime truth.
- Run `command -v ag` to detect ag availability before choosing a search command in scripts.
- Prefer `git grep` for searching within a Git repository when ag is not available.

## See Also

- `$ag` for fast code search with .gitignore support (already linked via this skill)
- `$awk` for pattern matching with column-level field extraction
- `$sed` for stream editing on matched lines
- `$find` for locating files by name or attribute rather than content
