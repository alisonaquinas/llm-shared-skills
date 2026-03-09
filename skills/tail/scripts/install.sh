#!/usr/bin/env bash
set -euo pipefail

# tail installer for macOS, Linux

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

  # Check if tail is available
  if command -v tail &>/dev/null; then
    local version=$(tail --version 2>&1 | head -1 || echo "BSD tail (built-in)")
    echo "[OK] $version"
    echo "[HINT] tail is already available"
    echo "[HINT] See references/install-and-setup.md for details on variants (GNU, BSD)"
    return 0
  fi

  case "$platform" in
    macos)
      echo "[INFO] tail is included in macOS by default (BSD tail)"
      echo "[OK] BSD tail is available"
      echo "[HINT] To install GNU coreutils, use: brew install coreutils"
      ;;

    debian|ubuntu)
      echo "[INFO] Installing GNU coreutils (tail) on Debian/Ubuntu..."
      apt-get update
      apt-get install -y coreutils
      echo "[OK] tail installed"
      tail --version | head -1
      ;;

    fedora|rhel|centos)
      echo "[INFO] Installing GNU coreutils (tail) on Fedora/RHEL..."
      dnf install -y coreutils
      echo "[OK] tail installed"
      tail --version | head -1
      ;;

    arch)
      echo "[INFO] Installing coreutils (tail) on Arch Linux..."
      pacman -S --noconfirm coreutils
      echo "[OK] tail installed"
      tail --version | head -1
      ;;

    alpine)
      echo "[INFO] Installing coreutils (tail) on Alpine..."
      apk add --no-cache coreutils
      echo "[OK] tail installed"
      tail --version | head -1
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
