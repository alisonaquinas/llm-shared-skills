# tar Installation and Setup

## Overview

tar is part of basic Unix utilities and is pre-installed on virtually all systems.

## Platform-Specific Installation

### macOS

tar is built-in (BSD tar).

```bash
# Verify
tar --version
which tar
# Output: /usr/bin/tar
```

### Debian / Ubuntu / Fedora / Arch / Alpine

tar is pre-installed as part of base system.

```bash
# Verify
tar --version

# Install if missing
apt-get install -y tar       # Debian/Ubuntu
dnf install -y tar           # Fedora/RHEL
pacman -S tar                # Arch
apk add tar                  # Alpine
```

### Windows

#### WSL2

Use Linux installation for your distribution.

#### Git Bash

tar is included.

#### Cygwin

Install via Cygwin setup.

#### Chocolatey

```powershell
choco install -y gnuwin32-tar
```

## Verification

```bash
# Verify tar is available
which tar
tar --version

# Test with sample
tar --help | head -20
```

## Testing Installation

```bash
# Create test directory
mkdir -p test_tar && cd test_tar
echo "test content" > file.txt

# Create archive
tar -czf test.tar.gz file.txt

# List contents
tar -tzf test.tar.gz

# Extract to new directory
mkdir extract
tar -xzf test.tar.gz -C extract
ls extract

# Cleanup
cd .. && rm -rf test_tar
```

## Resources

- tar Manual: <https://man7.org/linux/man-pages/man1/tar.1.html>
- GNU tar: <https://www.gnu.org/software/tar/manual/>
