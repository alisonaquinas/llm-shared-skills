# wget Install and Setup

## Prerequisites

- Network access to the target hosts
- Permission to install packages and write local download paths
- A trusted CA store for HTTPS validation

## Install by Platform

| macOS | Debian/Ubuntu | Fedora/RHEL | Arch Linux | Alpine | Windows |
| --- | --- | --- | --- | --- | --- |
| `brew install wget` | `apt-get install -y wget ca-certificates` | `dnf install -y wget ca-certificates` | `pacman -S --noconfirm wget ca-certificates` | `apk add --no-cache wget ca-certificates` | `winget install GnuWin32.Wget --exact` |

## Verify Installation

```bash
wget --version
wget --help
wget --spider https://example.com/file.tar.gz
```

Check `wget --version` for:

- GNU Wget version
- TLS library support
- IPv6 support
- IDN or IRI support

## Default Runtime Checks

### Confirm Read-only Access

```bash
wget --spider https://example.com/file.tar.gz
```

### Confirm Local Write Path

```bash
mkdir -p downloads
wget --directory-prefix downloads https://example.com/file.tar.gz
```

### Confirm Timestamping Workflow

```bash
wget --timestamping https://example.com/releases/tool.zip
```

## TLS and CA Setup

Keep certificate validation enabled.

If the environment uses a custom CA bundle:

```bash
wget --ca-certificate=/path/to/internal-ca.pem https://internal.example.com/file.tar.gz
```

## Proxy Basics

wget respects common proxy environment variables:

```bash
export http_proxy=http://proxy.example.com:8080
export https_proxy=http://proxy.example.com:8080
export no_proxy=localhost,127.0.0.1,.internal.example.com
```

To disable proxy use for one command:

```bash
wget --no-proxy https://example.com/file.tar.gz
```

## Authentication Setup

Avoid inline secrets in shared shells or logs.

```bash
export WGET_USER="alice"
export WGET_PASS="replace-me"
wget --user "$WGET_USER" --password "$WGET_PASS" https://example.com/file.tar.gz
```

Cookie-based setup:

```bash
wget --save-cookies cookies.txt --keep-session-cookies https://example.com/login
```

Protect cookie files because they may grant session access.

## Notes for Windows

- Windows environments may provide wget through MSYS2, Git Bash, Cygwin, Scoop, or winget.
- Verify the actual binary in use with `where wget`.
- Path handling and certificate store behavior vary by distribution.

## Troubleshooting Setup

### wget Not Found

```bash
which wget
wget --version
```

On Windows:

```powershell
Get-Command wget
where.exe wget
```

### HTTPS Fails

- Confirm CA certificates are installed.
- Confirm corporate proxy or TLS interception requirements.
- Confirm the target hostname matches the certificate.

### Wrong Binary or Old Feature Set

```bash
which wget
wget --version
```

## Resources

- `man wget`
- GNU Wget manual: <https://www.gnu.org/software/wget/manual/wget.html>
