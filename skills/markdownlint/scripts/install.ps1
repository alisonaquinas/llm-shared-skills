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

  # Check if markdownlint-cli2 is already installed
  if (Get-Command markdownlint-cli2 -ErrorAction SilentlyContinue) {
    $version = & markdownlint-cli2 --version
    Write-Host "[OK] markdownlint-cli2 $version already installed"
    Write-Host "[HINT] See 'references/install-and-setup.md' for post-install configuration"
    return
  }

  # Check if Node.js is installed (required dependency)
  if (-not (Get-Command npm -ErrorAction SilentlyContinue)) {
    Write-Host "[INFO] Node.js/npm not found. Installing first..."

    switch ($platform) {
      'windows' {
        if (Get-Command winget -ErrorAction SilentlyContinue) {
          & winget install OpenJS.NodeJS
        } else {
          Write-Host "[ERROR] winget not found. Install Node.js manually from https://nodejs.org"
          exit 1
        }
      }

      'macos' {
        if (Get-Command brew -ErrorAction SilentlyContinue) {
          & brew install node
        } else {
          Write-Host "[ERROR] Homebrew not found. Install from https://brew.sh"
          exit 1
        }
      }

      'linux' {
        if (Test-Path '/etc/os-release') {
          $osInfo = Get-Content /etc/os-release | ConvertFrom-StringData
          $distro = $osInfo.ID

          switch ($distro) {
            { $_ -in 'debian', 'ubuntu' } {
              & sudo apt update
              & sudo apt install -y nodejs npm
            }
            { $_ -in 'fedora', 'rhel', 'centos' } {
              & sudo dnf install -y nodejs
            }
            'arch' {
              & sudo pacman -S --noconfirm nodejs npm
            }
            default {
              Write-Host "[WARN] Unknown distro: $distro"
              exit 1
            }
          }
        }
      }

      default {
        Write-Host "[ERROR] Unsupported platform: $platform"
        exit 1
      }
    }
  }

  # Verify Node.js installation
  if (-not (Get-Command npm -ErrorAction SilentlyContinue)) {
    Write-Host "[ERROR] npm installation failed"
    exit 1
  }

  & npm --version
  Write-Host "[OK] npm available"

  # Install markdownlint-cli2
  Write-Host "[INFO] Installing markdownlint-cli2 globally..."
  & npm install -g markdownlint-cli2
  Write-Host "[OK] markdownlint-cli2 installed successfully"

  # Verify installation
  if (Get-Command markdownlint-cli2 -ErrorAction SilentlyContinue) {
    & markdownlint-cli2 --version
    Write-Host "[OK] Installation verified"
    Write-Host ""
    Write-Host "[HINT] Create .markdownlint-cli2.jsonc in project root for custom rules"
    Write-Host "[HINT] See 'references/install-and-setup.md' for complete setup steps"
  } else {
    Write-Host "[ERROR] Installation verification failed"
    exit 1
  }
}

Main
