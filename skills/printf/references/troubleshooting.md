# printf Troubleshooting

## Variable passed as format string

**Symptom:** `printf "$var"` causes garbled output or errors when `$var` contains `%`.

```bash
# BAD — if var="100% done", printf interprets %
printf "$var"

# GOOD — always use %s to print a variable
printf '%s\n' "$var"
```

## Unexpected output when printing a literal `%`

```bash
# BAD — % alone triggers format interpretation
printf "50%\n"    # May print garbage or give an error

# GOOD — use %% for a literal percent sign
printf "50%%\n"   # outputs: 50%
```

## Decimal point is a comma, not a dot

**Cause:** Locale (`LC_NUMERIC`) uses comma as decimal separator.

```bash
# BAD — locale-dependent
printf '%.2f\n' 3.14

# GOOD — force dot-decimal output
LC_NUMERIC=C printf '%.2f\n' 3.14
```

## Escape sequences not processed

**Symptom:** `printf '\n'` prints a literal `\n` instead of a newline.

**Cause:** Using `%b` is required to process escapes in data arguments; the format string itself always processes escapes.

```bash
# Format string: escapes ARE processed
printf 'line1\nline2\n'       # Works correctly

# Data argument: escapes are NOT processed by default
printf '%s\n' 'line1\nline2'  # Prints literal \n

# Data argument: use %b to process escapes in the argument
printf '%b\n' 'line1\nline2'  # Prints two lines
```

## printf -v not available

**Cause:** `printf -v` is a bash extension; it does not exist in sh, dash, or zsh.

```bash
# bash only
printf -v result '%05d' 42

# POSIX portable alternative (uses a subshell)
result=$(printf '%05d' 42)
```

## Output truncated: printf repeats format for extra arguments

**Behaviour:** When more arguments are supplied than the format consumes, printf repeats the format string for the remaining arguments. This is by design.

```bash
# Prints three lines — format repeats
printf '%s\n' "a" "b" "c"

# To print all on one line, use a single format with all specifiers
printf '%s %s %s\n' "a" "b" "c"
```

## No newline at end of output

**Symptom:** Shell prompt appears on the same line as the last output.

```bash
# Always end format strings with \n unless intentionally suppressing the newline
printf '%s\n' "message"   # Newline included
printf '%s'   "prompt: "  # No newline — intentional for prompts
```

## printf: command not found (rare)

**Cause:** In unusual environments, `printf` may not be a shell built-in or may not be on `$PATH`.

```bash
command -v printf        # Confirm printf is available
type printf              # Show whether it is a built-in or external
which printf             # Location of external printf (/usr/bin/printf)
```

Use the shell built-in (`help printf` in bash) rather than `/usr/bin/printf` when possible, as they may differ in supported flags (e.g. `%q`, `printf -v`, `%(fmt)T`).
