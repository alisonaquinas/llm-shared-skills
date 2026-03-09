#!/usr/bin/env bash
set -euo pipefail

# head installer for macOS, Linux

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

  # Check if head is available
  if command -v head &>/dev/null; then
    local version=$(head --version 2>&1 | head -1 || echo "BSD head (built-in)")
    echo "[OK] $version"
    echo "[HINT] head is already available"
    echo "[HINT] See references/install-and-setup.md for details on variants (GNU, BSD)"
    return 0
  fi

  case "$platform" in
    macos)
      echo "[INFO] head is included in macOS by default (BSD head)"
      echo "[OK] BSD head is available"
      echo "[HINT] To install GNU coreutils (with ghead), use: brew install coreutils"
      echo "[HINT] Head will then be available as 'ghead'"
      ;;

    debian|ubuntu)
      echo "[INFO] Installing GNU coreutils (head) on Debian/Ubuntu..."
      apt-get update
      apt-get install -y coreutils
      echo "[OK] head installed"
      head --version | head -1
      ;;

    fedora|rhel|centos)
      echo "[INFO] Installing GNU coreutils (head) on Fedora/RHEL..."
      dnf install -y coreutils
      echo "[OK] head installed"
      head --version | head -1
      ;;

    arch)
      echo "[INFO] Installing coreutils (head) on Arch Linux..."
      pacman -S --noconfirm coreutils
      echo "[OK] head installed"
      head --version | head -1
      ;;

    alpine)
      echo "[INFO] Installing coreutils (head) on Alpine..."
      apk add --no-cache coreutils
      echo "[OK] head installed"
      head --version | head -1
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
