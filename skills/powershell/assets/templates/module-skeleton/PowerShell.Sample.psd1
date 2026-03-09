@{
    RootModule = 'PowerShell.Sample.psm1'
    ModuleVersion = '0.1.0'
    GUID = '11111111-1111-1111-1111-111111111111'
    Author = 'Codex'
    CompanyName = 'Local'
    Copyright = '(c) Local. All rights reserved.'
    Description = 'Minimal PowerShell module starter.'
    PowerShellVersion = '7.0'
    CompatiblePSEditions = @('Core')
    FunctionsToExport = @('Get-SampleGreeting')
    CmdletsToExport = @()
    VariablesToExport = @()
    AliasesToExport = @()

    PrivateData = @{
        PSData = @{
            Tags = @('Sample', 'Starter')
            ProjectUri = ''
            ReleaseNotes = '0.1.0 — initial release'
        }
    }
}
