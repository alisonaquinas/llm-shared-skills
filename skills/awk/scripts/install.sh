#!/usr/bin/env bash
set -euo pipefail

# awk installer for macOS, Linux

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

  # Check if awk is available
  if command -v awk &>/dev/null; then
    local version=$(awk --version 2>&1 | head -1)
    echo "[OK] $version"
    echo "[HINT] awk is already available"
    echo "[HINT] See references/install-and-setup.md for details on variants (GNU, mawk, nawk)"
    return 0
  fi

  case "$platform" in
    macos)
      echo "[INFO] Installing GNU awk (gawk) on macOS via Homebrew..."
      if command -v brew &>/dev/null; then
        brew install gawk
        echo "[OK] gawk installed via Homebrew"
        echo "[HINT] Run: gawk --version"
      else
        echo "[ERROR] Homebrew not found. Install from https://brew.sh"
        exit 1
      fi
      ;;

    debian|ubuntu)
      echo "[INFO] Installing GNU awk (gawk) on Debian/Ubuntu..."
      apt-get update
      apt-get install -y gawk
      echo "[OK] gawk installed"
      awk --version | head -1
      ;;

    fedora|rhel|centos)
      echo "[INFO] Installing GNU awk (gawk) on Fedora/RHEL..."
      dnf install -y gawk
      echo "[OK] gawk installed"
      awk --version | head -1
      ;;

    arch)
      echo "[INFO] Installing GNU awk (gawk) on Arch Linux..."
      pacman -S --noconfirm gawk
      echo "[OK] gawk installed"
      awk --version | head -1
      ;;

    alpine)
      echo "[INFO] Installing GNU awk (gawk) on Alpine..."
      apk add --no-cache gawk
      echo "[OK] gawk installed"
      awk --version | head -1
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
