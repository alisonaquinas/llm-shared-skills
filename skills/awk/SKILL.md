---
name: awk
description: Process columnar and line-based text with awk for field extraction, conditional filtering, and aggregations. Use when the agent needs to extract columns, filter rows by conditions, compute aggregations, or transform structured text records in shell pipelines.
---

# awk

Fast, scriptable field extraction, filtering, and aggregation on text records.

## Quick Start

1. Verify `awk` is available: `awk --version` or `awk 'BEGIN {print PROCINFO["version"]}'`
2. Establish the command surface: `man awk` or `awk --help`
3. Start with a read-only probe on sample data: `awk '{print $1, $3}' sample.txt`

## Intent Router

Load only the reference file needed for the active request.

- `references/install-and-setup.md` — Installing awk (GNU, mawk, nawk, POSIX) on macOS, Linux, Windows
- `references/cheatsheet.md` — Common flags, one-liners, field/record patterns, I/O control, built-in variables
- `references/advanced-usage.md` — Multi-dimensional arrays, string functions, regex subtleties, user-defined functions, scripting workflows, GNU vs BSD/POSIX differences
- `references/troubleshooting.md` — CSV edge cases, locale issues, field separator confusion, performance with large files, variable scope

## Core Workflow

1. Verify awk version and variant (GNU, mawk, nawk, POSIX).
2. Test field delimiter and record format on a sample file: `awk 'BEGIN {FS=","; OFS=","} {print $1, $3}' sample.csv`
3. Write the awk program in a safe order: patterns → action blocks → variable initialization.
4. Run with explicit input/output files; avoid piping to destructive commands until results are validated.

## Quick Command Reference

```bash
awk --version                          # Check version and variant
awk 'BEGIN {print "header"}'           # Print header before processing
awk '{print $1, $3}' file.txt          # Print columns 1 and 3
awk -F, '{print NF}' file.csv          # Print field count (with CSV delimiter)
awk '$5 > 100 {print $1, $5}' file.txt # Filter: show rows where field 5 > 100
awk 'NR==1 || /pattern/' file.txt      # Print header and matching lines
awk '{sum+=$2} END {print sum}' file.txt # Sum column 2
man awk                                # Full manual (awk syntax, functions, examples)
```

## Safety Notes

| Area | Guardrail |
| --- | --- |
| **Field separator** | Set `-F` or `BEGIN {FS=","}` explicitly; omitting causes locale/whitespace ambiguity. Test on sample data first. |
| **CSV edge cases** | Basic awk is not a full CSV parser. Quoted fields, embedded delimiters, and escapes require careful field separator choice or preprocessing. |
| **Variable scope** | Global variables defined in `BEGIN` are shared across records. Document whether `NR` (total count) or `FNR` (file-relative count) is used in multi-file workflows. |
| **GNU vs POSIX** | GNU awk adds functions like `strftime()`, `mktime()`, `gensub()`. POSIX awk uses `sub()`, `gsub()`, `index()`. Test on target platform. |
| **Large files** | Avoid storing entire records in arrays; process line-by-line when file count is unknown. Profile with `time awk ...`. |
| **Untrusted regex** | User-supplied patterns in regex expressions can cause performance degradation (ReDoS). Validate or restrict input. |

## Source Policy

- Treat the installed `awk` behavior, `man awk`, and `awk 'BEGIN {for (x in PROCINFO) print x}'` as runtime truth.
- Use the GNU Awk Manual (gawk.gnu.org) for GNU-specific extensions and POSIX specs (pubs.opengroup.org) for portable semantics.

## Resource Index

- `scripts/install.sh` — Install awk (GNU, mawk, nawk, or POSIX variant) on macOS or Linux.
- `scripts/install.ps1` — Install awk on Windows or any platform via PowerShell.
