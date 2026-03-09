# Pipelines And Redirection

Use this reference when the task is about pipes, command grouping, process substitution, redirection, or pipeline exit behavior.

## Pipelines are text-oriented

Bash pipelines move bytes and text between processes, not structured objects.

```bash
grep -n 'error' app.log | awk -F: '{print $1}'
```

- Be explicit about delimiters and record formats.
- Use `printf` over `echo` when escaping or exact output matters.

## Redirection

```bash
command > out.txt
command 2> err.txt
command > out.txt 2>&1
command >> append.txt
```

- `2>&1` order matters.
- Process substitution can simplify command APIs that expect filenames:

```bash
diff <(sort file1) <(sort file2)
```

## Grouping and subshells

```bash
{ cd repo && make build; }
( cd repo && make build )
```

- `{ ...; }` runs in the current shell.
- `( ... )` runs in a subshell and does not preserve variable changes in the parent shell.

## Heredocs and here-strings

```bash
# Heredoc — expands variables; use <<'EOF' to suppress expansion
cat <<EOF
Hello, $USER
EOF

# Quoted heredoc — no expansion
cat <<'EOF'
Literal $USER
EOF

# Here-string — single-line input to a command
grep 'pattern' <<< "$variable"
```

- Use `<<'EOF'` when the content must be treated as a literal (e.g., scripts, SQL).
- Here-strings avoid a subshell; prefer them over `echo ... | command` for single values.

## Named pipes (FIFOs)

```bash
mkfifo /tmp/mypipe
producer > /tmp/mypipe &
consumer < /tmp/mypipe
rm /tmp/mypipe
```

- FIFOs are persistent on the filesystem; always clean them up.
- Use process substitution `<(...)` or `>(...)` when a named pipe is only needed transiently.

## Advanced file descriptors

```bash
exec 3> output.txt        # open fd 3 for writing
printf 'log line\n' >&3   # write to fd 3
exec 3>&-                 # close fd 3

exec 4< input.txt         # open fd 4 for reading
read -r line <&4
exec 4<&-
```

- Opening an fd with `exec` is persistent across commands in the same shell.
- Close custom fds with `>&-` or `<&-` when done to avoid leaks.

## Exit status and `pipefail`

```bash
set -o pipefail
```

- Without `pipefail`, a pipeline usually returns the status of the last command.
- With `pipefail`, earlier failures become visible and should be called out in debugging advice.
- `pipefail` interacts with `set -e`: a failed pipeline will abort the script unless the pipeline is inside an `if`, `while`, `until`, `&&`, or `||` construct — those contexts suppress `set -e` abort.

## What to call out in answers

- Whether the failure is in text parsing, process exit status, or shell grouping behavior.
- Whether a subshell is accidentally discarding state.
- Whether `pipefail` changes the observed result.
