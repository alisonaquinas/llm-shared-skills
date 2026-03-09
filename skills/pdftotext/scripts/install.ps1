Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

function Main {
  if (Get-Command pdftotext -ErrorAction SilentlyContinue) {
    Write-Host "[OK] pdftotext is available"
    return
  }
  
  if ($IsWindows) {
    Write-Host "[HINT] Use WSL2, Chocolatey, or package manager"
    exit 1
  } elseif ($IsMacOS) {
    & brew install pdftotext
    Write-Host "[OK] pdftotext installed"
  } elseif ($IsLinux) {
    & sudo apt-get update
    & sudo apt-get install -y pdftotext
    Write-Host "[OK] pdftotext installed"
  }
}

Main
