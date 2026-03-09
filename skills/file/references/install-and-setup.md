# file Installation and Setup

## Overview

file is part of standard Unix utilities or development tools.

## Platform-Specific Installation

### macOS

file is available via brew

```bash
which file
brew install file 2>/dev/null || echo "Check if built-in"
```

### Debian / Ubuntu

```bash
apt-get update
apt-get install -y file

# Or binutils if needed
apt-get install -y binutils
```

### Fedora / RHEL / CentOS

```bash
dnf install -y file
```

### Arch Linux

```bash
pacman -S --noconfirm file
```

### Alpine Linux

```bash
apk add --no-cache file
```

## Verification

```bash
which file
file --version 2>/dev/null || file --help | head -3
```

## Resources

- Manual: man file
