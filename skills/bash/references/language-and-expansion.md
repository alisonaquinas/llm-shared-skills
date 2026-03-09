# Language And Expansion

Use this reference when the task is about Bash syntax, quoting, variables, expansion, arrays, or control flow.

## Quoting rules

- Single quotes are literal.
- Double quotes allow variable, command, and arithmetic expansion.
- Unquoted expansions are subject to word splitting and globbing.
- Prefer arrays over string-concatenated command lines when arguments may contain spaces or wildcards.

```bash
name='Ada Lovelace'
printf '%s\n' "$name"
```

## Expansion order

Important categories to watch:

- parameter expansion: `${var}`
- command substitution: `$(command)`
- arithmetic expansion: `$((1 + 2))`
- pathname expansion: `*.txt`
- brace expansion: `{a,b}`

The biggest operational mistakes usually come from unquoted parameter expansions and accidental globbing.

## Arrays

```bash
items=('one item' 'two' '*.txt')
printf '%s\n' "${items[@]}"
```

- Use `"${array[@]}"` to preserve argument boundaries.
- Avoid flattening arrays into a single string unless the target command explicitly wants that.

## Conditionals and tests

```bash
[[ -f "$path" ]]
[[ "$name" == *.txt ]]
(( count > 0 ))
```

- Prefer `[[ ... ]]` over `[` for string/pattern tests.
- Use `(( ... ))` for arithmetic.
- Use `case` when multiple patterns are clearer than stacked `if` blocks.

## Shell options and `shopt`

```bash
set -o
set -euo pipefail
shopt -p
shopt -s nullglob globstar
```

- Explain `set -e` carefully. It has context-sensitive exceptions.
- `pipefail` changes pipeline status reporting and should be called out when debugging.
- `nullglob`, `failglob`, `extglob`, and `globstar` materially change script behavior.

## Associative arrays

```bash
declare -A config
config[host]='localhost'
config[port]='5432'

printf '%s\n' "${config[host]}"
printf '%s\n' "${!config[@]}"   # keys
printf '%s\n' "${config[@]}"    # values
```

- Requires `declare -A`; assigning without it creates a numeric-indexed array.
- Key iteration order is undefined.

## Reading lines into arrays

```bash
mapfile -t lines < file.txt
readarray -t lines < file.txt   # synonym

# From command output
mapfile -t results < <(find . -name '*.sh')
```

- `-t` strips the trailing newline from each element.
- Prefer `mapfile` over `while read` loops when the whole array is needed at once.

## Nameref variables

```bash
declare -n ref=varname   # ref is an alias for varname
ref='new value'
printf '%s\n' "$varname"
```

- Useful for passing variable names into functions without eval.
- The referenced name must already exist or be writable.

## Interactive menus with `select`

```bash
PS3='Choose: '
select item in alpha beta gamma quit; do
  case "$item" in
    quit) break ;;
    *) printf 'Selected: %s\n' "$item" ;;
  esac
done
```

- `select` loops until `break` or EOF.
- `$REPLY` holds the raw user input; `$item` holds the matched word.
- Set `PS3` to customize the prompt.

## What to call out in answers

- Whether the issue is quoting, expansion, word splitting, or globbing.
- Whether the command line should be built as an array.
- Whether the user expects POSIX shell behavior or Bash-specific behavior.
