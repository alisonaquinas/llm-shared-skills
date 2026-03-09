# Troubleshooting

Use this reference when the user has a failing command, a broken script, or an unclear Bash or WSL behavior.

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

## What to call out in answers

- Concrete Bash version and WSL facts.
- The smallest reproducible command or script.
- Whether the issue is pure Bash semantics or a cross-boundary WSL behavior.
