#!/usr/bin/env bash
set -euo pipefail

detect_platform() {
  local system=$(uname -s)
  [[ "$system" == "Darwin" ]] && echo "macos" && return
  [[ "$system" == "Linux" ]] && [[ -f /etc/os-release ]] && source /etc/os-release && echo "${ID:-linux}" && return
  echo "unknown"
}

main() {
  command -v mediainfo >/dev/null && echo "[OK] mediainfo is available" && return 0
  
  local platform=$(detect_platform)
  case "$platform" in
    macos) brew install mediainfo 2>/dev/null && echo "[OK] mediainfo installed" || echo "[HINT] Install Homebrew" ;;
    debian|ubuntu) apt-get update && apt-get install -y mediainfo && echo "[OK] mediainfo installed" ;;
    fedora|rhel|centos) dnf install -y mediainfo && echo "[OK] mediainfo installed" ;;
    arch) pacman -S --noconfirm mediainfo && echo "[OK] mediainfo installed" ;;
    alpine) apk add --no-cache mediainfo && echo "[OK] mediainfo installed" ;;
    *) echo "[ERROR] Unsupported platform: $platform"; exit 1 ;;
  esac
}

main "$@"
