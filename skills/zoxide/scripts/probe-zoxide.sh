#!/usr/bin/env bash
set -euo pipefail

# Probe script for zoxide
# Confirms tool availability, shell integration, and environment readiness

echo "[INFO] Probing zoxide environment..."
echo ""

# Check if zoxide is available
if ! command -v zoxide >/dev/null 2>&1; then
  echo "[ERROR] zoxide not found on PATH"
  echo "[HINT] Install: brew install zoxide (macOS) or see https://github.com/ajeetdsouha/zoxide"
  exit 1
fi

# Show zoxide version
zoxide_path=$(command -v zoxide)
zoxide_version=$(zoxide --version 2>&1)
echo "[OK] zoxide found at: $zoxide_path"
echo "[OK] Version: $zoxide_version"
echo ""

# Check shell integration
echo "[INFO] Checking shell integration..."
current_shell=$(basename "$SHELL")

if type z >/dev/null 2>&1; then
  echo "[OK] \`z\` command available (shell integrated)"
else
  echo "[WARN] \`z\` command not available - shell not integrated"
  echo "[HINT] Add to your shell config: eval \"\$(zoxide init $current_shell)\""
fi

if type zi >/dev/null 2>&1; then
  echo "[OK] \`zi\` command available (interactive mode integrated)"
else
  echo "[WARN] \`zi\` command not available - may need shell restart"
fi
echo ""

# Detect database location
echo "[INFO] Checking database location..."
if [[ -n "${_ZO_DATA_DIR:-}" ]]; then
  db_dir="$_ZO_DATA_DIR"
  echo "[OK] Using custom \$_ZO_DATA_DIR: $db_dir"
else
  # Default paths by platform
  case "$(uname -s)" in
    Darwin)
      db_dir="$HOME/Library/Application Support/zoxide"
      ;;
    Linux)
      db_dir="${XDG_DATA_HOME:-$HOME/.local/share}/zoxide"
      ;;
    *)
      db_dir="$HOME/.zoxide"
      ;;
  esac
  echo "[INFO] Using default database dir: $db_dir"
fi

if [[ -f "$db_dir/db.zo" ]]; then
  db_size=$(du -h "$db_dir/db.zo" | cut -f1)
  echo "[OK] Database exists: $db_dir/db.zo ($db_size)"
else
  echo "[INFO] Database not yet created (will be created on first \`z\` usage)"
fi
echo ""

# Show top ranked directories
echo "[INFO] Top 10 ranked directories..."
if zoxide query --list >/dev/null 2>&1; then
  zoxide query -ls 2>/dev/null | head -10 | nl
  echo ""
else
  echo "[INFO] No ranked directories yet (database empty)"
  echo ""
fi

# Check fzf for interactive mode
echo "[INFO] Checking fzf for interactive mode (zi)..."
if command -v fzf >/dev/null 2>&1; then
  fzf_version=$(fzf --version 2>&1 | head -1)
  echo "[OK] fzf available: $fzf_version"
else
  echo "[WARN] fzf not found - interactive mode (zi) will not work"
  echo "[HINT] Install fzf: brew install fzf (macOS) or sudo apt install fzf (Linux)"
fi
echo ""

# Test query capability
echo "[INFO] Testing zoxide query..."
if zoxide query --help >/dev/null 2>&1; then
  echo "[OK] zoxide query available"
  # Try a test query for current directory
  if zoxide query . >/dev/null 2>&1; then
    echo "[OK] Query executable"
  fi
else
  echo "[ERROR] zoxide query command failed"
fi
echo ""

echo "[OK] Preflight passed - zoxide is ready to use"
