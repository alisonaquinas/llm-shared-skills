# cat Advanced Usage

## Concatenating files in order

```bash
# Merge sorted chunks
cat part1.csv part2.csv part3.csv > full.csv

# Prepend a header
cat header.csv data.csv > output.csv

# Append a footer
cat body.html footer.html > page.html
```

## Heredoc with cat (writing multi-line files)

```bash
# With variable substitution
cat > config.yml <<EOF
host: $HOST
port: $PORT
debug: false
EOF

# Without variable substitution (single-quoted)
cat > script.sh <<'EOF'
#!/bin/bash
echo $HOME          # literal $HOME, not expanded
EOF

# Append to an existing file
cat >> existing.conf <<EOF
# Added $(date)
new_key = new_value
EOF
```

## Creating and truncating files

```bash
> file.txt                      # Truncate to zero bytes (no cat needed)
cat /dev/null > file.txt        # Same effect
: > file.txt                    # Portable shell truncation
```

## Feeding cat output into pipelines

When a command does not accept filename arguments, `cat` provides the pipe:

```bash
cat access.log | while IFS= read -r line; do
    process_line "$line"
done

# More efficiently with process substitution (no cat needed)
while IFS= read -r line; do
    process_line "$line"
done < access.log
```

## Binary files

`cat` sends raw bytes to stdout. Printing binary to a terminal can corrupt
terminal state (garbled display, unresponsive prompt).

```bash
file unknown.bin                    # Check type before catting
xxd unknown.bin | head              # Safe hex preview
xxd unknown.bin | less              # Paginated hex view
```

To restore a corrupted terminal:

```bash
reset                               # Full terminal reset
printf '\033c'                      # ESC-c: soft terminal reset
stty sane                           # Restore sane line discipline
```

## tac: reverse line order

`tac` (part of GNU coreutils) prints lines in reverse order — last line first:

```bash
tac file.txt                        # Print reversed
tac access.log | head -20           # Last 20 log entries without tail
tac file.txt | cat -n | tac        # Number lines from the end
```

## bat: enhanced cat with syntax highlighting

If `bat` is installed, it provides syntax highlighting, line numbers, and
git-change indicators:

```bash
bat file.py                         # Highlighted Python file
bat --plain file.txt                # No line numbers or git info
bat --language=json output          # Force language detection
```
