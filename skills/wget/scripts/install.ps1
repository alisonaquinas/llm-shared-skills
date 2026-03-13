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
  if (Get-Command wget -ErrorAction SilentlyContinue) {
    $version = & wget --version 2>&1 | Select-Object -First 1
    Write-Host "[OK] $version already installed"
    Write-Host "[HINT] See 'references/install-and-setup.md' for crawl and TLS setup"
    return
  }

  $platform = Get-Platform

  switch ($platform) {
    'windows' {
      if (Get-Command winget -ErrorAction SilentlyContinue) {
        & winget install --id GnuWin32.Wget --exact --accept-source-agreements --accept-package-agreements
      } else {
        Write-Host "[ERROR] winget not found. Install wget from your package manager or MSYS2 distribution."
        exit 1
      }
    }
    'macos' {
      if (Get-Command brew -ErrorAction SilentlyContinue) {
        & brew install wget
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
            & sudo apt-get update
            & sudo apt-get install -y wget ca-certificates
          }
          { $_ -in 'fedora', 'rhel', 'centos' } {
            & sudo dnf install -y wget ca-certificates
          }
          'arch' {
            & sudo pacman -S --noconfirm wget ca-certificates
          }
          'alpine' {
            & sudo apk add --no-cache wget ca-certificates
          }
          default {
            Write-Host "[ERROR] Unsupported Linux distribution: $distro"
            exit 1
          }
        }
      } else {
        Write-Host "[ERROR] Cannot detect Linux distribution"
        exit 1
      }
    }
    default {
      Write-Host "[ERROR] Unsupported platform: $platform"
      exit 1
    }
  }

  if (Get-Command wget -ErrorAction SilentlyContinue) {
    & wget --version 2>&1 | Select-Object -First 1
    Write-Host "[OK] Installation verified"
  } else {
    Write-Host "[ERROR] Installation verification failed"
    exit 1
  }
}

Main
