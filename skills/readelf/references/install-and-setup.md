# readelf Installation and Setup

## Overview

readelf is part of standard Unix utilities or development tools.

## Platform-Specific Installation

### macOS

readelf is available via brew

```bash
which readelf
brew install readelf 2>/dev/null || echo "Check if built-in"
```

### Debian / Ubuntu

```bash
apt-get update
apt-get install -y readelf

# Or binutils if needed
apt-get install -y binutils
```

### Fedora / RHEL / CentOS

```bash
dnf install -y readelf
```

### Arch Linux

```bash
pacman -S --noconfirm readelf
```

### Alpine Linux

```bash
apk add --no-cache readelf
```

## Verification

```bash
which readelf
readelf --version 2>/dev/null || readelf --help | head -3
```

## Resources

- Manual: man readelf
