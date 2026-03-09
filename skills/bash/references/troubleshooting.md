# Bash Troubleshooting Guide

Use this reference when a Bash command fails, a script has errors, or behavior is unclear.

**Related references:**

- `references/quoting-and-expansion.md` — Variable expansion, word splitting, quote handling
- `references/redirection-and-pipes.md` — Input/output redirection, pipelines
- `references/process-and-jobs.md` — Backgrounding, signals, job control

## First-pass triage

```bash
scripts/probe-bash.sh
type -a <name>
set -o
shopt -p
env | sort
```

Classify the failure before changing anything:

- startup-file issue
- quoting or expansion issue
- missing command or PATH issue
- redirection or pipeline issue
- script execution vs sourcing issue
- WSL path or CRLF issue
- Windows executable interop issue

## Startup-file isolation

```bash
bash --noprofile --norc
bash -lc 'echo login shell'
```

- If the bug disappears in a clean shell, inspect `~/.bashrc`, `~/.profile`, and login-specific files before changing scripts.

## Syntax and flow problems

```bash
bash -n script.sh
bash -x script.sh
```

- Use `bash -n` for parse errors.
- Use `bash -x` for runtime flow and variable-expansion debugging.

## WSL-specific failures

```bash
scripts/test-wsl-boundaries.sh
wslpath -w "$PWD"
grep $'\r' script.sh
```

- Check for CRLF first when a script copied from Windows fails unexpectedly.
- Be explicit about whether the failing command is a Linux executable or a Windows executable launched from Bash.

## Common Error Messages and Causes

| Error | Cause | Fix |
| --- | --- | --- |
| `command not found` | Command not on PATH or typo | Check `type <cmd>` or full path |
| `$'\r': command not found` | CRLF line endings (Windows → Unix) | Convert: `dos2unix script.sh` or `sed -i 's/\r$//' script.sh` |
| `binary operator expected` | Missing quotes in [ ] test | Quote variables: `[ -z "$var" ]` not `[ -z $var ]` |
| `unbound variable` | Expanding undefined var with `set -u` | Either initialize: `var=`, or use `${var:-default}` |
| `cannot create temp file` | No /tmp space or wrong permissions | Check: `df /tmp` and `ls -ld /tmp` |
| `syntax error near unexpected token` | Quoting or brace mismatch | Run `bash -n script.sh` to find line |
| `no such file or directory` | Path issue or file deleted | Verify: `test -f "$file"` and `ls -la "$file"` |
| `permission denied` | Executable bit not set | Fix: `chmod +x script.sh` |
| `: bad substitution` | Invalid variable name or syntax | Check `${...}` syntax; avoid special chars in var names |

## Quoting Anti-Patterns

| ❌ Wrong | ✅ Correct | Why |
| --- | --- | --- |
| `echo $var` | `echo "$var"` | Unquoted var splits on whitespace and globs |
| `[ $x = $y ]` | `[ "$x" = "$y" ]` | Empty vars crash unquoted tests |
| `for f in *.txt; do rm $f; done` | `for f in *.txt; do rm "$f"; done` | Unquoted expands if name has spaces |
| `` `cmd` `` | `$(cmd)` | Backticks don't nest; $() is modern |
| `cmd1 && cmd2 \|\| cmd3` | `if cmd1; then cmd2; else cmd3; fi` | Pipes break logic (set -e, pipefail) |
| `~/dir/$file` | `"$HOME/dir/$file"` or `~"$user"/dir` | Tilde not expanded in quotes unless at start |
| `'$var'` (wants value) | `"$var"` | Single quotes are literal |
| `grep pattern file1 file2` | `grep pattern file{1,2}` | Brace expansion safer than space-sep args |

## set -e and Pipelines Interaction

**Gotcha:** `set -e` doesn't work as expected with pipelines:

```bash
set -e
false | true
echo "This still prints!" # -e doesn't catch failure in pipeline
```

**Fix:** Use `set -o pipefail`:

```bash
set -e
set -o pipefail
false | true
# Now exits on first failure
```

**Or use explicit checks:**

```bash
set -e
if ! cmd1 | cmd2; then
  exit 1
fi
```

## Cross-References by Topic

### Variable Expansion Issues

- See `references/quoting-and-expansion.md` for `${var#pattern}`, `${var/old/new}`, parameter expansion
- Parameter expansion doesn't work in single quotes: must use double quotes

### Redirection and Pipes

- See `references/redirection-and-pipes.md` for `>`, `>>`, `2>`, `|` behavior
- File descriptor confusion: `2>&1` redirects stderr to stdout

### Script Execution vs Sourcing

- **Execute:** `bash script.sh` or `./script.sh` — runs in subshell, variables don't affect parent
- **Source:** `. script.sh` or `source script.sh` — runs in current shell, affects environment
- Use source for loading config/functions; use execute for isolated scripts

## What to call out in answers

- Concrete Bash version: `bash --version`
- If WSL-specific: Windows vs WSL executable boundary
- The smallest reproducible command or script
- Whether the issue is Bash semantics or interaction with another tool
