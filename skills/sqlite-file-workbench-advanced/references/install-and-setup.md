# SQLite Advanced Tools Install & Setup

## Prerequisites

- macOS 10.13+, Linux (Debian/Fedora/Arch), or Windows
- Command-line access
- For advanced diffing and syncing: `sqldiff` and `sqlite3_rsync` binaries

## Tools Overview

| Tool | Purpose | Availability |
|------|---------|--------------|
| `sqlite3` | SQL shell, query execution | Package managers (always) |
| `sqldiff` | Compare two database files | Homebrew (macOS), download, build from source |
| `sqlite3_rsync` | Sync replicas, incremental backup | Download prebuilt, build from source only |

## Install by Platform

### macOS

```bash
# All tools via Homebrew
brew install sqlite

# Verify all three
sqlite3 --version
sqldiff --version
sqlite3_rsync --help 2>&1 | head -3  # Might not exist; see below
```

**Note:** sqlite3_rsync may not be in Homebrew; download from sqlite.org or build.

### Linux (Debian/Ubuntu)

```bash
# Base sqlite3
apt update && apt install sqlite3

# sqldiff (newer distros)
apt install sqlite3-tools  # Includes sqldiff

# sqlite3_rsync: download prebuilt from sqlite.org or build from source
curl -L https://www.sqlite.org/src/raw/sqlite3_rsync.c?name=... -o sqlite3_rsync.c
gcc -O2 sqlite3_rsync.c -o sqlite3_rsync
sudo install -m 755 sqlite3_rsync /usr/local/bin/
```

### Windows

1. Download `sqlite-tools-win32-x86-*.zip` (or x64 for 64-bit) from https://www.sqlite.org/download.html
2. Extract to a directory (e.g., `C:\sqlite`)
3. Add to PATH:
   ```powershell
   [Environment]::SetEnvironmentVariable("PATH", "$env:PATH;C:\sqlite", "User")
   ```
4. Verify: Open new PowerShell and run `sqlite3 --version`

## Post-Install Configuration

### Set PATH

Ensure all binaries are accessible:

```bash
# macOS/Linux: add to ~/.bashrc or ~/.zshrc if needed
export PATH="$PATH:/usr/local/bin:$HOME/.local/bin"

# Verify all tools
which sqlite3 sqldiff sqlite3_rsync
```

### Create ~/.sqliterc

```bash
cat > ~/.sqliterc << 'EOF'
-- Advanced queries and performance tuning
.headers on
.mode table

-- Safety
PRAGMA foreign_keys=ON;
PRAGMA journal_mode=WAL;
PRAGMA synchronous=NORMAL;

-- Performance
PRAGMA cache_size=-64000;
PRAGMA mmap_size=30000000000;

-- Debugging
.timer on
PRAGMA optimize;
EOF
```

## Verification

```bash
# All tools
sqlite3 --version
sqldiff --version
sqlite3_rsync --help | head -3

# Create test databases
sqlite3 db1.db "CREATE TABLE t(id INT); INSERT INTO t VALUES(1),(2);"
sqlite3 db2.db "CREATE TABLE t(id INT); INSERT INTO t VALUES(1),(3);"

# Test sqldiff
sqldiff db1.db db2.db

# Cleanup
rm -f db1.db db2.db
```

## Common Workflows

### Diff Two Databases

```bash
sqldiff db1.db db2.db
```

### Incremental Backup with sqlite3_rsync

```bash
# Create initial replica
sqlite3_rsync db1.db db1-backup.db

# Later, sync only changed pages
sqlite3_rsync db1.db db1-backup.db
```

### Extract and Replay Changes

```bash
# Dump changes from db1 that aren't in db2
sqldiff db2.db db1.db > changes.sql

# Apply to another database
sqlite3 db3.db < changes.sql
```

## Troubleshooting

### "sqldiff: command not found"
- Not installed. Try: `brew install sqlite` (macOS) or `apt install sqlite3-tools` (Linux)
- Or download prebuilt from sqlite.org

### "sqlite3_rsync: command not found"
- Only available via download/build from https://www.sqlite.org/download.html
- Build from source:
  ```bash
  curl -L https://www.sqlite.org/src/raw/sqlite3_rsync.c -o sqlite3_rsync.c
  gcc -O2 sqlite3_rsync.c -o sqlite3_rsync
  sudo install -m 755 sqlite3_rsync /usr/local/bin/
  ```

### sqldiff output shows "PRAGMA" errors
- Old sqlite3 version. Upgrade: `brew upgrade sqlite` (macOS) or `apt upgrade sqlite3` (Linux)

### "Permission denied" when running binaries
- Check permissions: `ls -la /path/to/binary`
- Fix: `chmod +x /path/to/binary`
