# cat Cheatsheet

## Essential flags

| Flag | Meaning |
| --- | --- |
| `-n` | Number all output lines |
| `-b` | Number non-blank lines only |
| `-s` | Squeeze multiple adjacent blank lines into one |
| `-A` | Show all: equivalent to `-vET` (marks tabs as `^I`, line ends as `$`) |
| `-v` | Show non-printing characters using `^` and `M-` notation |
| `-E` | Display `$` at the end of each line (reveals CRLF issues) |
| `-T` | Display tab characters as `^I` |

## Common invocations

```bash
cat file.txt                        # Print file contents to stdout
cat a.txt b.txt                     # Concatenate and print two files
cat a.txt b.txt > combined.txt      # Concatenate into a new file
cat a.txt b.txt >> existing.txt     # Append to an existing file
cat -n file.txt                     # Number all lines
cat -b file.txt                     # Number non-blank lines only
cat -s file.txt                     # Squeeze consecutive blank lines
cat -A file.txt                     # Show non-printing characters
cat -v file.txt                     # Show control characters
cat >> file.txt                     # Append stdin (Ctrl-D to finish)
cat /dev/null > file.txt            # Truncate file to zero bytes
tac file.txt                        # Print lines in reverse order
```

## When NOT to use cat (useless use of cat)

Many commands accept filename arguments directly. Removing the unnecessary `cat`
is cleaner and avoids an extra process:

```bash
# Avoid                          # Prefer
cat file | grep pattern          grep pattern file
cat file | sort                  sort file
cat file | wc -l                 wc -l file
cat file | head -20              head -20 file
cat file | awk '{print $1}'      awk '{print $1}' file
cat file | sed 's/a/b/'          sed 's/a/b/' file
```

`cat` is appropriate when:

- Concatenating multiple files: `cat a b c > out`
- The command genuinely reads from stdin only and has no filename argument
- You are explicitly feeding a single file into a pipeline for clarity

## Viewing non-printing characters

```bash
cat -A file.txt     # Show tabs (^I), line endings ($), and control chars
cat -v file.txt     # Show control chars as ^X notation
cat -E file.txt     # Show $ at line end (useful for spotting CRLF: ^M$)
```
