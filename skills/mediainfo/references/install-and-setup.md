# mediainfo Installation and Setup

## Overview

mediainfo is a specialized utility for document and metadata handling.

## Platform-Specific Installation

### macOS

```bash
brew install mediainfo
```

### Debian / Ubuntu

```bash
apt-get update
apt-get install -y mediainfo
```

### Fedora / RHEL / CentOS

```bash
dnf install -y mediainfo
```

### Arch Linux

```bash
pacman -S mediainfo
```

### Alpine Linux

```bash
apk add --no-cache mediainfo
```

## Verification

```bash
which mediainfo
mediainfo --version 2>/dev/null || mediainfo --help | head -3
```

## Resources

- Manual: man mediainfo
