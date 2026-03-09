# CLI And Help

Use this reference when the request is about launching Bash, controlling startup behavior, or finding the right local help surface.

## Invocation modes

- `bash`
  Start an interactive non-login shell.
- `bash -lc '<command>'`
  Start a login shell, run a command string, then exit.
- `bash --noprofile --norc`
  Start a clean shell without login or interactive startup files.
- `bash script.sh`
  Run a script file.
- `bash -n script.sh`
  Parse-check a script without executing it.
- `bash -x script.sh`
  Trace commands as they execute.

## Startup files

Common startup files in this Ubuntu WSL environment:

- `/etc/profile`
- `~/.bash_profile`
- `~/.bash_login`
- `~/.profile`
- `~/.bashrc`
- `~/.bash_logout`

Use `bash --noprofile --norc` when isolating startup-file problems. Use `bash -l` when login-shell behavior is the suspected difference.

## Local help workflow

Start with local help before going to the web:

```bash
bash --help
help
help cd
type -a printf
command -V test
compgen -b | sort
man bash
info bash
```

- `help` covers shell builtins.
- `type -a` distinguishes builtins, functions, aliases, keywords, and external commands.
- `command -V` is useful when you need a concise resolution of what a name is.
- `man` and `info` cover broader Bash behavior when a builtin help page is too small.

## High-value options

- `-c`
  Execute a command string.
- `-l` or `--login`
  Behave as a login shell.
- `--noprofile`
  Skip login startup files.
- `--norc`
  Skip `~/.bashrc` in interactive shells.
- `-n`
  Syntax check only.
- `-x`
  Execution tracing.
- `-u`
  Treat unset variables as errors.
- `-o posix`
  Run with POSIX-mode behavior when compatibility matters.

## What to call out in answers

- Whether the shell is interactive or noninteractive.
- Whether login or rc files are being loaded.
- Whether the name in question is a builtin, alias, function, keyword, or external command.
- Whether the issue can be reproduced in a clean shell.
