Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

function Main {
  if (Get-Command tree -ErrorAction SilentlyContinue) {
    Write-Host "[OK] tree is available"
    return
  }
  
  if ($IsMacOS) {
    & brew install tree
    Write-Host "[OK] tree installed"
  } elseif ($IsLinux) {
    & sudo apt-get update
    & sudo apt-get install -y tree
    Write-Host "[OK] tree installed"
  } else {
    Write-Host "[HINT] Install via package manager"
    exit 1
  }
}

Main
