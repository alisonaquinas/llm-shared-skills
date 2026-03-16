# echo / printf Cheatsheet

## echo vs printf at a glance

| Feature | `echo` | `printf` |
| --- | --- | --- |
| Trailing newline | Yes (use `-n` to suppress) | No (add `\n` explicitly) |
| Escape sequences | Bash: `-e` flag; POSIX sh: undefined | Always interpreted |
| Format strings | No | Yes (`%s`, `%d`, `%f`, …) |
| Portability | Varies by shell and platform | Consistent across POSIX shells |
| Best for | Interactive quick output | Scripts, formatted output |

## echo flags (bash built-in)

| Flag | Meaning |
| --- | --- |
| `-n` | Suppress trailing newline |
| `-e` | Interpret backslash escapes |
| `-E` | Disable backslash interpretation (default) |

## Escape sequences (with `echo -e` or `printf`)

| Sequence | Meaning |
| --- | --- |
| `\n` | Newline |
| `\t` | Tab |
| `\r` | Carriage return |
| `\\` | Literal backslash |
| `\0` | Null byte |
| `\a` | Bell |

## Common invocations

```bash
echo "Hello, world"                 # Basic string output
echo "$HOME"                        # Variable interpolation
echo -n "no trailing newline"       # Suppress newline (bash)
echo -e "line1\nline2"              # Escape sequences (bash only)
echo $'line1\nline2'                # ANSI-C quoting (bash, portable escape)
echo "text" > file.txt              # Write to file
echo "more" >> file.txt             # Append to file
echo ""                             # Print a blank line

printf "Hello, %s\n" "$name"        # Formatted output
printf '%s\n' "$var"                # Safe variable output (no escape interp)
printf '%d items\n' "${#arr[@]}"    # Integer formatting
printf '\033[1m%s\033[0m\n' "Bold"  # ANSI bold text
printf "%-20s %s\n" "Key:" "Value"  # Left-aligned column
printf '%s\n' "$var" > file.txt     # Write to file with printf
```

## Writing multiline content to a file

```bash
# printf (portable)
printf 'line1\nline2\nline3\n' > file.txt

# Bash $'...' quoting
echo $'line1\nline2\nline3' > file.txt

# Heredoc (clearest for multi-line)
cat > file.txt <<'EOF'
line1
line2
line3
EOF
```

## ANSI colour output

```bash
printf '\033[31mRed\033[0m\n'       # Red
printf '\033[32mGreen\033[0m\n'     # Green
printf '\033[33mYellow\033[0m\n'    # Yellow
printf '\033[1mBold\033[0m\n'       # Bold
printf '\033[4mUnderline\033[0m\n'  # Underline
```
