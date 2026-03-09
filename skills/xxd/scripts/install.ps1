Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

function Get-Platform {
  if ($IsWindows) { return "windows" }
  elseif ($IsMacOS) { return "macos" }
  elseif ($IsLinux) { return "linux" }
  else { return "unknown" }
}

function Main {
  $platform = Get-Platform

  if (Get-Command xxd -ErrorAction SilentlyContinue) {
    Write-Host "[OK] xxd is available"
    return 0
  }

  switch ($platform) {
    "windows" {
      Write-Host "[HINT] Install via WSL2, Git Bash, or package manager"
      exit 1
    }
    "macos" {
      if (Get-Command brew -ErrorAction SilentlyContinue) {
        & brew install xxd 2>$null
        Write-Host "[OK] xxd installed"
      } else {
        Write-Host "[HINT] Install Homebrew first"
        exit 1
      }
    }
    "linux" {
      & sudo apt-get update
      & sudo apt-get install -y xxd
      Write-Host "[OK] xxd installed"
    }
    default {
      Write-Host "[ERROR] Unsupported platform"
      exit 1
    }
  }

  Write-Host "[HINT] See references/install-and-setup.md for details"
}

Main
