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

  if command -v cmp &>/dev/null; then
    local version=$(cmp --version 2>&1 | head -1)
    echo "[OK] $version"
    return 0
  fi

  case "$platform" in
    macos)
      echo "[INFO] Installing cmp on macOS..."
      if command -v brew &>/dev/null; then
        brew install cmp 2>/dev/null || echo "[HINT] cmp may be built-in"
        echo "[OK] cmp available"
      fi
      ;;

    debian|ubuntu)
      echo "[INFO] Installing cmp on Debian/Ubuntu..."
      apt-get update && apt-get install -y cmp
      echo "[OK] cmp installed"
      ;;

    fedora|rhel|centos)
      echo "[INFO] Installing cmp on Fedora/RHEL..."
      dnf install -y cmp
      echo "[OK] cmp installed"
      ;;

    arch)
      echo "[INFO] Installing cmp on Arch..."
      pacman -S --noconfirm cmp
      echo "[OK] cmp installed"
      ;;

    alpine)
      echo "[INFO] Installing cmp on Alpine..."
      apk add --no-cache cmp
      echo "[OK] cmp installed"
      ;;

    *)
      echo "[ERROR] Unsupported platform: $platform"
      exit 1
      ;;
  esac

  echo "[HINT] See references/install-and-setup.md for details"
}

main "$@"
