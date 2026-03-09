#!/usr/bin/env bash
set -euo pipefail

# ar installer for macOS, Linux

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

  # Check if ar is available
  if command -v ar &>/dev/null; then
    local version=$(ar --version 2>&1 | head -1)
    echo "[OK] $version"
    echo "[HINT] ar is already available"
    return 0
  fi

  case "$platform" in
    macos)
      echo "[INFO] ar is included in macOS by default (part of Xcode tools)"
      echo "[OK] ar is available"
      echo "[HINT] Install Xcode command-line tools if ar is missing:"
      echo "[HINT] xcode-select --install"
      ;;

    debian|ubuntu)
      echo "[INFO] Installing binutils (ar) on Debian/Ubuntu..."
      apt-get update
      apt-get install -y binutils
      echo "[OK] ar installed"
      ar --version | head -1
      ;;

    fedora|rhel|centos)
      echo "[INFO] Installing binutils (ar) on Fedora/RHEL..."
      dnf install -y binutils
      echo "[OK] ar installed"
      ar --version | head -1
      ;;

    arch)
      echo "[INFO] Installing binutils (ar) on Arch Linux..."
      pacman -S --noconfirm binutils
      echo "[OK] ar installed"
      ar --version | head -1
      ;;

    alpine)
      echo "[INFO] Installing binutils (ar) on Alpine..."
      apk add --no-cache binutils
      echo "[OK] ar installed"
      ar --version | head -1
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
