# 7z installer for Windows, macOS, Linux

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
    $null = Invoke-Expression "$Command --help" 2>&1
    return $true
  }
  catch {
    return $false
  }
}

function Main {
  $platform = Get-Platform

  # Check if 7z is available
  if (Test-Command "7z") {
    $version = & 7z --help 2>&1 | Select-Object -First 1
    Write-Host "[OK] $version"
    Write-Host "[HINT] 7z is already available"
    return 0
  }

  switch ($platform) {
    "windows" {
      Write-Host "[INFO] Installing 7z on Windows..."

      # Try Chocolatey
      if (Get-Command choco -ErrorAction SilentlyContinue) {
        Write-Host "[INFO] Attempting to install via Chocolatey..."
        & choco install -y 7zip
        Write-Host "[OK] 7zip installed via Chocolatey"
        & 7z --help | Select-Object -First 1
        break
      }

      # Try winget
      if (Get-Command winget -ErrorAction SilentlyContinue) {
        Write-Host "[INFO] Attempting to install via winget..."
        & winget install -e --id 7zip.7zip
        if ($LASTEXITCODE -eq 0) {
          Write-Host "[OK] 7zip installed via winget"
          break
        }
      }

      Write-Host "[HINT] 7z not found via package managers"
      Write-Host "[HINT] Install from https://www.7-zip.org/"
      exit 1
    }

    "macos" {
      Write-Host "[INFO] Installing p7zip on macOS via Homebrew..."
      if (Get-Command brew -ErrorAction SilentlyContinue) {
        & brew install p7zip
        Write-Host "[OK] p7zip installed"
        & 7z --help | Select-Object -First 1
      }
      else {
        Write-Host "[ERROR] Homebrew not found. Install from https://brew.sh"
        exit 1
      }
    }

    "linux" {
      Write-Host "[INFO] Installing p7zip on Linux via apt-get..."
      & sudo apt-get update
      & sudo apt-get install -y p7zip-full p7zip-rar
      Write-Host "[OK] p7zip installed"
      & 7z --help | Select-Object -First 1
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
