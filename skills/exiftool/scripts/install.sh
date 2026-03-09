#!/usr/bin/env bash
set -euo pipefail

detect_platform() {
  local system=$(uname -s)
  [[ "$system" == "Darwin" ]] && echo "macos" && return
  [[ "$system" == "Linux" ]] && [[ -f /etc/os-release ]] && source /etc/os-release && echo "${ID:-linux}" && return
  echo "unknown"
}

main() {
  command -v exiftool >/dev/null && echo "[OK] exiftool is available" && return 0
  
  local platform=$(detect_platform)
  case "$platform" in
    macos) brew install exiftool 2>/dev/null && echo "[OK] exiftool installed" || echo "[HINT] Install Homebrew" ;;
    debian|ubuntu) apt-get update && apt-get install -y exiftool && echo "[OK] exiftool installed" ;;
    fedora|rhel|centos) dnf install -y exiftool && echo "[OK] exiftool installed" ;;
    arch) pacman -S --noconfirm exiftool && echo "[OK] exiftool installed" ;;
    alpine) apk add --no-cache exiftool && echo "[OK] exiftool installed" ;;
    *) echo "[ERROR] Unsupported platform: $platform"; exit 1 ;;
  esac
}

main "$@"
