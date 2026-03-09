# Jobs, Signals, And Debugging

Use this reference when the task involves background work, traps, signals, or shell tracing.

## Job control

```bash
sleep 30 &
jobs
fg %1
bg %1
wait
```

- Job control is interactive-shell oriented.
- `wait` is the key primitive for synchronizing background work in scripts.

## Signals

Common signal reference:

| Signal | Number | Default action | Notes |
|--------|--------|----------------|-------|
| SIGHUP | 1 | Terminate | Terminal hangup; often used to reload config |
| SIGINT | 2 | Terminate | Ctrl-C from terminal |
| SIGTERM | 15 | Terminate | Graceful shutdown request; can be trapped |
| SIGKILL | 9 | Terminate | Cannot be trapped or ignored |

- `SIGKILL` bypasses all traps; use it only as a last resort.
- `SIGTERM` is the correct signal to send for graceful shutdown.

## Traps and cleanup

```bash
cleanup() {
  rm -f "$tmpfile"
}
trap cleanup EXIT

# Multiple signals in one trap
trap 'cleanup; exit 130' INT TERM
trap cleanup EXIT
```

- Prefer cleanup traps for temporary files and subprocess teardown.
- List multiple signals in a single `trap` command rather than repeating the handler.
- `EXIT` runs when the shell exits for any reason; `INT` and `TERM` catch interactive and system signals.
- A `trap '' SIGNAL` ignores the signal; `trap - SIGNAL` resets to default.

## Persistent background jobs

```bash
nohup long-running-cmd &> /tmp/out.log &
disown %1
```

- `nohup` redirects stdout/stderr and makes the process immune to SIGHUP.
- `disown` removes a job from the shell's job table without sending SIGHUP, useful after `&`.
- Combine both when a job must survive terminal disconnect.

## Debugging

```bash
bash -n script.sh
bash -x script.sh
set -x
set +x
```

- Use `bash -n` first for syntax issues.
- Use `bash -x` or `set -x` for runtime flow tracing.
- Customize `PS4` for richer trace output:

```bash
export PS4='+(${BASH_SOURCE[0]}:${LINENO}): ${FUNCNAME[0]:+${FUNCNAME[0]}(): }'
set -x
```

## Signals and exit handling

- Use stable exit codes in reusable scripts.
- Distinguish command failure from signal interruption.
- `set -e` is suppressed inside `if`, `while`, `&&`, and `||` constructs and inside functions called from those contexts.
- A `trap ERR` fires on non-zero exits when `set -e` would abort — but not when the failing command is in an `if` condition or `&&`/`||` chain.
- Treat `set -e` plus traps as a combined behavior surface when explaining shutdown or cleanup bugs.

## What to call out in answers

- Whether the code is interactive job control or noninteractive background work.
- Whether the issue is syntax, flow, signal handling, or cleanup.
- Whether tracing should happen in a clean shell.
