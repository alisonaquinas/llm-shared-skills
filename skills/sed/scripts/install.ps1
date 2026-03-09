# sed installer for Windows, macOS, Linux

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

  # Check if sed is available
  if (Test-Command "sed") {
    $version = & sed --version 2>&1 | Select-Object -First 1
    Write-Host "[OK] $version"
    Write-Host "[HINT] sed is already available"
    Write-Host "[HINT] See references/install-and-setup.md for details on variants"
    return 0
  }

  switch ($platform) {
    "windows" {
      Write-Host "[INFO] Installing sed on Windows..."

      # Try winget
      if (Get-Command winget -ErrorAction SilentlyContinue) {
        Write-Host "[INFO] Attempting to install via winget..."
        & winget install -e --id GnuWin32.Sed
        if ($LASTEXITCODE -eq 0) {
          Write-Host "[OK] sed installed via winget"
          & sed --version | Select-Object -First 1
          break
        }
      }

      # Try Chocolatey
      if (Get-Command choco -ErrorAction SilentlyContinue) {
        Write-Host "[INFO] Attempting to install via Chocolatey..."
        & choco install -y sed
        Write-Host "[OK] sed installed via Chocolatey"
        & sed --version | Select-Object -First 1
        break
      }

      # Suggest WSL2
      Write-Host "[HINT] sed not found via package managers"
      Write-Host "[HINT] Option 1: Install WSL2 and use Linux commands"
      Write-Host "[HINT] Option 2: Install Git Bash (includes sed)"
      Write-Host "[HINT] Option 3: Install Chocolatey or winget and retry"
      exit 1
    }

    "macos" {
      Write-Host "[INFO] sed is included in macOS (BSD sed)"
      Write-Host "[OK] BSD sed is available"
      Write-Host "[HINT] To install GNU sed, use: brew install gnu-sed"
    }

    "linux" {
      Write-Host "[INFO] Installing sed on Linux via apt-get..."
      & sudo apt-get update
      & sudo apt-get install -y sed
      Write-Host "[OK] sed installed"
      & sed --version | Select-Object -First 1
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
