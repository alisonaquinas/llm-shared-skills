# awk installer for Windows, macOS, Linux

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

  # Check if awk is available
  if (Test-Command "awk") {
    $version = & awk --version 2>&1 | Select-Object -First 1
    Write-Host "[OK] $version"
    Write-Host "[HINT] awk is already available"
    Write-Host "[HINT] See references/install-and-setup.md for details on variants"
    return 0
  }

  switch ($platform) {
    "windows" {
      Write-Host "[INFO] Installing awk on Windows..."

      # Try winget
      if (Get-Command winget -ErrorAction SilentlyContinue) {
        Write-Host "[INFO] Attempting to install via winget..."
        & winget install -e --id GnuWin32.Awk
        if ($LASTEXITCODE -eq 0) {
          Write-Host "[OK] awk installed via winget"
          & awk --version | Select-Object -First 1
          break
        }
      }

      # Try Chocolatey
      if (Get-Command choco -ErrorAction SilentlyContinue) {
        Write-Host "[INFO] Attempting to install via Chocolatey..."
        & choco install -y gawk
        Write-Host "[OK] gawk installed via Chocolatey"
        & awk --version | Select-Object -First 1
        break
      }

      # Suggest WSL2
      Write-Host "[HINT] awk not found via package managers"
      Write-Host "[HINT] Option 1: Install WSL2 and use Linux commands"
      Write-Host "[HINT] Option 2: Install Git Bash (includes awk)"
      Write-Host "[HINT] Option 3: Install Chocolatey or winget and retry"
      exit 1
    }

    "macos" {
      Write-Host "[INFO] Installing gawk on macOS via Homebrew..."
      if (Get-Command brew -ErrorAction SilentlyContinue) {
        & brew install gawk
        Write-Host "[OK] gawk installed"
        & awk --version | Select-Object -First 1
      }
      else {
        Write-Host "[ERROR] Homebrew not found. Install from https://brew.sh"
        exit 1
      }
    }

    "linux" {
      Write-Host "[INFO] Installing gawk on Linux via apt-get..."
      & sudo apt-get update
      & sudo apt-get install -y gawk
      Write-Host "[OK] gawk installed"
      & awk --version | Select-Object -First 1
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
