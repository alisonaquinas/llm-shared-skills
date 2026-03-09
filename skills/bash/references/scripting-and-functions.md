# Scripting And Functions

Use this reference when writing `.sh` scripts, reusable functions, or sourced helper libraries.

## Script structure

Start most Bash scripts with a shebang and explicit shell options:

```bash
#!/usr/bin/env bash
set -euo pipefail
```

- Add `IFS=$'\n\t'` only when the script truly depends on a non-default split model.
- Prefer functions for logical units instead of long top-level imperative blocks.
- Use `main "$@"` near the bottom for clearer flow.

## Positional parameters and parsing

```bash
while getopts ':f:o:h' opt; do
  case "$opt" in
    f) input=$OPTARG ;;
    o) output=$OPTARG ;;
    h) usage; exit 0 ;;
    :) printf 'missing value for -%s\n' "$OPTARG" >&2; exit 2 ;;
    \?) printf 'unknown option: -%s\n' "$OPTARG" >&2; exit 2 ;;
  esac
done
shift "$((OPTIND - 1))"
```

- Use `getopts` for small built-in option parsing.
- Prefer explicit usage functions and stable exit codes.

## Functions and sourcing

```bash
source ./lib/helpers.sh

log_info()  { printf '[info]  %s\n' "$*"; }
log_warn()  { printf '[warn]  %s\n' "$*" >&2; }
log_error() { printf '[error] %s\n' "$*" >&2; }

die() {
  local msg=${1:-'fatal error'}
  local code=${2:-1}
  log_error "$msg"
  exit "$code"
}
```

- `return` exits a function or sourced file; `exit` terminates the shell or script.
- Use `source` or `.` when the caller needs variables or functions to remain in the current shell.
- Use separate helper files for shared functions instead of copy-pasting snippets between scripts.
- `log_warn` and `log_error` write to stderr so they do not pollute stdout-captured output.
- `die` centralizes fatal-exit handling; call it with a message and optional exit code.

## Error context with `trap ERR`

```bash
trap 'die "command failed at line $LINENO: $BASH_COMMAND" $?' ERR
```

- `$BASH_COMMAND` holds the failing command text.
- `$LINENO` provides the script line number.
- This pattern is most useful when `set -e` is active and you need to log the failure source before exit.
- `trap ERR` does not fire when the failing command is inside `if`, `while`, `&&`, or `||`.

## Startup files vs scripts

- `~/.bashrc` is for interactive shell behavior.
- Login profiles such as `~/.profile` or `~/.bash_profile` are for login-shell setup.
- Do not put one-off script logic in startup files.

## What to call out in answers

- Whether the code should be executed or sourced.
- Whether the script is interactive or automation-oriented.
- Whether the parser should be `bash`-specific or POSIX-compatible.
