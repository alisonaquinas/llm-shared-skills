---
name: printf
description: >
  Format and print text portably with printf for shell scripting, structured
  output, ANSI colour, and precise escape-sequence control. Use when the agent
  needs portable output that works across bash, dash, sh, and zsh; when format
  strings, field widths, numeric formatting, or null-delimited output are
  required; or when echo's portability limitations make it unsuitable.
---

# printf

Produce formatted output portably across all POSIX shells. Prefer `printf`
over `echo` in scripts whenever escape sequences, format strings, or
cross-shell portability matter.

## Quick Start

1. Basic output: `printf '%s\n' "Hello, world"`
2. Formatted: `printf '%-20s %d\n' "count:" 42`
3. Write to file: `printf '%s\n' "content" > file.txt`

## Intent Router

- `references/cheatsheet.md` — Format specifiers, escape sequences, field widths, common invocations
- `references/advanced-usage.md` — Multiline output, ANSI colour, heredoc alternatives, null-delimited pipelines, scripting patterns
- `references/troubleshooting.md` — `%` in variables, portability pitfalls, locale issues, cross-shell differences

## Core Workflow

1. Use `'%s\n'` as the default format for safe variable output — no escape interpretation, always adds a newline
2. Prefer `printf` over `echo -e` in any script that may run under sh or dash
3. Use format specifiers (`%d`, `%f`, `%.2f`) for numeric output
4. Use field widths (`%-20s`, `%10d`) for aligned tabular output
5. Use `printf '%s\0'` for null-delimited output safe for `xargs -0`

## Quick Command Reference

```bash
printf '%s\n' "Hello"               # Safe string output (no escape interp)
printf '%s\n' "$var"                # Variable output — always quoted
printf 'Hello, %s!\n' "$name"       # Interpolate into format string
printf '%d items\n' 42              # Integer
printf '%.2f\n' 3.14159             # Float with 2 decimal places
printf '%05d\n' 7                   # Zero-padded: 00007
printf '%-20s %s\n' "Key:" "Value"  # Left-aligned column
printf '%20s %s\n' "Key:" "Value"   # Right-aligned column
printf '%s\t%s\n' "col1" "col2"     # Tab-separated
printf '\n'                         # Blank line
printf '%s\n' "a" "b" "c"          # Multiple args: one per line
printf '%s\n' "$@"                  # Print all positional parameters
printf '%s\0' file1 file2           # Null-delimited (for xargs -0)
printf '\033[1m%s\033[0m\n' "Bold"  # ANSI bold
printf '\033[32m%s\033[0m\n' "Green" # ANSI green
printf '%s\n' "text" > file.txt     # Write to file
printf '%s\n' "more" >> file.txt    # Append to file
printf '%s\n' "err" >&2             # Write to stderr
man printf                          # Full manual
```

## Format specifiers

| Specifier | Meaning | Example |
| --- | --- | --- |
| `%s` | String | `printf '%s' "$var"` |
| `%d` | Decimal integer | `printf '%d' 42` |
| `%f` | Floating point | `printf '%.2f' 3.14` |
| `%e` | Scientific notation | `printf '%e' 123456` |
| `%x` | Hexadecimal | `printf '%x' 255` → `ff` |
| `%o` | Octal | `printf '%o' 8` → `10` |
| `%b` | String with backslash escape processing | `printf '%b' 'line1\nline2'` |
| `%q` | Shell-quoted string | `printf '%q' "with spaces"` |
| `%%` | Literal `%` | `printf '100%%\n'` |

## Safety Notes

| Area | Guardrail |
| --- | --- |
| **Variable as format string** | Never pass `$var` as the format argument: `printf "$var"`. If `$var` contains `%s`, `%d`, etc., printf will interpret them. Always use `printf '%s\n' "$var"`. |
| **File overwrite** | `printf '...' > file` silently overwrites. Use `>>` to append. Enable `set -o noclobber` to prevent. |
| **Secrets in output** | `printf` arguments may appear in process listings. Avoid printing passwords or tokens in environments where ps output is visible. |
| **Locale and numbers** | `%f` output is locale-sensitive — decimal separators may be `,` instead of `.`. Use `LC_NUMERIC=C printf '%.2f' "$n"` for consistent dot-decimal output. |

## Source Policy

- `printf` is a POSIX built-in available in bash, dash, sh, zsh, and ksh.
- Treat `help printf` (bash) and `man 1 printf` (external) as runtime truth — they differ slightly.
- In bash, `printf -v varname '%s' "$val"` assigns to a variable without a subshell.

## See Also

- `$echo` for quick interactive output where portability is not a concern
- `$cat` for printing file contents rather than formatted strings
- `tee` for writing to both stdout and a file simultaneously
