Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

function Main {
  if (Get-Command ldd -ErrorAction SilentlyContinue) {
    Write-Host "[OK] ldd is available"
    return
  }
  
  if ($IsMacOS) {
    & brew install ldd
    Write-Host "[OK] ldd installed"
  } elseif ($IsLinux) {
    & sudo apt-get update
    & sudo apt-get install -y ldd
    Write-Host "[OK] ldd installed"
  } else {
    Write-Host "[HINT] Install via package manager"
    exit 1
  }
}

Main
