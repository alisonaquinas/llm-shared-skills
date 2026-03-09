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

  if command -v readelf &>/dev/null; then
    local version=$(readelf --version 2>&1 | head -1)
    echo "[OK] $version"
    return 0
  fi

  case "$platform" in
    macos)
      echo "[INFO] Installing readelf on macOS..."
      if command -v brew &>/dev/null; then
        brew install readelf 2>/dev/null || echo "[HINT] readelf may be built-in"
        echo "[OK] readelf available"
      fi
      ;;

    debian|ubuntu)
      echo "[INFO] Installing readelf on Debian/Ubuntu..."
      apt-get update && apt-get install -y readelf
      echo "[OK] readelf installed"
      ;;

    fedora|rhel|centos)
      echo "[INFO] Installing readelf on Fedora/RHEL..."
      dnf install -y readelf
      echo "[OK] readelf installed"
      ;;

    arch)
      echo "[INFO] Installing readelf on Arch..."
      pacman -S --noconfirm readelf
      echo "[OK] readelf installed"
      ;;

    alpine)
      echo "[INFO] Installing readelf on Alpine..."
      apk add --no-cache readelf
      echo "[OK] readelf installed"
      ;;

    *)
      echo "[ERROR] Unsupported platform: $platform"
      exit 1
      ;;
  esac

  echo "[HINT] See references/install-and-setup.md for details"
}

main "$@"
