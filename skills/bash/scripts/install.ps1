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

  # Check if bash is available
  if (Get-Command bash -ErrorAction SilentlyContinue) {
    $version = & bash --version | Select-Object -First 1
    Write-Host "[OK] $version"
    Write-Host "[HINT] Bash is already available"
    Write-Host "[HINT] See 'references/install-and-setup.md' for post-install configuration"
    return
  }

  switch ($platform) {
    'windows' {
      Write-Host "[INFO] Installing Bash on Windows via WSL2..."
      Write-Host "[INFO] This requires admin rights and will install WSL2"
      Write-Host "[WARN] WSL2 requires Hyper-V or Windows 11 native virtualization"
      Write-Host ""

      if (Get-Command wsl -ErrorAction SilentlyContinue) {
        & wsl --install
        Write-Host "[OK] WSL2 installed. Please restart your computer."
      } else {
        Write-Host "[ERROR] Cannot install WSL2. Try manually:"
        Write-Host "[HINT]   wsl --install"
        exit 1
      }
    }

    'macos' {
      Write-Host "[INFO] Installing Bash on macOS via Homebrew (upgrading from 3.2)..."
      if (Get-Command brew -ErrorAction SilentlyContinue) {
        & brew install bash
        Write-Host "[OK] Bash installed via Homebrew"
        Write-Host "[WARN] To use as default shell:"
        Write-Host "[HINT]   sudo bash -c 'echo /opt/homebrew/bin/bash >> /etc/shells'"
        Write-Host "[HINT]   chsh -s /opt/homebrew/bin/bash"
      } else {
        Write-Host "[ERROR] Homebrew not found. Install from https://brew.sh"
        exit 1
      }
    }

    'linux' {
      Write-Host "[INFO] Installing/upgrading Bash on Linux..."
      if (Test-Path '/etc/os-release') {
        $osInfo = Get-Content /etc/os-release | ConvertFrom-StringData
        $distro = $osInfo.ID

        switch ($distro) {
          { $_ -in 'debian', 'ubuntu' } {
            & sudo apt update
            & sudo apt install -y bash
          }
          { $_ -in 'fedora', 'rhel', 'centos' } {
            & sudo dnf install -y bash
          }
          'arch' {
            & sudo pacman -S --noconfirm bash
          }
          default {
            Write-Host "[WARN] Unknown distro: $distro"
            exit 1
          }
        }
        Write-Host "[OK] Bash installed successfully"
      }
    }

    default {
      Write-Host "[ERROR] Unsupported platform: $platform"
      exit 1
    }
  }

  # Verify installation
  if (Get-Command bash -ErrorAction SilentlyContinue) {
    & bash --version | Select-Object -First 1
    Write-Host "[OK] Installation verified"
    Write-Host ""
    Write-Host "[HINT] Create ~/.bashrc with your settings"
    Write-Host "[HINT] See 'references/install-and-setup.md' for complete setup steps"
  } else {
    Write-Host "[ERROR] Installation verification failed"
    exit 1
  }
}

Main
