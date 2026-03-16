# echo Advanced Usage

## Why printf is preferred in scripts

`echo` behaviour varies across shells and even between `/bin/echo` and the
shell built-in. The same `echo -e "line\n"` works in bash but may print
`-e line\n` literally in dash or sh.

`printf` is defined by POSIX and behaves identically across bash, dash, sh,
zsh, and ksh:

```bash
# Unreliable in POSIX sh
echo -e "first\nsecond"

# Always reliable
printf "first\nsecond\n"
printf '%s\n' "first" "second"      # Prints each argument on its own line
```

## Generating structured output

```bash
# Table with aligned columns
printf "%-15s %-10s %s\n" "Name" "Status" "PID"
printf "%-15s %-10s %d\n" "nginx" "running" 1234
printf "%-15s %-10s %d\n" "postgres" "stopped" 0

# Zero-padded numbers
printf "%04d\n" 7          # 0007

# Floating point
printf "%.2f\n" 3.14159    # 3.14
```

## Writing to files and stderr

```bash
printf '%s\n' "log entry" >> logfile.txt    # Append to file
printf 'Error: %s\n' "$msg" >&2             # Write to stderr
printf '%s\n' "$data" | tee file.txt        # Write to both stdout and file
```

## Null-delimited output (for xargs -0)

```bash
printf '%s\0' file1 file2 file3 | xargs -0 rm
```

## Debugging variable content

```bash
printf '%q\n' "$var"        # Shell-quoted: shows special characters safely
declare -p var              # Shows variable name, type, and value
echo "${#var}"              # Print length of variable
```

## Heredoc vs printf for multiline files

```bash
# Heredoc: clearest for long static text, allows variable substitution
cat > config.yaml <<EOF
host: $HOST
port: $PORT
EOF

# Heredoc with no substitution (single-quoted)
cat > script.sh <<'EOF'
#!/bin/bash
echo $HOME       # $HOME is literal here, not expanded
EOF

# printf: better when content is dynamic or contains special characters
printf 'host: %s\nport: %d\n' "$HOST" "$PORT" > config.yaml
```

## tee: write to file and stdout simultaneously

```bash
echo "output" | tee file.txt            # Write to file AND print to terminal
printf '%s\n' "$result" | tee -a log    # Append to log AND print
```
