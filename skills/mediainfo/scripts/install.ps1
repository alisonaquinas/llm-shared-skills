Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

function Main {
  if (Get-Command mediainfo -ErrorAction SilentlyContinue) {
    Write-Host "[OK] mediainfo is available"
    return
  }
  
  if ($IsWindows) {
    Write-Host "[HINT] Use WSL2, Chocolatey, or package manager"
    exit 1
  } elseif ($IsMacOS) {
    & brew install mediainfo
    Write-Host "[OK] mediainfo installed"
  } elseif ($IsLinux) {
    & sudo apt-get update
    & sudo apt-get install -y mediainfo
    Write-Host "[OK] mediainfo installed"
  }
}

Main
