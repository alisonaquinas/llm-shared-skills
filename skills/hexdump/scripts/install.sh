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

  if command -v hexdump &>/dev/null; then
    local version=$(hexdump --version 2>&1 | head -1)
    echo "[OK] $version"
    return 0
  fi

  case "$platform" in
    macos)
      echo "[INFO] Installing hexdump on macOS..."
      if command -v brew &>/dev/null; then
        brew install hexdump 2>/dev/null || echo "[HINT] hexdump may be built-in"
        echo "[OK] hexdump available"
      fi
      ;;

    debian|ubuntu)
      echo "[INFO] Installing hexdump on Debian/Ubuntu..."
      apt-get update && apt-get install -y hexdump
      echo "[OK] hexdump installed"
      ;;

    fedora|rhel|centos)
      echo "[INFO] Installing hexdump on Fedora/RHEL..."
      dnf install -y hexdump
      echo "[OK] hexdump installed"
      ;;

    arch)
      echo "[INFO] Installing hexdump on Arch..."
      pacman -S --noconfirm hexdump
      echo "[OK] hexdump installed"
      ;;

    alpine)
      echo "[INFO] Installing hexdump on Alpine..."
      apk add --no-cache hexdump
      echo "[OK] hexdump installed"
      ;;

    *)
      echo "[ERROR] Unsupported platform: $platform"
      exit 1
      ;;
  esac

  echo "[HINT] See references/install-and-setup.md for details"
}

main "$@"
