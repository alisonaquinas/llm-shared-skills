Get-ChildItem -Path (Join-Path $PSScriptRoot 'Public') -Filter *.ps1 |
    ForEach-Object {
        . $_.FullName
    }

Export-ModuleMember -Function Get-SampleGreeting
