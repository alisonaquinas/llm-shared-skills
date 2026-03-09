#!/usr/bin/env bash
set -euo pipefail

detect_platform() {
  local system=$(uname -s)
  [[ "$system" == "Darwin" ]] && echo "macos" && return
  [[ "$system" == "Linux" ]] && [[ -f /etc/os-release ]] && source /etc/os-release && echo "${ID:-linux}" && return
  echo "unknown"
}

main() {
  command -v pdfinfo >/dev/null && echo "[OK] pdfinfo is available" && return 0
  
  local platform=$(detect_platform)
  case "$platform" in
    macos) brew install pdfinfo 2>/dev/null && echo "[OK] pdfinfo installed" || echo "[HINT] Install Homebrew" ;;
    debian|ubuntu) apt-get update && apt-get install -y pdfinfo && echo "[OK] pdfinfo installed" ;;
    fedora|rhel|centos) dnf install -y pdfinfo && echo "[OK] pdfinfo installed" ;;
    arch) pacman -S --noconfirm pdfinfo && echo "[OK] pdfinfo installed" ;;
    alpine) apk add --no-cache pdfinfo && echo "[OK] pdfinfo installed" ;;
    *) echo "[ERROR] Unsupported platform: $platform"; exit 1 ;;
  esac
}

main "$@"
