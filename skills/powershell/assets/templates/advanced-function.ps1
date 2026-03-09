function Invoke-SampleOperation {
    <#
    .SYNOPSIS
    Perform a sample state-changing operation safely.

    .DESCRIPTION
    Use this starter when building reusable advanced functions. It includes
    comment-based help, strict parameter binding, pipeline support, and
    ShouldProcess semantics.

    .PARAMETER Path
    The path to inspect or change.

    .PARAMETER Force
    Allow the operation to proceed when extra confirmation would otherwise be required.

    .EXAMPLE
    Invoke-SampleOperation -Path .\input.txt -WhatIf
    #>
    [OutputType([PSCustomObject])]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
    param(
        [Parameter(Mandatory, ValueFromPipeline, ValueFromPipelineByPropertyName)]
        [ValidateNotNullOrEmpty()]
        [string]$Path,

        [switch]$Force
    )

    begin {
        Set-StrictMode -Version Latest
    }

    process {
        if ($PSCmdlet.ShouldProcess($Path, 'Run sample operation')) {
            try {
                [pscustomobject]@{
                    Path = $Path
                    Exists = Test-Path -LiteralPath $Path
                    Force = $Force.IsPresent
                }
            }
            catch {
                Write-Error "Failed processing '$Path': $_"
            }
        }
    }

    end {
        # Post-pipeline cleanup or summary output goes here.
    }
}
