# CLI And Help

Use this reference when the request is about launching PowerShell, controlling session startup, or finding the right help topic.

## `pwsh.exe` launch modes

- `pwsh -NoLogo -NoProfile`
  Start a clean interactive session.
- `pwsh -File .\script.ps1 arg1 arg2`
  Run a script file. Everything after the file path is treated as script input.
- `pwsh -Command '<script>'`
  Run inline PowerShell and exit unless `-NoExit` is also used.
- `pwsh -Command -`
  Read commands from standard input.
- `pwsh -EncodedCommand <base64>`
  Use for nested quoting only when plain text would be fragile. The encoded payload is UTF-16.

## High-value flags

- `-NoProfile`
  Skip profile loading. Use first when startup behavior is suspicious.
- `-NonInteractive`
  Prevent prompts from hanging scheduled tasks or CI jobs.
- `-WorkingDirectory <path>`
  Set the initial location at startup.
- `-ExecutionPolicy <policy>`
  Session-scoped override on Windows only.
- `-OutputFormat XML`
  Emit CLIXML when the caller needs serialized objects instead of formatted text.
- `-Login`
  Linux and macOS only. Must be first to behave as a login shell.

## Help workflow

Use the smallest help query that resolves the task:

```powershell
pwsh -?
Get-Help Get-Item -Examples
Get-Help Get-Item -Detailed
Get-Help Get-Item -Full
Get-Help Get-Item -Online
Get-Help about_Quoting_Rules -Online
Get-Help about_* | Sort-Object Name
```

## Discovery workflow

```powershell
Get-Command <name> -All
Get-Command -Verb Get
Get-Command -Noun Service
Get-Module -ListAvailable
Find-Module <name>
```

- Use `Get-Command` when you need to know whether a name resolves to an alias, function, script, or cmdlet.
- Use `Get-Member` after a pipeline when you need object shape instead of text.

## Local help gaps

- Many machines have partial help until `Update-Help` has been run.
- `Get-Help about_*` coverage can be sparse in minimal installs.
- When local help is incomplete, use `-Online` or Microsoft Learn directly instead of guessing.

## Common launch patterns

```powershell
# Clean one-off command
pwsh -NoLogo -NoProfile -Command 'Get-Date'

# Script automation
pwsh -NoLogo -NoProfile -NonInteractive -File .\build.ps1 -Configuration Release

# Preserve an external process exit code
pwsh -NoLogo -NoProfile -Command '& .\tool.cmd; exit $LASTEXITCODE'
```

## What to call out in answers

- Which shell parses the command line first.
- Whether the user needs an interactive session or an automation-safe one.
- Whether the request depends on local help, online help, or both.
- Whether Windows-only behavior is involved.
