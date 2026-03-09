# head installer for Windows, macOS, Linux

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

  # Check if head is available
  if (Test-Command "head") {
    $version = & head --version 2>&1 | Select-Object -First 1
    Write-Host "[OK] $version"
    Write-Host "[HINT] head is already available"
    Write-Host "[HINT] See references/install-and-setup.md for details on variants"
    return 0
  }

  switch ($platform) {
    "windows" {
      Write-Host "[INFO] Installing head on Windows..."

      # Try winget
      if (Get-Command winget -ErrorAction SilentlyContinue) {
        Write-Host "[INFO] Attempting to install via winget..."
        & winget install -e --id GnuWin32.Coreutils
        if ($LASTEXITCODE -eq 0) {
          Write-Host "[OK] coreutils installed via winget"
          & head --version | Select-Object -First 1
          break
        }
      }

      # Try Chocolatey
      if (Get-Command choco -ErrorAction SilentlyContinue) {
        Write-Host "[INFO] Attempting to install via Chocolatey..."
        & choco install -y coreutils
        Write-Host "[OK] coreutils installed via Chocolatey"
        & head --version | Select-Object -First 1
        break
      }

      # Suggest WSL2
      Write-Host "[HINT] head not found via package managers"
      Write-Host "[HINT] Option 1: Install WSL2 and use Linux commands"
      Write-Host "[HINT] Option 2: Install Git Bash (includes head)"
      Write-Host "[HINT] Option 3: Install Chocolatey or winget and retry"
      exit 1
    }

    "macos" {
      Write-Host "[INFO] head is included in macOS (BSD head)"
      $version = & head -n 1 /etc/passwd 2>&1 | Select-Object -First 1
      Write-Host "[OK] BSD head is available"
      Write-Host "[HINT] To install GNU coreutils, use: brew install coreutils"
    }

    "linux" {
      Write-Host "[INFO] Installing coreutils on Linux via apt-get..."
      & sudo apt-get update
      & sudo apt-get install -y coreutils
      Write-Host "[OK] head installed"
      & head --version | Select-Object -First 1
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
