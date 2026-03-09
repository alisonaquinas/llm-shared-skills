#!/usr/bin/env bash
set -euo pipefail

# SQLite advanced tools (sqlite3, sqldiff, sqlite3_rsync) installer for macOS, Linux

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

  # Check if sqlite3 is already installed
  if command -v sqlite3 &>/dev/null; then
    local version=$(sqlite3 --version)
    echo "[OK] sqlite3: $version"
  else
    echo "[INFO] sqlite3 not found. Installing base tools first..."
    case "$platform" in
      macos)
        if command -v brew &>/dev/null; then
          brew install sqlite
        else
          echo "[ERROR] Homebrew not found. Install from https://brew.sh"
          exit 1
        fi
        ;;

      debian|ubuntu|fedora|rhel|centos|arch|alpine)
        case "$platform" in
          debian|ubuntu)
            sudo apt update
            sudo apt install -y sqlite3
            ;;
          fedora|rhel|centos)
            sudo dnf install -y sqlite
            ;;
          arch)
            sudo pacman -S --noconfirm sqlite
            ;;
          alpine)
            sudo apk add sqlite
            ;;
        esac
        ;;

      *)
        echo "[ERROR] Unsupported platform: $platform"
        exit 1
        ;;
    esac
  fi

  # Check for sqldiff
  if command -v sqldiff &>/dev/null; then
    echo "[OK] sqldiff already installed"
  else
    echo "[INFO] Installing sqldiff..."
    case "$platform" in
      macos)
        brew install sqlite  # sqldiff included
        echo "[OK] sqldiff installed"
        ;;

      debian|ubuntu)
        sudo apt install -y sqlite3-tools 2>/dev/null || echo "[WARN] sqlite3-tools not available; sqldiff may need manual install"
        ;;

      *)
        echo "[WARN] sqldiff not in package manager for this platform"
        echo "[HINT] Download from https://www.sqlite.org/download.html or build from source"
        ;;
    esac
  fi

  # Check for sqlite3_rsync
  if command -v sqlite3_rsync &>/dev/null; then
    echo "[OK] sqlite3_rsync already installed"
  else
    echo "[WARN] sqlite3_rsync not found (not in most package managers)"
    echo "[HINT] Download prebuilt binary or build from source:"
    echo "[HINT]   https://www.sqlite.org/download.html"
  fi

  # Verify all installations
  echo ""
  echo "[INFO] Verification:"
  sqlite3 --version
  command -v sqldiff &>/dev/null && sqldiff --version || echo "[WARN] sqldiff not available"
  command -v sqlite3_rsync &>/dev/null && sqlite3_rsync --help 2>&1 | head -1 || echo "[WARN] sqlite3_rsync not available"

  echo ""
  echo "[OK] Base SQLite3 installation verified"
  echo "[HINT] See references/install-and-setup.md for complete setup and sqldiff/sqlite3_rsync installation"
}

main "$@"
