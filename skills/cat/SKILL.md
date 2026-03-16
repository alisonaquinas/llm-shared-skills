---
name: cat
description: >
  Concatenate and display file contents with cat for reading files, combining
  multiple files, writing heredoc content, and feeding file data into
  pipelines. Use when the agent needs to print a file's contents to stdout,
  join several files into one, pipe a file into another command, or inspect
  a short file quickly.
---

# cat

Concatenate files and print their contents to standard output.

## Quick Start

1. Verify availability: `cat --version` (GNU) or `man cat`
2. Display a file: `cat file.txt`
3. Concatenate files: `cat a.txt b.txt > combined.txt`

## Intent Router

- `references/cheatsheet.md` — Display, concatenate, number lines, show non-printing characters, file writing via heredoc
- `references/advanced-usage.md` — Combining with pipelines, heredoc patterns, binary file awareness, tac for reverse
- `references/troubleshooting.md` — Binary content warnings, large file pitfalls, useless use of cat, encoding issues

## Core Workflow

1. Use `cat file` for quick inspection of short files
2. Use `cat a b c > out` to concatenate multiple files in order
3. Pipe `cat file | command` only when the command does not accept a filename argument — many tools accept files directly, making `cat` unnecessary
4. Use `cat -A` or `cat -v` to reveal non-printing characters when diagnosing encoding or line-ending issues
5. Use `cat -n` to number lines for reference when discussing file content

## Quick Command Reference

```bash
cat file.txt                        # Display file contents
cat a.txt b.txt                     # Concatenate and display two files
cat a.txt b.txt > combined.txt      # Concatenate into a new file
cat >> file.txt                     # Append stdin to a file (Ctrl-D to end)
cat -n file.txt                     # Number all output lines
cat -b file.txt                     # Number non-blank lines only
cat -A file.txt                     # Show all: mark tabs (^I), line ends ($)
cat -v file.txt                     # Show non-printing characters
cat -s file.txt                     # Squeeze multiple blank lines into one
tac file.txt                        # Print lines in reverse order
cat /dev/null > file.txt            # Truncate a file to zero bytes
man cat                             # Full manual
```

## Safety Notes

| Area | Guardrail |
| --- | --- |
| **Overwrite with `>`** | `cat a > b` overwrites `b` silently. Use `>>` to append. Confirm destination path before redirecting. |
| **Binary files** | `cat` will send raw binary bytes to the terminal, which can corrupt terminal state. Check with `file` first; use `xxd` or `hexdump` for binary inspection. |
| **Large files** | `cat` on a large file floods the terminal. Use `head`, `tail`, `less`, or `grep` for targeted inspection. |
| **Useless use of cat** | `cat file | grep pattern` is better written as `grep pattern file`. Eliminating unnecessary `cat` reduces process overhead and clarifies intent. |
| **Truncation via redirect** | `cat /dev/null > file` or `> file` immediately truncates `file` to zero bytes. This is irreversible without a backup. |

## Source Policy

- Treat `man cat` and `cat --help` as runtime truth. GNU and BSD `cat` share most flags.
- Avoid "useless use of cat" — pass filenames directly to commands that accept them (`grep`, `sort`, `wc`, etc.).
- Use `less` or `bat` for interactive browsing of files longer than a screenful.

## See Also

- `$echo` for printing literal strings rather than file contents
- `less` / `more` for paginated file viewing
- `head` / `tail` for reading the start or end of a file
- `tac` for reversed line order output
