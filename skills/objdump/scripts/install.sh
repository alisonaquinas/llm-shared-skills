#!/usr/bin/env bash
set -euo pipefail

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

  if command -v objdump &>/dev/null; then
    local version=$(objdump --version 2>&1 | head -1)
    echo "[OK] $version"
    return 0
  fi

  case "$platform" in
    macos)
      echo "[INFO] Installing objdump on macOS..."
      if command -v brew &>/dev/null; then
        brew install objdump 2>/dev/null || echo "[HINT] objdump may be built-in"
        echo "[OK] objdump available"
      fi
      ;;

    debian|ubuntu)
      echo "[INFO] Installing objdump on Debian/Ubuntu..."
      apt-get update && apt-get install -y objdump
      echo "[OK] objdump installed"
      ;;

    fedora|rhel|centos)
      echo "[INFO] Installing objdump on Fedora/RHEL..."
      dnf install -y objdump
      echo "[OK] objdump installed"
      ;;

    arch)
      echo "[INFO] Installing objdump on Arch..."
      pacman -S --noconfirm objdump
      echo "[OK] objdump installed"
      ;;

    alpine)
      echo "[INFO] Installing objdump on Alpine..."
      apk add --no-cache objdump
      echo "[OK] objdump installed"
      ;;

    *)
      echo "[ERROR] Unsupported platform: $platform"
      exit 1
      ;;
  esac

  echo "[HINT] See references/install-and-setup.md for details"
}

main "$@"
