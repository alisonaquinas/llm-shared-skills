Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

function Main {
  if (Get-Command exiftool -ErrorAction SilentlyContinue) {
    Write-Host "[OK] exiftool is available"
    return
  }
  
  if ($IsWindows) {
    Write-Host "[HINT] Use WSL2, Chocolatey, or package manager"
    exit 1
  } elseif ($IsMacOS) {
    & brew install exiftool
    Write-Host "[OK] exiftool installed"
  } elseif ($IsLinux) {
    & sudo apt-get update
    & sudo apt-get install -y exiftool
    Write-Host "[OK] exiftool installed"
  }
}

Main
