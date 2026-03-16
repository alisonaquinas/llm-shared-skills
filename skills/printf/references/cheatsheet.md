# printf Cheatsheet

## Format Specifiers

| Specifier | Meaning | Example | Output |
| --- | --- | --- | --- |
| `%s` | String | `printf '%s' "hello"` | `hello` |
| `%d` | Decimal integer | `printf '%d' 42` | `42` |
| `%f` | Floating point | `printf '%.2f' 3.14159` | `3.14` |
| `%e` | Scientific notation | `printf '%e' 123456` | `1.234560e+05` |
| `%x` | Hexadecimal (lower) | `printf '%x' 255` | `ff` |
| `%X` | Hexadecimal (upper) | `printf '%X' 255` | `FF` |
| `%o` | Octal | `printf '%o' 8` | `10` |
| `%b` | String with backslash escape processing | `printf '%b' 'a\nb'` | `a` + newline + `b` |
| `%q` | Shell-quoted string (bash only) | `printf '%q' "with spaces"` | `with\ spaces` |
| `%%` | Literal `%` | `printf '100%%\n'` | `100%` |

## Escape Sequences

| Sequence | Meaning |
| --- | --- |
| `\n` | Newline |
| `\t` | Horizontal tab |
| `\r` | Carriage return |
| `\\` | Literal backslash |
| `\a` | Bell/alert |
| `\b` | Backspace |
| `\0` | Null byte |
| `\NNN` | Octal character |

## Width and Precision Modifiers

```
%-20s    Left-aligned string, min 20 chars wide
%20s     Right-aligned string, min 20 chars wide
%05d     Integer, zero-padded to 5 digits
%.2f     Float with exactly 2 decimal places
%10.2f   Float, right-aligned in 10-char field, 2 decimal places
%-10.5s  Left-aligned string, truncated to 5 chars in 10-char field
```

## Common Invocations

```bash
printf '%s\n' "Hello, world"           # Basic string output
printf '%s\n' "$var"                   # Variable — always use %s, never printf "$var"
printf 'Hello, %s!\n' "$name"          # Interpolate variable into format
printf '%d items\n' 42                 # Integer
printf '%.2f\n' 3.14159                # Float with 2 decimal places
printf '%05d\n' 7                      # Zero-padded: 00007
printf '%-20s %s\n' "Key:" "Value"     # Left-aligned column
printf '%20s %s\n' "Key:" "Value"      # Right-aligned column
printf '%s\t%s\n' "col1" "col2"        # Tab-separated
printf '\n'                            # Blank line
printf '%s\n' "a" "b" "c"             # Multiple args: one per line
printf '%s\n' "$@"                     # Print all positional parameters
printf '%s\0' file1 file2              # Null-delimited (for xargs -0)
printf '%s\n' "text" > file.txt        # Write to file
printf '%s\n' "more" >> file.txt       # Append to file
printf '%s\n' "err" >&2                # Write to stderr
```

## Field Width Quick Reference

```
%Ns    right-align string in N chars
%-Ns   left-align string in N chars
%.Ns   truncate string to N chars
%Nd    right-align integer in N chars
%0Nd   zero-pad integer to N digits
%N.Mf  float: N total width, M decimal places
```
