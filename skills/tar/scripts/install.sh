#!/usr/bin/env bash
set -euo pipefail

# tar installer for macOS, Linux

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

  # Check if tar is available
  if command -v tar &>/dev/null; then
    local version=$(tar --version 2>&1 | head -1)
    echo "[OK] $version"
    echo "[HINT] tar is already available"
    return 0
  fi

  case "$platform" in
    macos)
      echo "[INFO] tar is included in macOS by default"
      echo "[OK] tar is available"
      ;;

    debian|ubuntu)
      echo "[INFO] Installing tar on Debian/Ubuntu..."
      apt-get update
      apt-get install -y tar
      echo "[OK] tar installed"
      tar --version | head -1
      ;;

    fedora|rhel|centos)
      echo "[INFO] Installing tar on Fedora/RHEL..."
      dnf install -y tar
      echo "[OK] tar installed"
      tar --version | head -1
      ;;

    arch)
      echo "[INFO] Installing tar on Arch Linux..."
      pacman -S --noconfirm tar
      echo "[OK] tar installed"
      tar --version | head -1
      ;;

    alpine)
      echo "[INFO] Installing tar on Alpine..."
      apk add --no-cache tar
      echo "[OK] tar installed"
      tar --version | head -1
      ;;

    *)
      echo "[ERROR] Unsupported platform: $platform"
      exit 1
      ;;
  esac

  echo "[HINT] See references/install-and-setup.md for post-install configuration"
}

main "$@"
