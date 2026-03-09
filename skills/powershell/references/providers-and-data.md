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

## Environment Variables

### Session-Visible Variables

```powershell
$env:PATH
$env:PSModulePath
$env:CUSTOM_VAR="value"  # Set for this session only
```

These are visible only in the current PowerShell session. Not persistent across restarts.

### Persistent Variables with SetEnvironmentVariable

Set variables that persist across sessions:

```powershell
# Set in current process only (temporary)
[System.Environment]::SetEnvironmentVariable('MYVAR', 'value', 'Process')

# Set for current user (persistent, requires no admin)
[System.Environment]::SetEnvironmentVariable('MYVAR', 'value', 'User')

# Set for entire machine (persistent, requires admin)
[System.Environment]::SetEnvironmentVariable('MYVAR', 'value', 'Machine')
```

### Scope Table

| Scope | Persistence | Effect | Requires Admin |
|---|---|---|---|
| `Process` | Current session only | Immediately visible in $env: | No |
| `User` | User registry hive (persistent) | Visible in new PowerShell sessions for this user | No |
| `Machine` | HKEY_LOCAL_MACHINE registry (persistent) | Visible for ALL users on machine | Yes |

### Get Persistent Variables

```powershell
# Get current process (session) value
$env:PATH

# Get persistent User value
[System.Environment]::GetEnvironmentVariable('PATH', 'User')

# Get persistent Machine value
[System.Environment]::GetEnvironmentVariable('PATH', 'Machine')

# Get all three (will show differences)
'Process', 'User', 'Machine' | ForEach-Object {
  $scope = $_
  $val = [System.Environment]::GetEnvironmentVariable('PATH', $scope)
  Write-Host "$scope PATH:`n$val`n"
}
```

### Comparison: $env: vs Registry vs setx

| Method | Command | Persistence | When Visible | Platform |
|---|---|---|---|---|
| `$env:VAR = ` | `$env:PATH = ...` | Session only | Immediate in current shell | All |
| `SetEnvironmentVariable` | `[System.Environment]::SetEnvironmentVariable('VAR', 'value', 'User')` | Persistent (User/Machine) | Next new session | Windows/Linux/macOS |
| `setx` | `setx MYVAR value` | User-persistent | Next new cmd.exe only | Windows |
| Environment block (advanced) | Modify in registry directly | Persistent | Next new session | Windows |

### Caveats

- **$env:** changes are temporary; don't survive session restart
- **SetEnvironmentVariable 'User':** Requires no elevation; stored in user registry
- **SetEnvironmentVariable 'Machine':** Requires admin; affects all users
- **setx (Windows only):** Cmd.exe-specific; slower than SetEnvironmentVariable
- **PATH modifications:** Be careful not to overwrite existing PATH; append instead:

### Appending to PATH Safely

```powershell
# BAD: Overwrites existing PATH
[System.Environment]::SetEnvironmentVariable('PATH', 'C:\NewPath', 'User')

# GOOD: Append to existing PATH
$currentPath = [System.Environment]::GetEnvironmentVariable('PATH', 'User')
$newPath = "$currentPath;C:\NewPath"
[System.Environment]::SetEnvironmentVariable('PATH', $newPath, 'User')

# Or use a helper function
function Add-EnvPath {
  param($Path, $Scope = 'User')
  $currentPath = [System.Environment]::GetEnvironmentVariable('PATH', $Scope)
  if ($currentPath -notmatch [regex]::Escape($Path)) {
    $newPath = "$currentPath;$Path"
    [System.Environment]::SetEnvironmentVariable('PATH', $newPath, $Scope)
  }
}
```

## Common Data Formats

### JSON

```powershell
Get-Content .\data.json -Raw | ConvertFrom-Json
$object | ConvertTo-Json -Depth 5

# Check structure
$json = Get-Content .\data.json -Raw | ConvertFrom-Json
$json.PSObject.Properties | ForEach-Object { $_.Name }
```

- Use `-Raw` when reading JSON or XML as a whole document
- `ConvertTo-Json -Depth` controls recursion depth; default is 2 (often too shallow)
- Objects become `PSCustomObject`; access properties with dot notation

### CSV

```powershell
Import-Csv .\items.csv
Export-Csv .\items.csv -NoTypeInformation
```

- Import returns array of PSCustomObject
- Avoid CSV for values requiring rich typing (use JSON instead)
- `-NoTypeInformation` removes #TYPE comment line

### XML

```powershell
[xml]$xml = Get-Content .\data.xml
$xml.DocumentElement.SelectNodes('//item') | ForEach-Object { $_.InnerText }
```

- Cast to [xml] type; entire document parses at once
- Use XPath for navigation: `SelectNodes()`, `SelectSingleNode()`

### Text and CSV Parsing

```powershell
# Parse fixed-width or delimiter-separated manually
Get-Content .\data.txt | ForEach-Object {
  $parts = $_ -split '\s+'  # Whitespace separated
  [PSCustomObject]@{
    Col1 = $parts[0]
    Col2 = $parts[1]
  }
}
```

## Certificates and registry

- `Cert:` is useful for inspection and thumbprint-based workflows.
- `HKLM:` and `HKCU:` can be automated like filesystem paths on Windows.
- Be explicit when an answer is Windows-only.

## What to call out in answers

- Which provider the path belongs to.
- Whether the path is portable across OSes.
- Whether the result needs to preserve object types or only serialize text.
