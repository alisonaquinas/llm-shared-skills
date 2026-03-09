#!/usr/bin/env bash
set -euo pipefail

# 7z installer for macOS, Linux

detect_platform() {
  local system=$(uname -s)
  if [[ "$system" == "Darwin" ]]; then
    echo "macos"
  elif [[ "$system" == "Linux" ]]; then
    if [[ -f /etc/os-release ]]; then
      source /etc/os-release
      echo "${ID:-linux}"
    else
      echo "linux"
    fi
  else
    echo "unknown"
  fi
}

main() {
  local platform=$(detect_platform)

  # Check if 7z is available
  if command -v 7z &>/dev/null; then
    local version=$(7z --help 2>&1 | head -1)
    echo "[OK] $version"
    echo "[HINT] 7z is already available"
    return 0
  fi

  case "$platform" in
    macos)
      echo "[INFO] Installing p7zip on macOS via Homebrew..."
      if command -v brew &>/dev/null; then
        brew install p7zip
        echo "[OK] p7zip installed via Homebrew"
        7z --help | head -1
      else
        echo "[ERROR] Homebrew not found. Install from https://brew.sh"
        exit 1
      fi
      ;;

    debian|ubuntu)
      echo "[INFO] Installing p7zip on Debian/Ubuntu..."
      apt-get update
      apt-get install -y p7zip-full p7zip-rar
      echo "[OK] p7zip installed"
      7z --help | head -1
      ;;

    fedora|rhel|centos)
      echo "[INFO] Installing p7zip on Fedora/RHEL..."
      dnf install -y p7zip p7zip-plugins
      echo "[OK] p7zip installed"
      7z --help | head -1
      ;;

    arch)
      echo "[INFO] Installing p7zip on Arch Linux..."
      pacman -S --noconfirm p7zip
      echo "[OK] p7zip installed"
      7z --help | head -1
      ;;

    alpine)
      echo "[INFO] Installing p7zip on Alpine..."
      apk add --no-cache p7zip
      echo "[OK] p7zip installed"
      7z --help | head -1
      ;;

    *)
      echo "[ERROR] Unsupported platform: $platform"
      echo "[HINT] See references/install-and-setup.md for manual installation steps"
      exit 1
      ;;
  esac

  echo "[HINT] See references/install-and-setup.md for post-install configuration"
}

main "$@"
