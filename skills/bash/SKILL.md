---
name: bash
description: Practical Bash shell, scripting, debugging, and WSL2 interop guidance for Ubuntu-based and Linux environments. Use when the agent needs to work with `bash`, `.sh` scripts, startup files, shell builtins, quoting, expansion, pipelines, redirection, job control, traps, `wslpath`, `/mnt/c` paths, CRLF issues, `shellcheck`, `dos2unix`, or Windows executable interop from WSL.
---

# Bash

Use this skill to keep Bash work grounded in the installed shell first, then fall back to GNU Bash and Microsoft WSL documentation when local help or runtime behavior needs confirmation.

## Quick Start

1. Run `scripts/probe-bash.sh` first for environment truth.
2. Establish the local help surface before guessing:

- `bash --help`
- `help`
- `help <builtin>`
- `type -a <name>`
- `declare -p <var>`
- `set -o`
- `shopt -p`

1. Use `bash --noprofile --norc` early when startup files may be involved.
2. Separate Bash semantics from external-command behavior and from WSL/Windows boundary behavior.
3. Call out WSL-specific behavior whenever the request mentions `/mnt/c`, `cmd.exe`, `powershell.exe`, CRLF line endings, Windows paths, or cross-boundary process launching.

## Intent Router

Load only the reference file needed for the active request.

- `references/install-and-setup.md`
  - Installing or upgrading Bash on macOS, Linux, or Windows (WSL2/Git Bash), and post-install configuration.
- `references/cli-and-help.md`
  - `bash` invocation, startup files, built-in help, `man`, `info`, and local discovery.
- `references/language-and-expansion.md`
  - quoting, expansion, arrays, conditionals, shell options, and common Bash semantics traps.
- `references/scripting-and-functions.md`
  - script structure, shebangs, `getopts`, functions, sourcing, and reusable script patterns.
- `references/pipelines-and-redirection.md`
  - pipes, redirection, process substitution, grouping, subshells, and exit-status propagation.
- `references/wsl-interop.md`
  - `/mnt/c`, `wslpath`, Windows executables, path translation, CRLF, and host-boundary caveats.
- `references/jobs-signals-debugging.md`
  - job control, `wait`, traps, signals, `set -x`, and minimal repro debugging.
- `references/troubleshooting.md`
  - startup-file isolation, quoting failures, missing commands, permission issues, and WSL-specific diagnostics.

## Core Workflow

1. Establish runtime truth

- Run `scripts/probe-bash.sh --json` when structured output helps.
- Capture Bash version, startup files, tool availability, shell options, and WSL indicators.

1. Choose the smallest discovery path

- Help: `help <builtin>`, `man bash`, `info bash`
- Command discovery: `type -a`, `command -V`, `compgen -b`, `declare -F`
- Runtime state: `set -o`, `shopt -p`, `env | sort`

1. Separate task classes before changing code

- Shell invocation and startup behavior
- Language behavior: quoting, expansion, arrays, conditionals, exit status
- Text pipeline behavior: pipes, redirection, command substitution
- WSL boundary behavior: path translation, CRLF, Windows process interop

1. Prefer reproducible diagnostics

- Use `scripts/collect-help-index.sh` when help and builtins are in scope.
- Use `scripts/test-wsl-boundaries.sh` when interop, path, CRLF, stdout/stderr, or exit-code behavior is suspect.

## Quick Command Reference

```bash
# Clean shell
bash --noprofile --norc
bash -lc 'printf "%s\n" "$BASH_VERSION"'

# Discovery
help cd
type -a grep
command -V awk
compgen -b | sort
set -o
shopt -p

# Scripting
bash -n script.sh
shellcheck script.sh
source ~/.bashrc

# Pipelines
set -o pipefail
grep -n 'pattern' file | awk -F: '{print $1}'

# WSL interop
wslpath -w "$PWD"
cmd.exe /c dir
```

## Safety Notes

| Area | Guardrail |
| --- | --- |
| Startup files | Prefer `bash --noprofile --norc` before editing `~/.bashrc` or login profiles. |
| Strict mode | Explain `set -euo pipefail` precisely; do not claim it makes scripts universally safe. |
| Quoting | Call out word splitting and glob expansion explicitly before suggesting unquoted variables. |
| WSL paths | Be explicit about Linux paths vs Windows paths and convert deliberately with `wslpath`. |
| Cross-boundary commands | Clarify which shell parses the command first and how exit codes and CRLF behave. |

## Source Policy

- Treat installed Bash behavior, `help`, `man`, and `info` output as runtime truth.
- Use the GNU Bash manual for language semantics and invocation details.
- Use Microsoft WSL documentation for Windows interop, path, and host-boundary behavior.

## Resource Index

- `scripts/probe-bash.sh`
  - Contract: `probe-bash.sh [--json]`
  - Purpose: summarize Bash version, startup files, shell options, tools, and WSL indicators.
- `scripts/collect-help-index.sh`
  - Contract: `collect-help-index.sh [--json] [builtin ...]`
  - Purpose: inventory Bash builtins and local help/man/info availability.
- `scripts/test-wsl-boundaries.sh`
  - Contract: `test-wsl-boundaries.sh [--json]`
  - Purpose: demonstrate path conversion, CRLF detection, Windows-command invocation, streams, and exit-code behavior across WSL boundaries.
- `assets/templates/bash-script.sh`
  - Purpose: starter for a strict-mode Bash script with usage and cleanup trap patterns.
- `assets/templates/bash-library/`
  - Purpose: minimal reusable Bash library layout with a sourced helper and entrypoint.
