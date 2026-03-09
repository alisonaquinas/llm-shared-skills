# ldd Installation and Setup

## Overview

ldd is available on most platforms.

## Platform-Specific Installation

### macOS

```bash
brew install ldd
```

### Debian / Ubuntu

```bash
apt-get update
apt-get install -y ldd
```

### Fedora / RHEL / CentOS

```bash
dnf install -y ldd
```

### Arch Linux

```bash
pacman -S ldd
```

### Alpine Linux

```bash
apk add --no-cache ldd
```

## Verification

```bash
which ldd
ldd --version 2>/dev/null || ldd --help | head -3
```

## Resources

- Manual: man ldd
