# Providers And Data

Use this reference when the task touches paths, PSDrives, the registry, environment variables, certificates, or common file/data formats.

## Providers and PSDrives

PowerShell exposes data stores through providers, which means the same verbs often work across multiple surfaces.

```powershell
Get-PSProvider
Get-PSDrive
Set-Location Env:
Get-ChildItem Cert:\CurrentUser\My
Get-ChildItem HKCU:\Software
```

- FileSystem, Environment, Alias, Function, Variable, and Certificate providers are common across PowerShell 7.
- Registry provider is Windows-only.

## Path guidance

- Prefer `Join-Path` over manual path concatenation.
- Use `Test-Path` before destructive or assumption-heavy operations.
- Use `Resolve-Path` when a provider path may be relative or wildcarded.

## Environment variables

```powershell
$env:PATH
$env:PSModulePath
[System.Environment]::GetEnvironmentVariable('PATH', 'Machine')
```

- `$env:NAME` is session-visible and string-based.
- Persistent machine or user changes depend on platform and permission model.

## Common data formats

```powershell
Get-Content .\data.json -Raw | ConvertFrom-Json
$object | ConvertTo-Json -Depth 5
Import-Csv .\items.csv
Export-Csv .\items.csv -NoTypeInformation
```

- Use `-Raw` when reading JSON or XML as a whole document.
- Call out `ConvertTo-Json -Depth` when nested objects matter.
- Avoid CSV for values that require rich typing unless the tradeoff is acceptable.

## Certificates and registry

- `Cert:` is useful for inspection and thumbprint-based workflows.
- `HKLM:` and `HKCU:` can be automated like filesystem paths on Windows.
- Be explicit when an answer is Windows-only.

## What to call out in answers

- Which provider the path belongs to.
- Whether the path is portable across OSes.
- Whether the result needs to preserve object types or only serialize text.
