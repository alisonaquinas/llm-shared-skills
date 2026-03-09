#!/usr/bin/env bash
set -euo pipefail

# Zoxide + fzf installer for macOS, Linux

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

  # Check if zoxide is already installed
  if command -v zoxide &>/dev/null; then
    local version=$(zoxide --version)
    echo "[OK] zoxide: $version already installed"
  else
    echo "[INFO] Installing zoxide..."

    case "$platform" in
      macos)
        if command -v brew &>/dev/null; then
          brew install zoxide
          echo "[OK] zoxide installed"
        else
          echo "[ERROR] Homebrew not found. Install from https://brew.sh"
          exit 1
        fi
        ;;

      debian|ubuntu)
        sudo apt update
        sudo apt install -y zoxide
        echo "[OK] zoxide installed"
        ;;

      fedora|rhel|centos)
        sudo dnf install -y zoxide
        echo "[OK] zoxide installed"
        ;;

      arch)
        sudo pacman -S --noconfirm zoxide
        echo "[OK] zoxide installed"
        ;;

      alpine)
        sudo apk add zoxide
        echo "[OK] zoxide installed"
        ;;

      *)
        echo "[ERROR] Unsupported platform: $platform"
        exit 1
        ;;
    esac
  fi

  # Check if fzf is already installed (optional but recommended)
  if command -v fzf &>/dev/null; then
    local version=$(fzf --version | awk '{print $1}')
    echo "[OK] fzf: $version already installed"
  else
    echo "[INFO] Installing fzf (optional, enables interactive zi)..."

    case "$platform" in
      macos)
        if command -v brew &>/dev/null; then
          brew install fzf
          echo "[OK] fzf installed"
        else
          echo "[WARN] Homebrew not found; skipping fzf"
        fi
        ;;

      debian|ubuntu)
        sudo apt install -y fzf
        echo "[OK] fzf installed"
        ;;

      fedora|rhel|centos)
        sudo dnf install -y fzf
        echo "[OK] fzf installed"
        ;;

      arch)
        sudo pacman -S --noconfirm fzf
        echo "[OK] fzf installed"
        ;;

      alpine)
        sudo apk add fzf
        echo "[OK] fzf installed"
        ;;

      *)
        echo "[WARN] fzf not installed for this platform"
        ;;
    esac
  fi

  # Verify zoxide (required)
  if command -v zoxide &>/dev/null; then
    zoxide --version
    echo "[OK] Installation verified"
    echo ""
    echo "[HINT] Add to ~/.bashrc or ~/.zshrc:"
    echo "[HINT]   eval \"\$(zoxide init bash)\"  # or zsh, fish, powershell"
    echo "[HINT] Then reload shell: source ~/.bashrc"
    echo "[HINT] See references/install-and-setup.md for complete setup steps"
  else
    echo "[ERROR] Zoxide installation failed"
    exit 1
  fi
}

main "$@"
