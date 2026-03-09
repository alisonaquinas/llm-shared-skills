Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

function Main {
  if (Get-Command less -ErrorAction SilentlyContinue) {
    Write-Host "[OK] less is available"
    return
  }
  
  if ($IsMacOS) {
    & brew install less
    Write-Host "[OK] less installed"
  } elseif ($IsLinux) {
    & sudo apt-get update
    & sudo apt-get install -y less
    Write-Host "[OK] less installed"
  } else {
    Write-Host "[HINT] Install via package manager"
    exit 1
  }
}

Main
