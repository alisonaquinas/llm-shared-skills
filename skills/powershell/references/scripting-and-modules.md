# Scripting And Modules

Use this reference when writing `.ps1` scripts, profiles, functions, advanced functions, or reusable modules.

## Script structure

- Prefer `param()` at the top of scripts.
- Use `Set-StrictMode -Version Latest` when you want safer script behavior.
- Keep side effects explicit and return objects instead of formatted text.

```powershell
[CmdletBinding()]
param(
    [Parameter(Mandatory)]
    [string]$Path
)
```

## Functions and advanced functions

- Use `[CmdletBinding()]` for common parameters and better parameter binding.
- Add comment-based help when the function is intended for reuse.
- Use `SupportsShouldProcess` for operations that change state.
- Prefer pipeline-aware parameters only when pipeline behavior is intentional and tested.
- Add `[OutputType([TypeName])]` before `[CmdletBinding()]` to document the return type for IDEs and pipeline callers.

```powershell
[OutputType([PSCustomObject])]
[CmdletBinding()]
param([string]$Name)
```

Use `assets/templates/advanced-function.ps1` as the default starter.

## Profiles

Important profile paths live on the `$PROFILE` automatic variable:

```powershell
$PROFILE
$PROFILE.CurrentUserCurrentHost
$PROFILE.CurrentUserAllHosts
$PROFILE.AllUsersCurrentHost
$PROFILE.AllUsersAllHosts
```

- Use `Test-Path $PROFILE.CurrentUserCurrentHost` before assuming the file exists.
- Use `pwsh -NoProfile` to isolate profile-related startup problems.

## Modules

- Script modules: `.psm1`
- Binary modules: `.dll`
- Module manifests: `.psd1`

Core workflow:

```powershell
New-ModuleManifest -Path .\MyModule.psd1 -RootModule MyModule.psm1
Import-Module .\MyModule.psd1 -Force
Get-Command -Module MyModule
```

- Prefer explicit `FunctionsToExport` and `AliasesToExport` in manifests.
- Keep public commands under a `Public/` folder and internal helpers under `Private/` when using a folder-based pattern.
- Use `assets/templates/module-skeleton/` when starting a small reusable module.

## Testing with Pester

```powershell
# Minimal Pester test file (Pester 5+)
Describe 'Get-SampleGreeting' {
    It 'returns a string' {
        $result = Get-SampleGreeting -Name 'World'
        $result | Should -BeOfType [string]
    }
    It 'includes the name' {
        Get-SampleGreeting -Name 'Ada' | Should -Match 'Ada'
    }
}
```

- Run with `Invoke-Pester` from the module root.
- Pester 5+ uses `Should -Be`, `Should -Match`, `Should -Throw` assertion syntax.
- Use `BeforeAll`/`AfterAll` for setup/teardown that applies to a whole `Describe` block.

## Packaging and discovery

```powershell
Get-Module -ListAvailable
Find-Module Pester
Install-Module Pester -Scope CurrentUser
```

- Separate built-in modules from gallery-installed modules in explanations.
- Call out repository trust and execution policy when proposing installs on Windows.
- Add `CompatiblePSEditions = @('Core')` to manifests targeting PowerShell 7+ only; omit or use `@('Desktop','Core')` for dual-edition modules.

## What to call out in answers

- Whether the user is writing a one-off script, a reusable function, or a module.
- Whether profile scope matters.
- Whether the request should return objects, write host text, or both.
