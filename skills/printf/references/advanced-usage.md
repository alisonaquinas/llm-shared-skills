# printf Advanced Usage

## Multiline Output

```bash
# Multiple lines with one call
printf '%s\n' \
  "Line 1" \
  "Line 2" \
  "Line 3"

# Multiline block — printf is portable; heredoc has trailing-newline quirks
printf '%s\n%s\n%s\n' "Line 1" "Line 2" "Line 3"
```

## ANSI Colour Output

```bash
# Named colour variables
RED='\033[31m'
GREEN='\033[32m'
YELLOW='\033[33m'
BLUE='\033[34m'
BOLD='\033[1m'
RESET='\033[0m'

printf "${RED}Error:${RESET} %s\n" "$message"
printf "${GREEN}OK${RESET}\n"
printf "${BOLD}%s${RESET}\n" "Bold text"

# Inline (no variables needed)
printf '\033[32m%s\033[0m\n' "Green text"
printf '\033[1;33m%s\033[0m\n' "Bold yellow"

# Guard colour output to terminal only
if [ -t 1 ]; then
  printf '\033[32m%s\033[0m\n' "Terminal: green"
else
  printf '%s\n' "Non-terminal: no colour"
fi
```

## printf -v: Assign to Variable (bash only)

```bash
# Avoid subshell overhead — assign formatted string directly to a variable
printf -v result '%05d' 42       # result="00042"
printf -v ts '%(%Y-%m-%d)T' -1   # ts="2024-03-15" (bash 4.2+, current time)
```

## Null-Delimited Output for xargs -0

```bash
# Safe for filenames with spaces or special characters
printf '%s\0' *.log | xargs -0 rm
printf '%s\0' "$@" | xargs -0 -I{} process "{}"

# Build null-delimited list from an array
printf '%s\0' "${files[@]}" | xargs -0 stat
```

## Tabular / Aligned Output

```bash
# Left-aligned columns
printf '%-20s %-10s %s\n' "Name" "Status" "PID"
printf '%-20s %-10s %d\n' "my-service" "running" 12345

# Right-aligned numeric column
printf '%30s %8d bytes\n' "$filename" "$size"

# Table with separator line
printf '%-20s %10s\n' "File" "Size"
printf '%s\n' "----------------------------------------"
while IFS= read -r f; do
  sz=$(wc -c < "$f")
  printf '%-20s %10d\n' "$f" "$sz"
done
```

## Scripting Patterns

```bash
# Logging helpers
log_info()  { printf '[INFO]  %s\n' "$*" >&2; }
log_warn()  { printf '[WARN]  %s\n' "$*" >&2; }
log_error() { printf '[ERROR] %s\n' "$*" >&2; }

# Prompt without newline (portable; echo -n is not POSIX)
printf 'Continue? [y/N] '
read -r answer

# In-place progress counter
total=100
for i in $(seq 1 "$total"); do
  printf '\r[%3d/%3d] Processing...' "$i" "$total"
done
printf '\n'

# Build a CSV string into a variable (bash only, no subshell)
printf -v csv '%s,%s,%s' "$a" "$b" "$c"
```

## Locale-Stable Numeric Output

```bash
# Decimal separator may be comma in some locales — force dot
LC_NUMERIC=C printf '%.4f\n' "$value"

# Print ASCII decimal value of a character
printf '%d\n' "'A"     # outputs: 65
```
