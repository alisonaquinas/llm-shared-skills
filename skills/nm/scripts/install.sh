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

  if command -v nm &>/dev/null; then
    local version=$(nm --version 2>&1 | head -1)
    echo "[OK] $version"
    return 0
  fi

  case "$platform" in
    macos)
      echo "[INFO] Installing nm on macOS..."
      if command -v brew &>/dev/null; then
        brew install nm 2>/dev/null || echo "[HINT] nm may be built-in"
        echo "[OK] nm available"
      fi
      ;;

    debian|ubuntu)
      echo "[INFO] Installing nm on Debian/Ubuntu..."
      apt-get update && apt-get install -y nm
      echo "[OK] nm installed"
      ;;

    fedora|rhel|centos)
      echo "[INFO] Installing nm on Fedora/RHEL..."
      dnf install -y nm
      echo "[OK] nm installed"
      ;;

    arch)
      echo "[INFO] Installing nm on Arch..."
      pacman -S --noconfirm nm
      echo "[OK] nm installed"
      ;;

    alpine)
      echo "[INFO] Installing nm on Alpine..."
      apk add --no-cache nm
      echo "[OK] nm installed"
      ;;

    *)
      echo "[ERROR] Unsupported platform: $platform"
      exit 1
      ;;
  esac

  echo "[HINT] See references/install-and-setup.md for details"
}

main "$@"
