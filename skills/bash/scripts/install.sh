#!/usr/bin/env bash
set -euo pipefail

# Bash installer for macOS, Linux

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

  # Check if bash is available
  if command -v bash &>/dev/null; then
    local version=$(bash --version | head -1)
    echo "[OK] $version"
    echo "[HINT] Bash is already available"
    echo "[HINT] See references/install-and-setup.md for post-install configuration"
    return 0
  fi

  case "$platform" in
    macos)
      echo "[INFO] Installing Bash on macOS via Homebrew (upgrading from 3.2)..."
      if command -v brew &>/dev/null; then
        brew install bash
        echo "[OK] Bash installed via Homebrew"
        echo "[WARN] To use as default shell:"
        echo "[HINT]   sudo bash -c 'echo /opt/homebrew/bin/bash >> /etc/shells'"
        echo "[HINT]   chsh -s /opt/homebrew/bin/bash"
      else
        echo "[ERROR] Homebrew not found. Install from https://brew.sh"
        exit 1
      fi
      ;;

    debian|ubuntu)
      echo "[INFO] Installing/upgrading Bash on Debian/Ubuntu..."
      sudo apt update
      sudo apt install -y bash
      echo "[OK] Bash installed successfully"
      ;;

    fedora|rhel|centos)
      echo "[INFO] Installing Bash on Fedora/RHEL..."
      sudo dnf install -y bash
      echo "[OK] Bash installed successfully"
      ;;

    arch)
      echo "[INFO] Installing Bash on Arch Linux..."
      sudo pacman -S --noconfirm bash
      echo "[OK] Bash installed successfully"
      ;;

    alpine)
      echo "[INFO] Installing Bash on Alpine..."
      sudo apk add bash
      echo "[OK] Bash installed successfully"
      ;;

    *)
      echo "[ERROR] Unsupported platform: $platform"
      exit 1
      ;;
  esac

  # Verify installation
  if command -v bash &>/dev/null; then
    bash --version | head -1
    echo "[OK] Installation verified"
    echo ""
    echo "[HINT] Create ~/.bashrc with your settings"
    echo "[HINT] See references/install-and-setup.md for complete setup steps"
  else
    echo "[ERROR] Installation verification failed"
    exit 1
  fi
}

main "$@"
