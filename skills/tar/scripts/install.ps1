# tar installer for Windows, macOS, Linux

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

  if (Test-Command "tar") {
    $version = & tar --version 2>&1 | Select-Object -First 1
    Write-Host "[OK] $version"
    return 0
  }

  switch ($platform) {
    "windows" {
      Write-Host "[INFO] Installing tar on Windows..."
      if (Get-Command choco -ErrorAction SilentlyContinue) {
        & choco install -y gnuwin32-tar
        Write-Host "[OK] tar installed"
        break
      }
      Write-Host "[HINT] Install Chocolatey or use WSL2"
      exit 1
    }
    "macos" {
      Write-Host "[OK] tar is included in macOS"
    }
    "linux" {
      Write-Host "[INFO] Installing tar on Linux..."
      & sudo apt-get update
      & sudo apt-get install -y tar
      Write-Host "[OK] tar installed"
    }
    default {
      Write-Host "[ERROR] Unsupported platform"
      exit 1
    }
  }

  Write-Host "[HINT] See references/install-and-setup.md for details"
}

Main
