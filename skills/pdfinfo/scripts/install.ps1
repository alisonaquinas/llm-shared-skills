Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

function Main {
  if (Get-Command pdfinfo -ErrorAction SilentlyContinue) {
    Write-Host "[OK] pdfinfo is available"
    return
  }
  
  if ($IsWindows) {
    Write-Host "[HINT] Use WSL2, Chocolatey, or package manager"
    exit 1
  } elseif ($IsMacOS) {
    & brew install pdfinfo
    Write-Host "[OK] pdfinfo installed"
  } elseif ($IsLinux) {
    & sudo apt-get update
    & sudo apt-get install -y pdfinfo
    Write-Host "[OK] pdfinfo installed"
  }
}

Main
