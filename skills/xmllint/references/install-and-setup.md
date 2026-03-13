# xmllint Installation and Setup

`xmllint` is part of the `libxml2` utilities package.

## Platform-Specific Installation

### Debian / Ubuntu

```bash
apt-get update
apt-get install -y libxml2-utils
```

### macOS (Homebrew)

```bash
brew install libxml2
```

`xmllint` may also already be present on macOS — check with `xmllint --version`.

### Fedora / RHEL / CentOS

```bash
dnf install -y libxml2
```

### Arch Linux

```bash
pacman -S libxml2
```

### Alpine Linux

```bash
apk add --no-cache libxml2-utils
```

### Windows (Chocolatey)

```powershell
choco install xsltproc
```

The `xsltproc` Chocolatey package includes `xmllint`.

Alternatively, download pre-built Windows binaries maintained at:
<https://www.zlatkovic.com/libxml.en.html>

## Verification

```bash
xmllint --version
# Expected: xmllint: using libxml version XXXXX
```

## References

- libxml2 project: <https://gnome.pages.gitlab.gnome.org/libxml2/>
- xmllint manual: <https://gnome.pages.gitlab.gnome.org/libxml2/xmllint.html>
