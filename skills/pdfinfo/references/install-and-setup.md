# pdfinfo Installation and Setup

## Overview

pdfinfo is a specialized utility for document and metadata handling.

## Platform-Specific Installation

### macOS

```bash
brew install pdfinfo
```

### Debian / Ubuntu

```bash
apt-get update
apt-get install -y pdfinfo
```

### Fedora / RHEL / CentOS

```bash
dnf install -y pdfinfo
```

### Arch Linux

```bash
pacman -S pdfinfo
```

### Alpine Linux

```bash
apk add --no-cache pdfinfo
```

## Verification

```bash
which pdfinfo
pdfinfo --version 2>/dev/null || pdfinfo --help | head -3
```

## Resources

- Manual: man pdfinfo
