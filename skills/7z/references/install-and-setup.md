# 7z Installation and Setup

## Overview

7z (7-Zip) is a compression utility available on most platforms. The p7zip package provides the command-line interface.

## Platform-Specific Installation

### macOS

#### Install via Homebrew

```bash
brew install p7zip

# Verify installation
7z --help
```

#### From Source

```bash
# Build from source
brew install p7zip --build-from-source

# Or manual build
cd /tmp
curl -L https://7-zip.org/a/7z2301-src.7z | 7z x
cd CPP/7zip/Bundles/SFXCon
make
sudo make install
```

### Debian / Ubuntu

```bash
# Install p7zip package
apt-get update
apt-get install -y p7zip-full p7zip-rar

# Verify
7z --help
```

### Fedora / RHEL / CentOS

```bash
# Install p7zip
dnf install -y p7zip p7zip-plugins

# Verify
7z --help
```

### Arch Linux

```bash
# Install p7zip
pacman -S --noconfirm p7zip

# Verify
7z --help
```

### Alpine Linux

```bash
# Install p7zip
apk add --no-cache p7zip

# Verify
7z --help
```

### Windows

#### Using Chocolatey

```powershell
choco install -y 7zip
# Or with p7zip for command-line
choco install -y p7zip
```

#### Using Scoop

```powershell
scoop install 7zip
```

#### Official Installer

Download from <https://www.7-zip.org/>

## Verification

### Check Installation

```bash
# Verify 7z is in PATH
which 7z

# Check version
7z --help | head -5

# Test with sample archive
7z l archive.7z
```

## Post-Install Configuration

7z has no special configuration needed. It works out of the box.

### Optional: File Association

On some systems, you may want to associate .7z files with 7z handler, but this is optional for CLI usage.

## Testing Installation

### Create and Extract Test Archive

```bash
# Create test directory
mkdir -p /tmp/test_7z
cd /tmp/test_7z

# Create test files
echo "test content 1" > file1.txt
echo "test content 2" > file2.txt

# Create archive
7z a test.7z file1.txt file2.txt
echo "Archive created"

# Test archive integrity
7z t test.7z
echo "Archive integrity test passed"

# Extract to directory
7z x test.7z -ooutput/
ls -la output/
```

## Troubleshooting Installation

### Command Not Found

```bash
# Ensure p7zip is installed
apt-get install -y p7zip-full    # Debian/Ubuntu
dnf install -y p7zip             # Fedora/RHEL
pacman -S p7zip                  # Arch

# Verify PATH
echo $PATH
which 7z
```

### Version Mismatch

```bash
# 7z versions are generally compatible
# But very old versions may not support solid archives

7z --help | head -1  # Shows version
```

## Resources

- 7z Official: <https://www.7-zip.org/>
- p7zip GitHub: <https://sourceforge.net/projects/p7zip/files/>
- Manual: <https://www.7-zip.org/7z.html>
