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

  if command -v xxd &>/dev/null; then
    local version=$(xxd --version 2>&1 | head -1)
    echo "[OK] $version"
    return 0
  fi

  case "$platform" in
    macos)
      echo "[INFO] Installing xxd on macOS..."
      if command -v brew &>/dev/null; then
        brew install xxd 2>/dev/null || echo "[HINT] xxd may be built-in"
        echo "[OK] xxd available"
      fi
      ;;

    debian|ubuntu)
      echo "[INFO] Installing xxd on Debian/Ubuntu..."
      apt-get update && apt-get install -y xxd
      echo "[OK] xxd installed"
      ;;

    fedora|rhel|centos)
      echo "[INFO] Installing xxd on Fedora/RHEL..."
      dnf install -y xxd
      echo "[OK] xxd installed"
      ;;

    arch)
      echo "[INFO] Installing xxd on Arch..."
      pacman -S --noconfirm xxd
      echo "[OK] xxd installed"
      ;;

    alpine)
      echo "[INFO] Installing xxd on Alpine..."
      apk add --no-cache xxd
      echo "[OK] xxd installed"
      ;;

    *)
      echo "[ERROR] Unsupported platform: $platform"
      exit 1
      ;;
  esac

  echo "[HINT] See references/install-and-setup.md for details"
}

main "$@"
