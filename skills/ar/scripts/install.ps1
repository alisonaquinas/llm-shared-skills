# ar installer for Windows, macOS, Linux

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

function Get-Platform {
  if ($IsWindows) {
    return "windows"
  }
  elseif ($IsMacOS) {
    return "macos"
  }
  elseif ($IsLinux) {
    return "linux"
  }
  else {
    return "unknown"
  }
}

function Test-Command {
  param([string]$Command)
  try {
    $null = Invoke-Expression "$Command --version" 2>&1
    return $true
  }
  catch {
    return $false
  }
}

function Main {
  $platform = Get-Platform

  # Check if ar is available
  if (Test-Command "ar") {
    $version = & ar --version 2>&1 | Select-Object -First 1
    Write-Host "[OK] $version"
    Write-Host "[HINT] ar is already available"
    return 0
  }

  switch ($platform) {
    "windows" {
      Write-Host "[INFO] Installing ar (binutils) on Windows..."

      # Try Chocolatey
      if (Get-Command choco -ErrorAction SilentlyContinue) {
        Write-Host "[INFO] Attempting to install via Chocolatey..."
        & choco install -y binutils
        Write-Host "[OK] binutils installed via Chocolatey"
        & ar --version | Select-Object -First 1
        break
      }

      # Try scoop
      if (Get-Command scoop -ErrorAction SilentlyContinue) {
        Write-Host "[INFO] Attempting to install via scoop..."
        & scoop install binutils
        Write-Host "[OK] binutils installed via scoop"
        break
      }

      Write-Host "[HINT] ar not found via package managers"
      Write-Host "[HINT] Option 1: Install MinGW or MSYS2"
      Write-Host "[HINT] Option 2: Install WSL2 and use Linux"
      exit 1
    }

    "macos" {
      Write-Host "[INFO] ar is included in macOS (Xcode tools)"
      Write-Host "[OK] ar is available"
      Write-Host "[HINT] If missing, install: xcode-select --install"
    }

    "linux" {
      Write-Host "[INFO] Installing binutils on Linux via apt-get..."
      & sudo apt-get update
      & sudo apt-get install -y binutils
      Write-Host "[OK] ar installed"
      & ar --version | Select-Object -First 1
    }

    default {
      Write-Host "[ERROR] Unsupported platform: $platform"
      Write-Host "[HINT] See references/install-and-setup.md for manual installation"
      exit 1
    }
  }

  Write-Host "[HINT] See references/install-and-setup.md for post-install configuration"
}

Main
