---
name: echo
description: >
  Print text and variable values to stdout with echo or printf for shell
  scripting, debugging, and pipeline construction. Use when the agent needs
  to output a string, interpolate variables, write a line to a file, print
  without a trailing newline, or handle escape sequences reliably across
  shells and platforms.
---

# echo

Print text to standard output in shell scripts and interactive sessions.
Prefer `printf` when portability and escape-sequence handling matter.

## Quick Start

1. Print a string: `echo "Hello, world"`
2. Interpolate a variable: `echo "Path: $PATH"`
3. Write to a file: `echo "content" > file.txt`

## Intent Router

- `references/cheatsheet.md` — echo vs printf, common flags, escape sequences, variable interpolation, file writing
- `references/advanced-usage.md` — Portable printf patterns, ANSI colour output, here-strings, multiline output, and shell differences
- `references/troubleshooting.md` — `-e` flag portability, double-vs-single quotes, newline handling, Windows CRLF

## Core Workflow

1. Use `echo` for simple string output and variable printing in interactive sessions
2. Switch to `printf` when escape sequences (`\n`, `\t`, `\0`), no-newline output, or cross-shell portability are required
3. Quote all variable expansions to prevent word-splitting: `echo "$var"`
4. Use `>` to write and `>>` to append to files; confirm the target path before redirecting
5. Prefer `printf '%s\n' "$var"` over `echo "$var"` in scripts for consistent behaviour

## Quick Command Reference

```bash
echo "Hello, world"                 # Print a string
echo "$HOME"                        # Interpolate a variable
echo -n "no newline"                # Suppress trailing newline (bash built-in)
echo -e "line1\nline2"              # Interpret escape sequences (bash built-in only)
echo "content" > file.txt           # Write to file (overwrites)
echo "more" >> file.txt             # Append to file
printf "Hello, %s\n" "$name"        # Portable formatted output
printf '%s\n' "$var"                # Print variable safely, no escape interpretation
printf '\033[1mBold\033[0m\n'       # ANSI bold (portable colour output)
printf "line1\nline2\n" > file.txt  # Multiline write (portable)
man echo                            # Shell built-in and /bin/echo manual
```

## Safety Notes

| Area | Guardrail |
| --- | --- |
| **`echo` is not portable** | The `-e` flag and escape interpretation differ between bash, sh, zsh, and `/bin/echo`. Use `printf` in scripts that must run across shells. |
| **Unquoted variables** | `echo $var` undergoes word-splitting and glob expansion. Always quote: `echo "$var"`. |
| **File redirection** | `>` silently overwrites the destination. Confirm the path or use `>>` for appending. Enable `set -o noclobber` to catch accidental overwrites. |
| **Secrets in arguments** | Arguments to `echo` may appear in process listings (`ps aux`). Do not echo passwords or tokens in environments where process listings are visible. |
| **`echo` vs `printf`** | In bash, `echo -e` works. In POSIX `sh`, it may not. When in doubt, use `printf` — it behaves consistently across all POSIX shells. |

## Source Policy

- Treat `help echo` (bash built-in) and `man echo` (external binary) as runtime truth — they may differ.
- Prefer `printf` over `echo` in any script that will be executed by `sh` or outside of bash.
- Use `$'...'` quoting in bash for literal escape sequences: `echo $'line1\nline2'`.

## See Also

- `printf` for portable, format-controlled output
- `$cat` for printing file contents rather than literal strings
- `tee` for writing to both stdout and a file simultaneously
