# diff — Install and Setup

## Overview

`diff` is typically pre-installed on all POSIX systems. This guide covers installing or upgrading to GNU diff (diffutils) on different platforms.

### Variants

- **GNU diff** (diffutils): Full-featured, POSIX-compliant, extended options. Default on Linux.
- **BSD diff**: Portable, minimal feature set. Default on macOS.
- **busybox diff**: Lightweight, embedded systems.

### Version Check

```bash
diff --version    # GNU diff
man diff          # Check variant and options
```

## macOS

### Via Homebrew (recommended for GNU features)

```bash
brew install diffutils   # Installs GNU diff as "gdiff"
```

Verify:

```bash
gdiff --version
which gdiff
```

### Using system diff

macOS ships with `/usr/bin/diff` (BSD diff). For most workflows, this is sufficient.

## Linux

### Debian/Ubuntu

```bash
apt-get update
apt-get install -y diffutils   # GNU diff
```

Verify:

```bash
diff --version
```

### Fedora/RHEL

```bash
dnf install -y diffutils
```

### Arch Linux

```bash
pacman -S diffutils
```

### Alpine Linux

```bash
apk add --no-cache diffutils
```

## Windows

### Option 1: WSL2 (recommended)

Install diff inside WSL2 using the Linux section above.

### Option 2: Git Bash

diff is included in Git Bash. Verify:

```bash
diff --version
```

### Option 3: MinGW or MSYS2

Install via their package manager:

```bash
pacman -S diffutils
```

### Option 4: Chocolatey

```bash
choco install diffutils
```

## Post-Install Verification

```bash
# Check version
diff --version

# Test basic functionality
echo -e "a\nb\nc" > file1.txt
echo -e "a\nb\nd" > file2.txt
diff file1.txt file2.txt

# Should show:
# 3c3
# < c
# ---
# > d
```

## Minimum Version

- **GNU diff**: 2.8+ (standard options)
- **BSD diff**: POSIX-compliant version

## Common Pitfall: GNU vs BSD Differences

| Feature | GNU | BSD | Notes |
| --- | --- | --- | --- |
| `--unified` | Yes | Yes | Both support `-u` format |
| `--color` | Yes | No | GNU extension |
| `--ignore-all-space` | Yes | `-w` | Different syntax |
| `--recursive` | Yes | Yes | Both support `-r` |

Always test output format on the target system.
