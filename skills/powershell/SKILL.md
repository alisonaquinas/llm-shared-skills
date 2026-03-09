---
name: powershell
description: Practical PowerShell 7 shell, scripting, remoting, debugging, and troubleshooting guidance. Use when the agent needs to work with `pwsh.exe`, `Get-Help`, profiles, providers, modules, scripts, advanced functions, native command interop, execution policy, jobs, remoting, `ForEach-Object -Parallel`, `Pester`, or `SecretManagement` on Windows, Linux, or macOS.
---

# PowerShell

Use this skill to keep PowerShell work grounded in the installed runtime first, then fall back to official Microsoft Learn content when local help is missing or partial.

## Quick Start

1. Run `scripts/probe-pwsh.ps1` first for environment truth.
2. Establish the help surface before guessing:

- `pwsh.exe -?`
- `Get-Help <name> -Full`
- `Get-Help about_*`
- `Get-Command <name> -All`
- `Get-Member`

1. Load only the reference file that matches the active request.
2. Treat PowerShell objects, formatting, and native-process interop as separate concerns.
3. Call out Windows-specific behavior when the request mentions `pwsh.exe`, execution policy, WMI/CIM, WinRM, registry, certificates, or `cmd.exe`.

## Intent Router

Load only the reference file needed for the active request.

- `references/install-and-setup.md`
  - Installing PowerShell 7 on macOS, Linux, or Windows, and post-install configuration.
- `references/cli-and-help.md`
  - `pwsh.exe` invocation, startup flags, profile loading, and help workflow.
- `references/language-and-pipeline.md`
  - parsing, quoting, variables, objects, formatting, redirection, and native command boundaries.
- `references/scripting-and-modules.md`
  - scripts, functions, advanced functions, modules, manifests, and profiles.
- `references/providers-and-data.md`
  - providers, PSDrives, filesystem/registry/env/cert usage, and common data formats.
- `references/remoting-jobs-debugging.md`
  - remoting, sessions, jobs, background work, tracing, and debugger workflow.
- `references/security-and-compat.md`
  - execution policy, secrets boundaries, code signing, constrained environments, and PowerShell 5.1 vs 7+ compatibility.
- `references/wsl-interop.md`
  - calling WSL from `pwsh.exe`, calling `pwsh.exe` from Bash, `wslpath` path translation, and CRLF handling.
- `references/troubleshooting.md`
  - error triage, streams, diagnostic commands, and reproducible failure analysis.

## Core Workflow

1. Establish runtime truth

- Run `scripts/probe-pwsh.ps1 -Json` when structured output helps.
- Capture version, edition, OS, profile paths, module path, and local help coverage.

1. Choose the smallest discovery path

- Command help: `Get-Help <cmdlet> -Detailed`, `-Examples`, `-Full`, `-Online`
- Command discovery: `Get-Command`, `Get-Module -ListAvailable`, `Find-Module`
- Object discovery: `... | Get-Member`

1. Separate task classes before changing code

- Shell launch and automation: `pwsh.exe` flags and process behavior
- Language and script behavior: parsing, quoting, variables, scoping, pipeline
- Operational surfaces: providers, remoting, jobs, debugging, security

1. Prefer reproducible diagnostics

- Use `scripts/collect-help-index.ps1` when help completeness is relevant.
- Use `scripts/test-native-boundaries.ps1` when quoting, argument passing, streams, or exit codes are suspect.

## Quick Command Reference

```powershell
# Launch modes
pwsh -NoLogo -NoProfile
pwsh -File .\script.ps1 -Name value
pwsh -Command '$PSVersionTable'
pwsh -EncodedCommand <base64>

# Discovery
Get-Help Get-ChildItem -Examples
Get-Command *service*
Get-Module -ListAvailable
Get-Help about_* | Sort-Object Name

# Objects and pipeline
Get-Process | Get-Member
Get-Service | Where-Object Status -eq Running | Select-Object -First 5

# Scripting
Test-Path $PROFILE
New-ModuleManifest -Path .\MyModule.psd1
Import-Module .\MyModule.psd1 -Force

# Troubleshooting
$Error[0] | Format-List * -Force
Trace-Command -Name ParameterBinding -Expression { <command> } -PSHost
```

## Safety Notes

| Area | Guardrail |
|---|---|
| Execution policy | Explain that process-level `-ExecutionPolicy` does not persist and only applies on Windows. |
| Remoting | Confirm transport and prerequisites before proposing `Enter-PSSession` or `Invoke-Command`. |
| Native commands | Be explicit about which shell is parsing the command line first. |
| Profiles | Prefer `-NoProfile` when isolating startup issues. |
| Formatting | Avoid building automation on formatted text when objects are available. |

## Source Policy

- Treat installed `pwsh.exe` behavior and local help output as runtime truth.
- Use Microsoft Learn for missing or partial help topics, especially `about_*` content.
- Distinguish Windows PowerShell 5.1 guidance from PowerShell 7+ guidance when compatibility matters.

## Resource Index

- `scripts/probe-pwsh.ps1`
  - Contract: `probe-pwsh.ps1 [-Json]`
  - Purpose: summarize runtime, profiles, modules, and help coverage.
- `scripts/collect-help-index.ps1`
  - Contract: `collect-help-index.ps1 [-Json] [-CommandName <string[]>]`
  - Purpose: inventory installed `about_*` topics and detect partial command help.
- `scripts/test-native-boundaries.ps1`
  - Contract: `test-native-boundaries.ps1 [-Json]`
  - Purpose: demonstrate native-process argument, stream, and exit-code behavior.
- `assets/templates/advanced-function.ps1`
  - Purpose: starter for a comment-based-help advanced function with safe process semantics.
- `assets/templates/module-skeleton/`
  - Purpose: minimal module starter with manifest, module file, and public command export.
