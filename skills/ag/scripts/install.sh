#!/usr/bin/env bash
set -euo pipefail

# The Silver Searcher (ag) installer for macOS, Linux

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

  # Check if ag is already installed
  if command -v ag &>/dev/null; then
    local version=$(ag --version 2>&1 | head -1)
    echo "[OK] $version already installed"
    echo "[HINT] Run 'references/install-and-setup.md' for post-install configuration"
    return 0
  fi

  case "$platform" in
    macos)
      echo "[INFO] Installing The Silver Searcher on macOS via Homebrew..."
      if command -v brew &>/dev/null; then
        brew install the_silver_searcher
        echo "[OK] ag installed successfully"
      else
        echo "[ERROR] Homebrew not found. Install from https://brew.sh"
        exit 1
      fi
      ;;

    debian|ubuntu)
      echo "[INFO] Installing The Silver Searcher on Debian/Ubuntu..."
      sudo apt update
      sudo apt install -y silversearcher-ag
      echo "[OK] ag installed successfully"
      ;;

    fedora|rhel|centos)
      echo "[INFO] Installing The Silver Searcher on Fedora/RHEL..."
      sudo dnf install -y the_silver_searcher
      echo "[OK] ag installed successfully"
      ;;

    arch)
      echo "[INFO] Installing The Silver Searcher on Arch Linux..."
      sudo pacman -S --noconfirm the_silver_searcher
      echo "[OK] ag installed successfully"
      ;;

    alpine)
      echo "[INFO] Installing The Silver Searcher on Alpine..."
      sudo apk add the_silver_searcher
      echo "[OK] ag installed successfully"
      ;;

    *)
      echo "[ERROR] Unsupported platform: $platform"
      echo "[HINT] Install manually from https://github.com/ggreer/the_silver_searcher"
      exit 1
      ;;
  esac

  # Verify installation
  if command -v ag &>/dev/null; then
    ag --version
    echo "[OK] Installation verified"
    echo ""
    echo "[HINT] Create ~/.agignore to ignore patterns globally"
    echo "[HINT] See references/install-and-setup.md for complete setup steps"
  else
    echo "[ERROR] Installation verification failed"
    exit 1
  fi
}

main "$@"
