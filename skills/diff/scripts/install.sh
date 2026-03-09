#!/usr/bin/env bash
set -euo pipefail

# diff installer for macOS, Linux

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

  # Check if diff is available
  if command -v diff &>/dev/null; then
    local version=$(diff --version 2>&1 | head -1 || echo "unknown version")
    echo "[OK] $version"
    echo "[HINT] diff is already available"
    echo "[HINT] See references/install-and-setup.md for details on variants (GNU, BSD)"
    return 0
  fi

  case "$platform" in
    macos)
      echo "[INFO] diff is included in macOS by default (BSD diff)"
      echo "[OK] BSD diff is available: $(diff --help 2>&1 | head -1)"
      echo "[HINT] To install GNU diffutils, use: brew install diffutils"
      echo "[HINT] GNU diff will be available as 'gdiff'"
      ;;

    debian|ubuntu)
      echo "[INFO] Installing GNU diffutils (diff) on Debian/Ubuntu..."
      apt-get update
      apt-get install -y diffutils
      echo "[OK] diff installed"
      diff --version | head -1
      ;;

    fedora|rhel|centos)
      echo "[INFO] Installing GNU diffutils (diff) on Fedora/RHEL..."
      dnf install -y diffutils
      echo "[OK] diff installed"
      diff --version | head -1
      ;;

    arch)
      echo "[INFO] Installing diffutils (diff) on Arch Linux..."
      pacman -S --noconfirm diffutils
      echo "[OK] diff installed"
      diff --version | head -1
      ;;

    alpine)
      echo "[INFO] Installing diffutils (diff) on Alpine..."
      apk add --no-cache diffutils
      echo "[OK] diff installed"
      diff --version | head -1
      ;;

    *)
      echo "[ERROR] Unsupported platform: $platform"
      echo "[HINT] See references/install-and-setup.md for manual installation steps"
      exit 1
      ;;
  esac

  echo "[HINT] See references/install-and-setup.md for post-install configuration"
}

main "$@"
