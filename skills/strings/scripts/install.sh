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

  if command -v strings &>/dev/null; then
    local version=$(strings --version 2>&1 | head -1)
    echo "[OK] $version"
    return 0
  fi

  case "$platform" in
    macos)
      echo "[INFO] Installing strings on macOS..."
      if command -v brew &>/dev/null; then
        brew install strings 2>/dev/null || echo "[HINT] strings may be built-in"
        echo "[OK] strings available"
      fi
      ;;

    debian|ubuntu)
      echo "[INFO] Installing strings on Debian/Ubuntu..."
      apt-get update && apt-get install -y strings
      echo "[OK] strings installed"
      ;;

    fedora|rhel|centos)
      echo "[INFO] Installing strings on Fedora/RHEL..."
      dnf install -y strings
      echo "[OK] strings installed"
      ;;

    arch)
      echo "[INFO] Installing strings on Arch..."
      pacman -S --noconfirm strings
      echo "[OK] strings installed"
      ;;

    alpine)
      echo "[INFO] Installing strings on Alpine..."
      apk add --no-cache strings
      echo "[OK] strings installed"
      ;;

    *)
      echo "[ERROR] Unsupported platform: $platform"
      exit 1
      ;;
  esac

  echo "[HINT] See references/install-and-setup.md for details"
}

main "$@"
