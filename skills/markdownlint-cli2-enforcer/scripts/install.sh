#!/usr/bin/env bash
set -euo pipefail

# markdownlint-cli2 installer for macOS, Linux (requires Node.js)

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

  # Check if markdownlint-cli2 is already installed
  if command -v markdownlint-cli2 &>/dev/null; then
    local version=$(markdownlint-cli2 --version)
    echo "[OK] markdownlint-cli2 $version already installed"
    echo "[HINT] Run 'references/install-and-setup.md' for post-install configuration"
    return 0
  fi

  # Check if Node.js is installed (required dependency)
  if ! command -v npm &>/dev/null; then
    echo "[INFO] Node.js/npm not found. Installing first..."
    case "$platform" in
      macos)
        if command -v brew &>/dev/null; then
          brew install node
        else
          echo "[ERROR] Homebrew not found. Install from https://brew.sh"
          exit 1
        fi
        ;;

      debian|ubuntu)
        sudo apt update
        sudo apt install -y nodejs npm
        ;;

      fedora|rhel|centos)
        sudo dnf install -y nodejs
        ;;

      arch)
        sudo pacman -S --noconfirm nodejs npm
        ;;

      alpine)
        sudo apk add nodejs npm
        ;;

      *)
        echo "[ERROR] Unsupported platform: $platform"
        exit 1
        ;;
    esac
  fi

  # Verify Node.js installation
  if ! command -v npm &>/dev/null; then
    echo "[ERROR] npm installation failed"
    exit 1
  fi

  npm --version
  echo "[OK] npm available"

  # Install markdownlint-cli2
  echo "[INFO] Installing markdownlint-cli2 globally..."
  npm install -g markdownlint-cli2
  echo "[OK] markdownlint-cli2 installed successfully"

  # Verify installation
  if command -v markdownlint-cli2 &>/dev/null; then
    markdownlint-cli2 --version
    echo "[OK] Installation verified"
    echo ""
    echo "[HINT] Create .markdownlint-cli2.jsonc in project root for custom rules"
    echo "[HINT] See references/install-and-setup.md for complete setup steps"
  else
    echo "[ERROR] Installation verification failed"
    exit 1
  fi
}

main "$@"
