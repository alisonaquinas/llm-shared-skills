[CmdletBinding()]
param(
    [switch]$Json
)

function Invoke-NativeExitCodeProbe {
    if ($IsWindows) {
        & cmd.exe /c exit 7
    }
    else {
        & /bin/sh -lc 'exit 7'
    }

    [pscustomobject]@{
        Name = 'ExitCode'
        LastExitCode = $LASTEXITCODE
        PowerShellSuccess = $?
    }
}

function Invoke-NativeStreamProbe {
    if ($IsWindows) {
        $stderrPath = [IO.Path]::GetTempFileName()
        try {
            $stdout = & cmd.exe /c '(echo stdout) & (echo stderr 1>&2)' 2> $stderrPath
            $stderr = Get-Content -LiteralPath $stderrPath -Raw
        }
        finally {
            Remove-Item -LiteralPath $stderrPath -ErrorAction SilentlyContinue
        }
    }
    else {
        $stderrPath = [IO.Path]::GetTempFileName()
        try {
            $stdout = & /bin/sh -lc 'printf "stdout\n"; printf "stderr\n" >&2' 2> $stderrPath
            $stderr = Get-Content -LiteralPath $stderrPath -Raw
        }
        finally {
            Remove-Item -LiteralPath $stderrPath -ErrorAction SilentlyContinue
        }
    }

    [pscustomobject]@{
        Name = 'Streams'
        StdOut = @($stdout)
        StdErr = $stderr.TrimEnd()
    }
}

function Invoke-ChildPwshArgumentProbe {
    $pwshPath = (Get-Command pwsh).Source
    # Pass the script block as a string to -Command, then append arguments after '--'
    $output = & $pwshPath -NoLogo -NoProfile -Command '$args | ForEach-Object { "arg:[$_]" }' -- 'one two' 'a"b' '$HOME'

    [pscustomobject]@{
        Name = 'ChildPwshArguments'
        Output = @($output)
    }
}

$data = [pscustomobject]@{
    Timestamp = Get-Date
    Platform = $PSVersionTable.Platform
    Probes = @(
        Invoke-NativeExitCodeProbe
        Invoke-NativeStreamProbe
        Invoke-ChildPwshArgumentProbe
    )
}

if ($Json) {
    $data | ConvertTo-Json -Depth 5
    exit 0
}

$data
