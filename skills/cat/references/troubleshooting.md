# cat Troubleshooting

## Terminal output garbled after catting a binary file

**Symptom:** After `cat file.bin`, the terminal displays garbage and may become unresponsive.

```bash
reset                               # Full terminal reset
printf '\033c'                      # Soft reset (ESC-c)
stty sane                           # Restore line discipline

# Prevention: check file type first
file unknown.bin                    # Never cat a binary to the terminal
xxd unknown.bin | head              # Safe inspection of binary content
```

## File is too large to display

**Symptom:** `cat large.log` floods the terminal with thousands of lines.

```bash
head -50 large.log                  # First 50 lines
tail -50 large.log                  # Last 50 lines
less large.log                      # Paginated viewer
grep "ERROR" large.log | head -20   # Filtered view
wc -l large.log                     # Count lines before displaying
```

## Accidental file overwrite with `>`

**Symptom:** `cat a > b` replaced `b` instead of appending.

```bash
# Use >> to append
cat a >> b

# Enable noclobber in bash to prevent overwriting with >
set -o noclobber
```

## "No such file or directory" for a file that exists

```bash
ls -la file.txt                     # Confirm existence and permissions
file file.txt                       # Check type
cat -- file.txt                     # Use -- to end flag parsing (if name starts with -)
cat ./"-weird-name.txt"             # Use explicit path for names starting with -
```

## CRLF line endings showing as `^M`

**Symptom:** `cat -A file.txt` shows `^M$` at end of lines.

The file has Windows-style CRLF line endings.

```bash
cat -A file.txt | head              # Confirm: ^M$ at line ends
dos2unix file.txt                   # Convert to Unix LF
sed -i 's/\r//' file.txt           # Alternative with sed
```

## Concatenation produces wrong output

**Symptom:** `cat a.txt b.txt` output looks wrong.

```bash
wc -l a.txt b.txt                   # Check line counts
tail -1 a.txt | cat -A              # Check if last line of a.txt ends with newline
# If a.txt has no trailing newline, the first line of b.txt is joined to the last of a.txt

# Add missing trailing newline
printf '\n' >> a.txt
```

## cat not found or wrong cat on PATH

```bash
which cat                           # Find the cat binary
type cat                            # Shell built-in or external?
/bin/cat file.txt                   # Use absolute path
```
