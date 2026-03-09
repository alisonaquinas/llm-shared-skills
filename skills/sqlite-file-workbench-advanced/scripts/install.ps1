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

  # Check if sqlite3 is already installed
  if (-not (Get-Command sqlite3 -ErrorAction SilentlyContinue)) {
    Write-Host "[INFO] sqlite3 not found. Installing base tools first..."

    switch ($platform) {
      'windows' {
        $tmpdir = New-TemporaryFile | ForEach-Object { Remove-Item $_; New-Item -ItemType Directory -Path $_ }
        try {
          Push-Location $tmpdir
          Invoke-WebRequest -Uri "https://www.sqlite.org/2024/sqlite-tools-win32-x86-3450000.zip" -OutFile "sqlite-tools.zip"
          Expand-Archive sqlite-tools.zip
          $sqlitedir = "C:\sqlite"
          if (-not (Test-Path $sqlitedir)) {
            New-Item -ItemType Directory -Path $sqlitedir
          }
          Copy-Item sqlite-tools\* -Destination $sqlitedir -Force
          [Environment]::SetEnvironmentVariable("PATH", "$env:PATH;$sqlitedir", "User")
          Write-Host "[OK] SQLite tools installed"
        } finally {
          Pop-Location
          Remove-Item $tmpdir -Recurse -Force
        }
      }

      'macos' {
        if (Get-Command brew -ErrorAction SilentlyContinue) {
          & brew install sqlite
          Write-Host "[OK] SQLite3 installed"
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
              & sudo apt install -y sqlite3
            }
            { $_ -in 'fedora', 'rhel', 'centos' } {
              & sudo dnf install -y sqlite
            }
            'arch' {
              & sudo pacman -S --noconfirm sqlite
            }
            default {
              Write-Host "[WARN] Unknown distro: $distro"
            }
          }
          Write-Host "[OK] SQLite3 installed"
        }
      }

      default {
        Write-Host "[ERROR] Unsupported platform: $platform"
        exit 1
      }
    }
  }

  # Check for sqldiff
  if (Get-Command sqldiff -ErrorAction SilentlyContinue) {
    Write-Host "[OK] sqldiff already installed"
  } else {
    Write-Host "[WARN] sqldiff not found (not in most package managers)"
    Write-Host "[HINT] Download prebuilt or build from source:"
    Write-Host "[HINT]   https://www.sqlite.org/download.html"
  }

  # Check for sqlite3_rsync
  if (Get-Command sqlite3_rsync -ErrorAction SilentlyContinue) {
    Write-Host "[OK] sqlite3_rsync already installed"
  } else {
    Write-Host "[WARN] sqlite3_rsync not found (not in most package managers)"
    Write-Host "[HINT] Download prebuilt binary or build from source:"
    Write-Host "[HINT]   https://www.sqlite.org/download.html"
  }

  # Verify sqlite3
  Write-Host ""
  Write-Host "[INFO] Verification:"
  & sqlite3 --version
  (Get-Command sqldiff -ErrorAction SilentlyContinue) ? (& sqldiff --version) : "sqldiff not available"
  (Get-Command sqlite3_rsync -ErrorAction SilentlyContinue) ? (& sqlite3_rsync --help 2>&1 | Select-Object -First 1) : "sqlite3_rsync not available"

  Write-Host ""
  Write-Host "[OK] Base SQLite3 installation verified"
  Write-Host "[HINT] See 'references/install-and-setup.md' for sqldiff/sqlite3_rsync installation"
}

Main
