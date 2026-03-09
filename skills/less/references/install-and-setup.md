# less Installation and Setup

## Overview

less is available on most platforms.

## Platform-Specific Installation

### macOS

```bash
brew install less
```

### Debian / Ubuntu

```bash
apt-get update
apt-get install -y less
```

### Fedora / RHEL / CentOS

```bash
dnf install -y less
```

### Arch Linux

```bash
pacman -S less
```

### Alpine Linux

```bash
apk add --no-cache less
```

## Verification

```bash
which less
less --version 2>/dev/null || less --help | head -3
```

## Resources

- Manual: man less
