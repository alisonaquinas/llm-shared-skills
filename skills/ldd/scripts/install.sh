#!/usr/bin/env bash
set -euo pipefail

detect_platform() {
  local system=$(uname -s)
  [[ "$system" == "Darwin" ]] && echo "macos" && return
  [[ "$system" == "Linux" ]] && [[ -f /etc/os-release ]] && source /etc/os-release && echo "${ID:-linux}" && return
  echo "unknown"
}

main() {
  command -v ldd >/dev/null && echo "[OK] ldd is available" && return 0
  
  local platform=$(detect_platform)
  case "$platform" in
    macos) brew install ldd 2>/dev/null && echo "[OK] ldd installed" ;;
    debian|ubuntu) apt-get update && apt-get install -y ldd && echo "[OK] ldd installed" ;;
    fedora|rhel|centos) dnf install -y ldd && echo "[OK] ldd installed" ;;
    arch) pacman -S --noconfirm ldd && echo "[OK] ldd installed" ;;
    alpine) apk add --no-cache ldd && echo "[OK] ldd installed" ;;
    *) echo "[ERROR] Unsupported: $platform"; exit 1 ;;
  esac
}

main "$@"
