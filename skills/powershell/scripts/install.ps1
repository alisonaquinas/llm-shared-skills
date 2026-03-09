#!/usr/bin/env pwsh
Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

function Get-Platform {
  if ($IsWindows) { return 'windows' }
  if ($IsMacOS) { return 'macos' }
  if ($IsLinux) { return 'linux' }
  return 'unknown'
}

function Main {
  $platform = Get-Platform

  # Check if pwsh is already installed
  if (Get-Command pwsh -ErrorAction SilentlyContinue) {
    $version = & pwsh --version
    Write-Host "[OK] $version already installed"
    Write-Host "[HINT] See 'references/install-and-setup.md' for post-install configuration"
    return
  }

  switch ($platform) {
    'windows' {
      Write-Host "[INFO] Installing PowerShell 7 on Windows via winget..."
      if (Get-Command winget -ErrorAction SilentlyContinue) {
        & winget install Microsoft.PowerShell
        Write-Host "[OK] PowerShell installed successfully"
      } else {
        Write-Host "[ERROR] winget not found"
        Write-Host "[HINT] Download from https://github.com/PowerShell/PowerShell/releases"
        exit 1
      }
    }

    'macos' {
      Write-Host "[INFO] Installing PowerShell on macOS via Homebrew..."
      if (Get-Command brew -ErrorAction SilentlyContinue) {
        & brew install powershell
        Write-Host "[OK] PowerShell installed successfully"
      } else {
        Write-Host "[ERROR] Homebrew not found. Install from https://brew.sh"
        exit 1
      }
    }

    'linux' {
      Write-Host "[INFO] Installing PowerShell on Linux..."
      Write-Host "[INFO] Adding Microsoft apt repository..."

      Invoke-WebRequest -Uri "https://aka.ms/install-powershell.sh" -OutFile /tmp/install-ps.sh
      & bash /tmp/install-ps.sh
      Remove-Item /tmp/install-ps.sh -Force

      Write-Host "[OK] PowerShell installed successfully"
    }

    default {
      Write-Host "[ERROR] Unsupported platform: $platform"
      exit 1
    }
  }

  # Verify installation
  if (Get-Command pwsh -ErrorAction SilentlyContinue) {
    & pwsh --version
    Write-Host "[OK] Installation verified"
    Write-Host ""
    Write-Host "[HINT] Create `$PROFILE with your settings"
    Write-Host "[HINT] See 'references/install-and-setup.md' for complete setup steps"
  } else {
    Write-Host "[ERROR] Installation verification failed"
    exit 1
  }
}

Main
