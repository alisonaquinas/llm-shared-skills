[CmdletBinding()]
param(
    [switch]$Json
)

$profileInfo = [ordered]@{
    Current = $PROFILE
}

foreach ($name in 'AllUsersAllHosts', 'AllUsersCurrentHost', 'CurrentUserAllHosts', 'CurrentUserCurrentHost') {
    $path = $PROFILE.$name
    $profileInfo[$name] = [ordered]@{
        Path = $path
        Exists = [bool](Test-Path -LiteralPath $path)
    }
}

$aboutTopics = @(Get-Help about_* -ErrorAction SilentlyContinue)
$availableModules = @(Get-Module -ListAvailable | Sort-Object Name -Unique)
$coreCommands = @('Get-Help', 'Get-Command', 'Get-Member', 'Invoke-Command', 'Start-Job')

$commandHelp = foreach ($name in $coreCommands) {
    $text = Get-Help $name -ErrorAction SilentlyContinue | Out-String
    [pscustomobject]@{
        Name = $name
        Found = [bool]$text.Trim()
        Partial = ($text -match 'Get-Help cannot find the Help files')
    }
}

$data = [pscustomobject]@{
    Timestamp = Get-Date
    Version = $PSVersionTable.PSVersion.ToString()
    PSEdition = $PSVersionTable.PSEdition
    OS = $PSVersionTable.OS
    Platform = $PSVersionTable.Platform
    IsWindows = $IsWindows
    IsLinux = $IsLinux
    IsMacOS = $IsMacOS
    PSHome = $PSHOME
    CurrentLocation = (Get-Location).Path
    Home = $HOME
    Profiles = [pscustomobject]$profileInfo
    ModulePathEntries = @($env:PSModulePath -split [IO.Path]::PathSeparator)
    AvailableModuleCount = $availableModules.Count
    SampleModules = @($availableModules | Select-Object -First 20 -ExpandProperty Name)
    AboutTopicCount = $aboutTopics.Count
    AboutTopics = @($aboutTopics | Select-Object -ExpandProperty Name)
    CommandHelp = $commandHelp
    RemotingCommands = @(
        Get-Command -Name Enter-PSSession, Invoke-Command, New-PSSession -ErrorAction SilentlyContinue |
            Select-Object Name, CommandType, Source
    )
}

if ($Json) {
    $data | ConvertTo-Json -Depth 6
    exit 0
}

$data
