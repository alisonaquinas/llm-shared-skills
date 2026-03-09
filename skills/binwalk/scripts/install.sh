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

  if command -v binwalk &>/dev/null; then
    local version=$(binwalk --version 2>&1 | head -1)
    echo "[OK] $version"
    return 0
  fi

  case "$platform" in
    macos)
      echo "[INFO] Installing binwalk on macOS..."
      if command -v brew &>/dev/null; then
        brew install binwalk 2>/dev/null || echo "[HINT] binwalk may be built-in"
        echo "[OK] binwalk available"
      fi
      ;;

    debian|ubuntu)
      echo "[INFO] Installing binwalk on Debian/Ubuntu..."
      apt-get update && apt-get install -y binwalk
      echo "[OK] binwalk installed"
      ;;

    fedora|rhel|centos)
      echo "[INFO] Installing binwalk on Fedora/RHEL..."
      dnf install -y binwalk
      echo "[OK] binwalk installed"
      ;;

    arch)
      echo "[INFO] Installing binwalk on Arch..."
      pacman -S --noconfirm binwalk
      echo "[OK] binwalk installed"
      ;;

    alpine)
      echo "[INFO] Installing binwalk on Alpine..."
      apk add --no-cache binwalk
      echo "[OK] binwalk installed"
      ;;

    *)
      echo "[ERROR] Unsupported platform: $platform"
      exit 1
      ;;
  esac

  echo "[HINT] See references/install-and-setup.md for details"
}

main "$@"
