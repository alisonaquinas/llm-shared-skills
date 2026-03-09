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

  if command -v file &>/dev/null; then
    local version=$(file --version 2>&1 | head -1)
    echo "[OK] $version"
    return 0
  fi

  case "$platform" in
    macos)
      echo "[INFO] Installing file on macOS..."
      if command -v brew &>/dev/null; then
        brew install file 2>/dev/null || echo "[HINT] file may be built-in"
        echo "[OK] file available"
      fi
      ;;

    debian|ubuntu)
      echo "[INFO] Installing file on Debian/Ubuntu..."
      apt-get update && apt-get install -y file
      echo "[OK] file installed"
      ;;

    fedora|rhel|centos)
      echo "[INFO] Installing file on Fedora/RHEL..."
      dnf install -y file
      echo "[OK] file installed"
      ;;

    arch)
      echo "[INFO] Installing file on Arch..."
      pacman -S --noconfirm file
      echo "[OK] file installed"
      ;;

    alpine)
      echo "[INFO] Installing file on Alpine..."
      apk add --no-cache file
      echo "[OK] file installed"
      ;;

    *)
      echo "[ERROR] Unsupported platform: $platform"
      exit 1
      ;;
  esac

  echo "[HINT] See references/install-and-setup.md for details"
}

main "$@"
