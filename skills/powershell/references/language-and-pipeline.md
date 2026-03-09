# Language And Pipeline

Use this reference when the task is about syntax, quoting, expressions, objects, formatting, redirection, or native command interop.

## Parsing model

- PowerShell parses command lines in expression mode first, then argument mode for command invocation.
- A failure to separate those modes usually shows up as surprising quoting or parameter binding behavior.
- Native commands do not receive PowerShell objects. They receive strings and the process exit code becomes `$LASTEXITCODE`.

## Quoting rules

- Single quotes are literal.
- Double quotes expand variables and subexpressions like `$name` and `$(...)`.
- Here-strings are best for multi-line content and embedded quotes.
- Use the stop-parsing token `--%` only for Windows-native commands and only when simpler quoting is not workable.

## Pipeline rules

- The PowerShell pipeline moves objects between commands.
- Formatting cmdlets such as `Format-Table` are for display, not for downstream automation.
- Filter early with `Where-Object` and project explicitly with `Select-Object` when shaping output.

```powershell
Get-Process |
  Where-Object CPU -gt 100 |
  Select-Object Name, CPU
```

## Object inspection

```powershell
Get-Process | Get-Member
Get-ChildItem | Select-Object -First 1 | Format-List * -Force
```

- Use `Get-Member` to learn available properties and methods.
- Use `Format-List * -Force` to see hidden and adapted properties during troubleshooting.

## Redirection and streams

PowerShell has separate success, error, warning, verbose, debug, information, and progress streams.

```powershell
command > out.txt
command 2> err.txt
command *> all.txt
```

- Native stderr still lands in PowerShell's error stream boundary for redirection purposes.
- Do not treat console formatting as structured data unless that is the only surface available.

## Native command boundaries

- If the caller is `cmd.exe`, `%VAR%` expansion happens before PowerShell sees the command.
- If the caller is Bash, shell quoting happens before PowerShell sees the command.
- If the caller is PowerShell, `$env:NAME` and script blocks can be interpreted by PowerShell before a child `pwsh` process is started.
- Use `scripts/test-native-boundaries.ps1` when the issue is not obvious.

## High-value patterns

```powershell
# Expand inside PowerShell
pwsh -Command '$env:TEMP'

# Pass a literal string from cmd.exe
pwsh -File .\script.ps1 -Value %TEMP%

# Avoid formatted output in automation
Get-Service | Select-Object Name, Status | ConvertTo-Json
```

## Error handling

```powershell
$ErrorActionPreference = 'Stop'   # make all errors terminating in the current scope

try {
    Get-Item -Path $path -ErrorAction Stop
}
catch [System.IO.FileNotFoundException] {
    Write-Warning "File not found: $path"
}
catch {
    throw   # re-throw unexpected errors
}
finally {
    # always runs, even on throw
    Write-Verbose 'Cleanup complete'
}
```

- **Terminating errors** stop the pipeline immediately; `try`/`catch` handles them.
- **Non-terminating errors** write to the error stream and continue; use `-ErrorAction Stop` or `$ErrorActionPreference = 'Stop'` to promote them.
- `$?` reflects whether the last statement succeeded in PowerShell terms.
- `$LASTEXITCODE` holds the numeric exit code of the most recent native (non-PowerShell) process.
- Do not rely on `$?` after a native command; always check `$LASTEXITCODE` instead.

## What to call out in answers

- Whether the user wants display output or structured automation output.
- Whether the failure is in parsing, parameter binding, or native-process behavior.
- Whether `$?` or `$LASTEXITCODE` is the relevant success signal.
- Whether the error is terminating or non-terminating, and which promotion strategy applies.
