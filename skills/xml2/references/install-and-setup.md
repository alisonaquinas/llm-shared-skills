# xml2 / 2xml Installation and Setup

`xml2` and `2xml` are distributed together in the `xml2` package.

## Platform-Specific Installation

### Debian / Ubuntu

```bash
apt-get update
apt-get install -y xml2
```

### macOS (Homebrew)

```bash
brew install xml2
```

### Fedora / RHEL / CentOS

```bash
dnf install -y xml2
```

### Arch Linux

```bash
pacman -S xml2
```

### Alpine Linux

```bash
apk add --no-cache xml2
```

### Windows

`xml2` and `2xml` have no native Windows binary. Use WSL (Windows Subsystem for Linux)
and install via `apt-get` inside WSL, or build from source.

## Verification

```bash
which xml2
which 2xml
echo '<root><a>1</a></root>' | xml2
# Expected: /root/a=1
```

## Source

- Project page: <http://dan.egnor.name/xml2/>
- Debian package: <https://packages.debian.org/sid/utils/xml2>
