Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

function Main {
  if (Get-Command xmllint -ErrorAction SilentlyContinue) {
    Write-Host "[OK] xmllint is available"
    return
  }
  
  if ($IsWindows) {
    Write-Host "[HINT] Use WSL2, Chocolatey, or package manager"
    exit 1
  } elseif ($IsMacOS) {
    & brew install xmllint
    Write-Host "[OK] xmllint installed"
  } elseif ($IsLinux) {
    & sudo apt-get update
    & sudo apt-get install -y xmllint
    Write-Host "[OK] xmllint installed"
  }
}

Main
