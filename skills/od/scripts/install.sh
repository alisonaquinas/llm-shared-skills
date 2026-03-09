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

  if command -v od &>/dev/null; then
    local version=$(od --version 2>&1 | head -1)
    echo "[OK] $version"
    return 0
  fi

  case "$platform" in
    macos)
      echo "[INFO] Installing od on macOS..."
      if command -v brew &>/dev/null; then
        brew install od 2>/dev/null || echo "[HINT] od may be built-in"
        echo "[OK] od available"
      fi
      ;;

    debian|ubuntu)
      echo "[INFO] Installing od on Debian/Ubuntu..."
      apt-get update && apt-get install -y od
      echo "[OK] od installed"
      ;;

    fedora|rhel|centos)
      echo "[INFO] Installing od on Fedora/RHEL..."
      dnf install -y od
      echo "[OK] od installed"
      ;;

    arch)
      echo "[INFO] Installing od on Arch..."
      pacman -S --noconfirm od
      echo "[OK] od installed"
      ;;

    alpine)
      echo "[INFO] Installing od on Alpine..."
      apk add --no-cache od
      echo "[OK] od installed"
      ;;

    *)
      echo "[ERROR] Unsupported platform: $platform"
      exit 1
      ;;
  esac

  echo "[HINT] See references/install-and-setup.md for details"
}

main "$@"
