function Get-SampleGreeting {
    [CmdletBinding()]
    param(
        [Parameter()]
        [string]$Name = 'world'
    )

    [pscustomobject]@{
        Message = "Hello, $Name"
    }
}
