# Remoting, Jobs, And Debugging

Use this reference when the task involves remote execution, parallel/background work, tracing, or interactive debugging.

## Remoting

Key commands:

```powershell
Enter-PSSession -ComputerName server01
Invoke-Command -ComputerName server01 -ScriptBlock { Get-Process }
New-PSSession -ComputerName server01
```

- On Windows, WSMan/WinRM is the common transport.
- Cross-platform remoting commonly uses SSH transport.
- Confirm prerequisites before proposing remoting steps: listener availability, authentication method, trust boundary, and platform.

## Jobs and background work

```powershell
Start-Job -ScriptBlock { Get-Date }
Get-Job
Receive-Job -Id 1 -Keep
Remove-Job -Id 1
```

- Background jobs serialize results back to the caller.
- Explain that returned objects may be deserialized rather than live objects.
- For parallel execution, prefer the smallest mechanism that fits the task and platform.

## Parallel execution (PS 7+)

```powershell
# ForEach-Object -Parallel (PS 7+)
$servers | ForEach-Object -Parallel {
    Test-Connection -ComputerName $_ -Count 1 -Quiet
} -ThrottleLimit 10

# ThreadJob — lighter than Start-Job, no full runspace overhead
Import-Module ThreadJob
$job = Start-ThreadJob -ScriptBlock { expensive-work }
Receive-Job $job -Wait -AutoRemoveJob
```

- `ForEach-Object -Parallel` creates runspaces; `$_` is the current item.
- `-ThrottleLimit` caps concurrent runspaces (default 5).
- Variables from the outer scope are not automatically available inside `-Parallel`; use `$using:varName` to pass them in.
- `ThreadJob` shares the same process memory, making it faster to start but also easier to cause state conflicts.
- Neither approach preserves object type fidelity across runspace boundaries for complex objects.

## Debugging

```powershell
Set-PSBreakpoint -Script .\script.ps1 -Line 12
Wait-Debugger
Trace-Command -Name ParameterBinding -Expression { <command> } -PSHost
```

- Use `Trace-Command` for binding, type conversion, and provider issues.
- Use breakpoints when the failure is in script control flow.
- Use `Enter-PSHostProcess` only when cross-process debugging is clearly in scope.

## Streams and diagnostics

```powershell
$VerbosePreference = 'Continue'
$DebugPreference = 'Continue'
```

- Prefer `Write-Verbose` and `Write-Debug` over ad hoc host output in reusable scripts.
- Use `-Verbose` and `-Debug` in examples when the user is actively troubleshooting.

## What to call out in answers

- Transport and auth assumptions for remoting.
- Serialization boundaries for jobs and remote results.
- Whether the issue needs trace output, breakpoints, or a simplified repro first.
