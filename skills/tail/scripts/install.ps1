# tail installer for Windows, macOS, Linux

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

function Get-Platform {
  if ($IsWindows) { return "windows" }
  elseif ($IsMacOS) { return "macos" }
  elseif ($IsLinux) { return "linux" }
  else { return "unknown" }
}

function Test-Command {
  param([string]$Command)
  try {
    $null = Invoke-Expression "$Command --version" 2>&1
    return $true
  }
  catch { return $false }
}

function Main {
  $platform = Get-Platform

  if (Test-Command "tail") {
    $version = & tail --version 2>&1 | Select-Object -First 1
    Write-Host "[OK] $version"
    Write-Host "[HINT] tail is already available"
    return 0
  }

  switch ($platform) {
    "windows" {
      Write-Host "[INFO] Installing tail on Windows..."
      if (Get-Command winget -ErrorAction SilentlyContinue) {
        & winget install -e --id GnuWin32.Coreutils
        if ($LASTEXITCODE -eq 0) {
          Write-Host "[OK] coreutils installed"
          break
        }
      }
      if (Get-Command choco -ErrorAction SilentlyContinue) {
        & choco install -y coreutils
        Write-Host "[OK] coreutils installed"
        break
      }
      Write-Host "[HINT] Option 1: Install WSL2"
      Write-Host "[HINT] Option 2: Install Git Bash"
      exit 1
    }
    "macos" {
      Write-Host "[INFO] tail is included in macOS"
      Write-Host "[OK] BSD tail is available"
    }
    "linux" {
      Write-Host "[INFO] Installing coreutils on Linux..."
      & sudo apt-get update
      & sudo apt-get install -y coreutils
      Write-Host "[OK] tail installed"
    }
    default {
      Write-Host "[ERROR] Unsupported platform"
      exit 1
    }
  }
}

Main
