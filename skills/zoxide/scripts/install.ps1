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

  # Check if zoxide is already installed
  if (Get-Command zoxide -ErrorAction SilentlyContinue) {
    $version = & zoxide --version
    Write-Host "[OK] zoxide: $version already installed"
  } else {
    Write-Host "[INFO] Installing zoxide..."

    switch ($platform) {
      'windows' {
        if (Get-Command winget -ErrorAction SilentlyContinue) {
          & winget install ajeetdsouha.zoxide
          Write-Host "[OK] zoxide installed"
        } else {
          Write-Host "[WARN] winget not found; skipping zoxide install"
          exit 1
        }
      }

      'macos' {
        if (Get-Command brew -ErrorAction SilentlyContinue) {
          & brew install zoxide
          Write-Host "[OK] zoxide installed"
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
              & sudo apt install -y zoxide
            }
            { $_ -in 'fedora', 'rhel', 'centos' } {
              & sudo dnf install -y zoxide
            }
            'arch' {
              & sudo pacman -S --noconfirm zoxide
            }
            'alpine' {
              & sudo apk add zoxide
            }
            default {
              Write-Host "[WARN] Unknown distro: $distro"
              exit 1
            }
          }
          Write-Host "[OK] zoxide installed"
        }
      }

      default {
        Write-Host "[ERROR] Unsupported platform: $platform"
        exit 1
      }
    }
  }

  # Check if fzf is already installed (optional but recommended)
  if (Get-Command fzf -ErrorAction SilentlyContinue) {
    $version = & fzf --version | ForEach-Object { $_ -split ' ' | Select-Object -First 1 }
    Write-Host "[OK] fzf: $version already installed"
  } else {
    Write-Host "[INFO] Installing fzf (optional, enables interactive zi)..."

    switch ($platform) {
      'windows' {
        if (Get-Command winget -ErrorAction SilentlyContinue) {
          & winget install junegunn.fzf
          Write-Host "[OK] fzf installed"
        } else {
          Write-Host "[WARN] winget not found; skipping fzf"
        }
      }

      'macos' {
        if (Get-Command brew -ErrorAction SilentlyContinue) {
          & brew install fzf
          Write-Host "[OK] fzf installed"
        } else {
          Write-Host "[WARN] Homebrew not found; skipping fzf"
        }
      }

      'linux' {
        if (Test-Path '/etc/os-release') {
          $osInfo = Get-Content /etc/os-release | ConvertFrom-StringData
          $distro = $osInfo.ID

          switch ($distro) {
            { $_ -in 'debian', 'ubuntu' } {
              & sudo apt install -y fzf
            }
            { $_ -in 'fedora', 'rhel', 'centos' } {
              & sudo dnf install -y fzf
            }
            'arch' {
              & sudo pacman -S --noconfirm fzf
            }
            default {
              Write-Host "[WARN] fzf not in package manager for this distro"
            }
          }
          Write-Host "[OK] fzf installed"
        }
      }

      default {
        Write-Host "[WARN] fzf not installed for this platform"
      }
    }
  }

  # Verify zoxide (required)
  if (Get-Command zoxide -ErrorAction SilentlyContinue) {
    & zoxide --version
    Write-Host "[OK] Installation verified"
    Write-Host ""
    Write-Host "[HINT] Add to `$PROFILE:"
    Write-Host "[HINT]   Invoke-Expression (& { (zoxide init powershell | Out-String) })"
    Write-Host "[HINT] Then reload: . `$PROFILE"
    Write-Host "[HINT] See 'references/install-and-setup.md' for complete setup steps"
  } else {
    Write-Host "[ERROR] Zoxide installation failed"
    exit 1
  }
}

Main
