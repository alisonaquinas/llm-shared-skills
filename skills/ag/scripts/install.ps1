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

  # Check if ag is already installed
  if (Get-Command ag -ErrorAction SilentlyContinue) {
    $version = & ag --version 2>&1 | Select-Object -First 1
    Write-Host "[OK] $version already installed"
    Write-Host "[HINT] See 'references/install-and-setup.md' for post-install configuration"
    return
  }

  switch ($platform) {
    'windows' {
      Write-Host "[INFO] Installing The Silver Searcher on Windows via winget..."
      if (Get-Command winget -ErrorAction SilentlyContinue) {
        & winget install ggreer.ag
        Write-Host "[OK] ag installed successfully"
      } else {
        Write-Host "[ERROR] winget not found. Download from https://github.com/ggreer/the_silver_searcher/releases"
        exit 1
      }
    }

    'macos' {
      Write-Host "[INFO] Installing The Silver Searcher on macOS via Homebrew..."
      if (Get-Command brew -ErrorAction SilentlyContinue) {
        & brew install the_silver_searcher
        Write-Host "[OK] ag installed successfully"
      } else {
        Write-Host "[ERROR] Homebrew not found. Install from https://brew.sh"
        exit 1
      }
    }

    'linux' {
      Write-Host "[INFO] Installing The Silver Searcher on Linux..."
      if (Test-Path '/etc/os-release') {
        $osInfo = Get-Content /etc/os-release | ConvertFrom-StringData
        $distro = $osInfo.ID

        switch ($distro) {
          { $_ -in 'debian', 'ubuntu' } {
            & sudo apt update
            & sudo apt install -y silversearcher-ag
          }
          { $_ -in 'fedora', 'rhel', 'centos' } {
            & sudo dnf install -y the_silver_searcher
          }
          'arch' {
            & sudo pacman -S --noconfirm the_silver_searcher
          }
          'alpine' {
            & sudo apk add the_silver_searcher
          }
          default {
            Write-Host "[WARN] Unknown distro: $distro"
            exit 1
          }
        }
        Write-Host "[OK] ag installed successfully"
      } else {
        Write-Host "[ERROR] Cannot detect Linux distro"
        exit 1
      }
    }

    default {
      Write-Host "[ERROR] Unsupported platform: $platform"
      exit 1
    }
  }

  # Verify installation
  if (Get-Command ag -ErrorAction SilentlyContinue) {
    & ag --version
    Write-Host "[OK] Installation verified"
    Write-Host ""
    Write-Host "[HINT] Create ~/.agignore to ignore patterns globally"
    Write-Host "[HINT] See 'references/install-and-setup.md' for complete setup steps"
  } else {
    Write-Host "[ERROR] Installation verification failed"
    exit 1
  }
}

Main
