[CmdletBinding()]
param(
    [switch]$Json,
    [string[]]$CommandName = @(
        'Get-Help',
        'Get-Command',
        'Get-ChildItem',
        'Where-Object',
        'ForEach-Object',
        'Invoke-Command',
        'New-ModuleManifest'
    )
)

$aboutTopics = @(Get-Help about_* -ErrorAction SilentlyContinue | Sort-Object Name)

$commands = foreach ($name in $CommandName) {
    $text = Get-Help $name -ErrorAction SilentlyContinue | Out-String
    [pscustomobject]@{
        Name = $name
        Found = [bool]$text.Trim()
        Partial = ($text -match 'Get-Help cannot find the Help files')
        OnlineHint = ($text -match 'type: "Get-Help .* -Online"')
    }
}

$data = [pscustomobject]@{
    Timestamp = Get-Date
    AboutTopicCount = $aboutTopics.Count
    AboutTopics = @($aboutTopics | Select-Object -ExpandProperty Name)
    Commands = $commands
}

if ($Json) {
    $data | ConvertTo-Json -Depth 5
    exit 0
}

$data
