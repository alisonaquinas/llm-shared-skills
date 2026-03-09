# unzip Installation and Setup

## Overview

unzip is part of info-zip utilities and is standard on most Unix systems.

## Platform-Specific Installation

### macOS / Debian / Ubuntu / Fedora / Arch / Alpine

unzip is pre-installed or easily available:

```bash
# Verify
unzip -h

# Install if missing
apt-get install -y unzip       # Debian/Ubuntu
dnf install -y unzip           # Fedora/RHEL
pacman -S unzip                # Arch
apk add unzip                  # Alpine
brew install unzip             # macOS (if missing)
```

### Windows

#### Powershell (Windows 10+)

Native `Expand-Archive` cmdlet available.

#### Chocolatey

```powershell
choco install -y 7zip
# Or use unzip via WSL2
```

#### WSL2

Use Linux installation for your distribution.

## Verification

```bash
# Verify unzip is available
which unzip
unzip -h

# Test with sample
mkdir test && cd test
echo "content" > file.txt
zip test.zip file.txt
unzip -t test.zip
cd .. && rm -rf test
```

## Resources

- [info-zip](http://www.info-zip.org/)
- [Manual](https://linux.die.net/man/1/unzip)
