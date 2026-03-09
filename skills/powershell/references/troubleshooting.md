# Troubleshooting

Use this reference when the user has a failing command, a startup problem, or unclear PowerShell behavior.

## First-pass triage

```powershell
scripts/probe-pwsh.ps1
$PSVersionTable
$Error[0] | Format-List * -Force
Get-Location
Get-Command <name> -All
```

Classify the failure before changing anything:

- launch issue
- help/discovery issue
- parsing or quoting issue
- parameter binding issue
- provider/path issue
- module/import issue
- remoting/auth issue
- native-process issue

## Startup and profile problems

```powershell
pwsh -NoLogo -NoProfile
Test-Path $PROFILE.CurrentUserCurrentHost
```

- If `-NoProfile` fixes the issue, inspect profile files before touching module code.
- Use the profile paths reported by `scripts/probe-pwsh.ps1`.

## Help and discovery problems

```powershell
scripts/collect-help-index.ps1
Get-Help Get-Help -Full
Get-Help about_* | Sort-Object Name
```

- Partial help is common on fresh or locked-down environments.
- Use `Get-Help <name> -Online` when local help is incomplete.

## Binding and parsing problems

```powershell
Trace-Command -Name ParameterBinding -Expression { <command> } -PSHost
Set-PSDebug -Trace 1
```

- Prefer a minimal repro over a long shell transcript.
- If a native executable is involved, check which shell parsed the command line first.

## Native command problems

```powershell
scripts/test-native-boundaries.ps1
```

- Use `$LASTEXITCODE` for native process result handling.
- Use `$?` for the success state of the last PowerShell pipeline.

## Data and output problems

- Replace `Format-Table` or `Out-String` with `Select-Object`, `ConvertTo-Json`, or raw object output when the task is automation.
- Use `Get-Member` to verify the actual object shape.

## What to call out in answers

- Concrete version and platform facts.
- The smallest reproducible command that fails.
- Whether the failure is runtime truth, local-help coverage, or documentation mismatch.
