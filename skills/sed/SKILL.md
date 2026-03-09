---
name: sed
description: Transform text streams with sed for line filtering, global substitutions, and in-place file edits. Use when the agent needs to search-and-replace with regex, filter specific line ranges, delete patterns, or apply repeatable text transformations.
---

# sed

Stream editor for deterministic, line-oriented text transformation and filtering.

## Quick Start

1. Verify `sed` is available: `sed --version` or `man sed`
2. Establish the command surface: `man sed` or `sed --help`
3. Start with a read-only probe: `sed 's/old/new/' file.txt`

## Intent Router

Load only the reference file needed for the active request.

- `references/install-and-setup.md` — Installing sed (GNU, BSD) on macOS, Linux, Windows
- `references/cheatsheet.md` — Common flags, substitution, line selection, deletion, extended regex
- `references/advanced-usage.md` — Multi-line patterns, address ranges, branching, hold space, GNU vs BSD differences
- `references/troubleshooting.md` — Regex escaping, in-place edit failures, performance, encoding issues

## Core Workflow

1. Verify sed variant (GNU vs BSD): `sed --version` or `man sed`
2. Test on sample data first (never on production): `sed 's/old/new/' sample.txt`
3. Use `-n` (quiet) with explicit `p` commands to prevent double-printing
4. Use `-i.bak` (with backup suffix) for in-place edits to allow rollback
5. Quote scripts carefully to avoid shell interpretation

## Quick Command Reference

```bash
sed --version                           # Check version (GNU vs BSD)
sed 's/old/new/' file.txt              # Replace first match per line
sed 's/old/new/g' file.txt             # Replace all matches per line
sed -n '10,20p' file.txt               # Print lines 10-20 only
sed -n '/pattern/p' file.txt           # Print lines matching pattern
sed '/pattern/d' file.txt              # Delete lines matching pattern
sed -i.bak 's/old/new/g' file.txt      # In-place edit with backup
sed -e 's/a/b/' -e 's/c/d/' file.txt   # Multiple scripts
sed 'N;s/\n/ /' file.txt               # Join consecutive lines
man sed                                 # Full manual and options
```

## Safety Notes

| Area | Guardrail |
| --- | --- |
| **Regex escaping** | Special characters (/, \, &, $) in patterns/replacements require careful escaping. Use -E for extended regex. Test on sample data. |
| **In-place edits** | Always use `-i.bak` (with backup suffix), never `-i` alone. Allows easy rollback if command is incorrect. |
| **Double-printing** | With `-n` flag, only requested lines print. Without `-n`, all lines print by default (may duplicate matches). |
| **GNU vs BSD** | Flag syntax differs (`-i.bak` vs `-i.bak` spacing, -E vs -r for extended regex). Test cross-platform or specify variant. |
| **Performance** | Complex multi-line patterns using hold space can be slow on large files. Use line-oriented tools (grep, awk) when possible. |
| **Encoding** | sed may corrupt multi-byte UTF-8 if patterns split characters. Test with actual data; consider iconv preprocessing. |

## Source Policy

- Treat the installed `sed` behavior and `man sed` as runtime truth.
- Use GNU sed documentation (gnu.org/software/sed) for GNU-specific extensions.
- Use BSD sed manual for BSD variant behavior differences.

## Resource Index

- `scripts/install.sh` — Install sed (GNU sed or BSD sed) on macOS or Linux.
- `scripts/install.ps1` — Install sed on Windows or any platform via PowerShell.
