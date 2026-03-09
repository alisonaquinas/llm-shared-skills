# awk — Install and Setup

## Overview

`awk` is typically pre-installed on most POSIX systems. This guide covers installing or upgrading to GNU awk (gawk), mawk, or nawk on different platforms.

### Variants

- **gawk** (GNU awk): Full-featured, POSIX-compliant with extensions (`strftime`, `mktime`, `nextfile`, arrays). Default on Linux.
- **mawk**: Minimal, fast awk. POSIX-compliant, smaller footprint.
- **nawk** (One True Awk): Portable, POSIX reference implementation.
- **awk** (BSD/macOS default): Often `/usr/bin/awk` (BSD awk), limited features, no GNU extensions.

### Version Check

```bash
awk --version         # GNU or mawk (shows variant + version)
awk -W version        # Some variants
man awk               # Verify installed variant
```

## macOS

### Via Homebrew (recommended)

```bash
brew install gawk    # Install GNU awk
```

Verify:

```bash
gawk --version
which gawk
```

### Using system awk

macOS ships with `/usr/bin/awk` (BSD awk). For most workflows, this is sufficient. To use GNU extensions, install gawk as above.

## Linux

### Debian/Ubuntu

```bash
apt-get update
apt-get install -y gawk    # GNU awk
# or: apt-get install -y mawk
# or: apt-get install -y original-awk
```

Verify:

```bash
awk --version
```

### Fedora/RHEL

```bash
dnf install -y gawk     # GNU awk
# or: dnf install -y mawk
```

### Arch Linux

```bash
pacman -S gawk          # GNU awk
# or: pacman -S mawk
```

### Alpine Linux

```bash
apk add --no-cache gawk   # GNU awk
# or: apk add --no-cache mawk
```

## Windows

### Option 1: WSL2 (recommended)

Install awk inside WSL2 using the Linux section above.

### Option 2: Git Bash

awk is included in Git Bash on Windows. Verify:

```bash
awk --version
```

### Option 3: MinGW or MSYS2

Install MinGW or MSYS2 and use their package manager:

```bash
pacman -S gawk
```

### Option 4: Chocolatey (if installed)

```bash
choco install gawk
```

## Post-Install Verification

```bash
# Check version and variant
awk --version

# Test basic functionality
echo -e "1 2\n3 4" | awk '{print $1 + $2}'
# Expected output: 3, 7

# Verify POSIX compliance
awk 'BEGIN {print (5 > 3) ? "yes" : "no"}'
# Expected output: yes
```

## Minimum Version

- **gawk**: 4.0+ (for modern features like `nextfile`, `switch`)
- **mawk**: 1.3+
- **nawk/awk**: POSIX-compliant version recommended

## Environment Variables

No special setup required. `awk` respects:

- `LANG`, `LC_ALL` — affect locale-dependent behavior (regex, string comparison)
- `AWKPATH` — include path for `-f file` scripts (gawk)
- `IGNORECASE` — case-insensitive matching (gawk extension)

To set locale:

```bash
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
awk '{print $1}' file.txt
```

## Common Pitfall: Mixed Variants

If you use both system awk and gawk:

```bash
# Call explicitly
/usr/bin/awk ...      # BSD awk on macOS
/opt/homebrew/bin/gawk ...  # Homebrew gawk
gawk ...              # Symlinked or in PATH
```

Different variants have subtle differences in regex syntax and extensions.
