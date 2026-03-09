#!/usr/bin/env bash
set -euo pipefail

detect_platform() {
  local system=$(uname -s)
  [[ "$system" == "Darwin" ]] && echo "macos" && return
  [[ "$system" == "Linux" ]] && [[ -f /etc/os-release ]] && source /etc/os-release && echo "${ID:-linux}" && return
  echo "unknown"
}

main() {
  command -v xmllint >/dev/null && echo "[OK] xmllint is available" && return 0
  
  local platform=$(detect_platform)
  case "$platform" in
    macos) brew install xmllint 2>/dev/null && echo "[OK] xmllint installed" || echo "[HINT] Install Homebrew" ;;
    debian|ubuntu) apt-get update && apt-get install -y xmllint && echo "[OK] xmllint installed" ;;
    fedora|rhel|centos) dnf install -y xmllint && echo "[OK] xmllint installed" ;;
    arch) pacman -S --noconfirm xmllint && echo "[OK] xmllint installed" ;;
    alpine) apk add --no-cache xmllint && echo "[OK] xmllint installed" ;;
    *) echo "[ERROR] Unsupported platform: $platform"; exit 1 ;;
  esac
}

main "$@"
