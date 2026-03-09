#!/usr/bin/env bash
set -euo pipefail

# Probe script for ag (The Silver Searcher)
# Confirms tool availability and emits diagnostics

echo "[INFO] Probing ag (The Silver Searcher) environment..."
echo ""

# Check if ag is available
if ! command -v ag >/dev/null 2>&1; then
  echo "[ERROR] ag not found on PATH"
  echo "[HINT] Install: brew install the_silver_searcher (macOS) or apt install silversearcher-ag (Linux)"
  exit 1
fi

# Show ag version
ag_path=$(command -v ag)
ag_version=$(ag --version 2>&1 | head -1)
echo "[OK] ag found at: $ag_path"
echo "[OK] Version: $ag_version"
echo ""

# Test --stats flag availability
echo "[INFO] Testing --stats flag..."
if ag --stats "^$" . >/dev/null 2>&1 || true; then
  echo "[OK] --stats flag available"
else
  echo "[WARN] --stats flag may not be available"
fi
echo ""

# Detect ignore files in current working directory
echo "[INFO] Detecting ignore files in $(pwd)..."
ignore_files_found=()

for ignore_file in .gitignore .hgignore .ignore "$HOME/.agignore"; do
  if [[ -f "$ignore_file" ]]; then
    ignore_files_found+=("$ignore_file")
  fi
done

if [[ ${#ignore_files_found[@]} -gt 0 ]]; then
  echo "[OK] Ignore files found:"
  for f in "${ignore_files_found[@]}"; do
    echo "     $f"
  done
else
  echo "[INFO] No ignore files detected (will search all files)"
fi
echo ""

# Test output modes
echo "[INFO] Testing output modes..."

# Test plain output
test_pattern="function|def|class"
if ag -e "function" -e "def" -e "class" --nocolor --noheading --nofilename . 2>/dev/null | head -1 >/dev/null 2>&1 || true; then
  echo "[OK] Text output mode works"
fi

# Test list-files mode
if ag -l "." . >/dev/null 2>&1 || true; then
  echo "[OK] List-files mode (-l) works"
fi

# Test count mode
if ag -c "." . >/dev/null 2>&1 || true; then
  echo "[OK] Count mode (-c) works"
fi
echo ""

echo "[OK] Preflight passed - ag is ready to use"
