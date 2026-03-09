#!/usr/bin/env bash
set -euo pipefail

# unzip installer

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

  if command -v unzip &>/dev/null; then
    echo "[OK] unzip is already available"
    unzip -h | head -3
    return 0
  fi

  case "$platform" in
    macos)
      echo "[INFO] Installing unzip on macOS..."
      if command -v brew &>/dev/null; then
        brew install unzip
        echo "[OK] unzip installed"
      else
        echo "[HINT] Install Homebrew or use built-in unzip"
      fi
      ;;

    debian|ubuntu)
      echo "[INFO] Installing unzip on Debian/Ubuntu..."
      apt-get update && apt-get install -y unzip
      echo "[OK] unzip installed"
      ;;

    fedora|rhel|centos)
      echo "[INFO] Installing unzip on Fedora/RHEL..."
      dnf install -y unzip && echo "[OK] unzip installed"
      ;;

    arch)
      echo "[INFO] Installing unzip on Arch..."
      pacman -S --noconfirm unzip && echo "[OK] unzip installed"
      ;;

    alpine)
      echo "[INFO] Installing unzip on Alpine..."
      apk add --no-cache unzip && echo "[OK] unzip installed"
      ;;

    *)
      echo "[ERROR] Unsupported platform: $platform"
      exit 1
      ;;
  esac

  echo "[HINT] See references/install-and-setup.md for details"
}

main "$@"
