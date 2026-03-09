#!/usr/bin/env bash
set -euo pipefail

# sed installer for macOS, Linux

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

  # Check if sed is available
  if command -v sed &>/dev/null; then
    local version=$(sed --version 2>&1 | head -1 || echo "BSD sed (built-in)")
    echo "[OK] $version"
    echo "[HINT] sed is already available"
    echo "[HINT] See references/install-and-setup.md for details on variants (GNU, BSD)"
    return 0
  fi

  case "$platform" in
    macos)
      echo "[INFO] sed is included in macOS by default (BSD sed)"
      echo "[OK] BSD sed is available"
      echo "[HINT] To install GNU sed (gsed), use: brew install gnu-sed"
      echo "[HINT] sed will then be available as 'gsed'"
      ;;

    debian|ubuntu)
      echo "[INFO] Installing GNU sed on Debian/Ubuntu..."
      apt-get update
      apt-get install -y sed
      echo "[OK] sed installed"
      sed --version | head -1
      ;;

    fedora|rhel|centos)
      echo "[INFO] Installing GNU sed on Fedora/RHEL..."
      dnf install -y sed
      echo "[OK] sed installed"
      sed --version | head -1
      ;;

    arch)
      echo "[INFO] Installing sed on Arch Linux..."
      pacman -S --noconfirm sed
      echo "[OK] sed installed"
      sed --version | head -1
      ;;

    alpine)
      echo "[INFO] Installing sed on Alpine..."
      apk add --no-cache sed
      echo "[OK] sed installed"
      sed --version | head -1
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
