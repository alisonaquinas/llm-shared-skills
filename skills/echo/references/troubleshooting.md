# echo Troubleshooting

## `-e` flag prints literally instead of interpreting escapes

**Symptom:** `echo -e "line1\nline2"` outputs `-e line1\nline2`.

This happens in POSIX sh, dash, or when using `/bin/echo` on some systems.

```bash
# Fix: use printf (portable)
printf "line1\nline2\n"

# Fix: use bash $'...' quoting
echo $'line1\nline2'

# Check which echo you are using
type echo                   # "echo is a shell builtin" vs external
/bin/echo --version         # GNU vs BSD
```

## Unquoted variable expands unexpectedly

**Symptom:** `echo $var` produces unexpected output (word-split, glob-expanded).

```bash
var="hello world"
echo $var           # May print "hello world" but also glob-expands * etc.
echo "$var"         # Always prints the variable as a single string
```

Always quote variable expansions: `echo "$var"`.

## Accidental file overwrite

**Symptom:** `echo "data" > file` replaced an existing file.

```bash
# Prevention: enable noclobber in bash
set -o noclobber
echo "data" > existing.txt      # Error: cannot overwrite

# Append instead
echo "data" >> file.txt
```

## echo in a script produces different output than interactive

**Symptom:** Script output differs from shell prompt output for the same `echo` command.

The script may run under a different shell (e.g., `#!/bin/sh` which is dash, not bash). `echo -e` behaves differently.

```bash
# Check the shebang
head -1 script.sh               # #!/bin/bash vs #!/bin/sh

# Fix: switch to printf for portable escape handling
printf "line1\nline2\n"
```

## Output contains unexpected `%` characters

**Symptom:** `printf "$var"` produces garbage or errors when `$var` contains `%`.

```bash
# Never pass a variable as the format string directly
printf "$var"           # Dangerous if $var contains % sequences

# Always use %s for variable output
printf '%s\n' "$var"    # Safe
```

## echo outputs trailing newline when `-n` was used

**Symptom:** Output still has a newline after `echo -n`.

You may be using `/bin/echo` (the external binary) which may not support `-n`.

```bash
type echo                           # Confirm built-in vs external
printf '%s' "no newline"            # Reliable alternative: no trailing newline
```
