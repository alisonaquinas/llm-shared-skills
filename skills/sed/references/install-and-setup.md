# sed Installation and Setup

## Variants

### GNU sed

- Full-featured stream editor with extensions
- Supports `-E` (extended regex), `--version`, and various GNU-specific options
- Default on most Linux distributions
- Available on macOS via Homebrew as `gsed`

### BSD sed

- Simpler feature set, POSIX-like
- Default on macOS (built-in)
- Uses `-E` for extended regex (but syntax may differ from GNU)
- Limited extended features

### POSIX sed

- Minimal interface (required for portable scripts)
- Supported by both GNU and BSD

## Platform-Specific Installation

### macOS

#### Check Current Installation

```bash
# macOS has BSD sed built-in
sed --version
# Output: "sed: illegal option -- -"  (BSD sed doesn't recognize --version)

# Check which sed is available
which sed
# Output: /usr/bin/sed (BSD version)
```

#### Install GNU sed (gsed)

```bash
# Via Homebrew (recommended)
brew install gnu-sed

# This installs GNU sed as 'gsed'
gsed --version

# If you want 'sed' to refer to GNU sed:
export PATH="$(brew --prefix)/opt/gnu-sed/libexec/gnubin:$PATH"
sed --version  # Now points to GNU sed
```

### Debian / Ubuntu

```bash
# sed is typically pre-installed (GNU sed)
apt-get update
apt-get install -y sed

# Verify
sed --version
```

### Fedora / RHEL / CentOS

```bash
# sed is typically pre-installed (GNU sed)
dnf install -y sed

# Verify
sed --version
```

### Arch Linux

```bash
# sed is typically pre-installed (GNU sed)
pacman -S --noconfirm sed

# Verify
sed --version
```

### Alpine Linux

```bash
# sed is in busybox by default (minimal sed)
# For full GNU sed:
apk add --no-cache sed

# Verify
sed --version
```

### Windows (WSL2 / Git Bash / Cygwin)

#### WSL2 (Ubuntu / Debian)

```bash
wsl
apt-get update
apt-get install -y sed
sed --version
```

#### Git Bash

```bash
# Git Bash includes GNU sed by default
sed --version
```

#### Cygwin

```bash
# Use Cygwin setup or apt-cyg
apt-cyg install sed

# Verify
sed --version
```

#### Chocolatey

```powershell
choco install -y sed
sed --version
```

## Verification

### Check Installation

```bash
# Verify sed is available
which sed
sed --version

# Test with sample
echo "hello world" | sed 's/world/universe/'
# Output: hello universe
```

### Identify Variant

```bash
# GNU sed (will work)
sed --version

# BSD sed (will show error about illegal option)
# But these still work on BSD:
sed 's/old/new/' file.txt
sed -n '1,5p' file.txt
```

## Minimum Version Notes

### GNU sed (Features)

- Full feature set available in all modern versions
- No specific minimum version needed for common usage
- Extended regex (`-E` flag) available in all versions

### BSD sed (Availability)

- Available on all macOS and BSD systems
- All versions support basic options (`-n`, `-e`, `-i`)
- Extended regex (`-E`) available on most modern versions

## Post-Install Configuration

### Shell Integration (Optional)

If you've installed `gsed` on macOS and want to use it as the default:

```bash
# Add to ~/.zshrc or ~/.bash_profile
alias sed=gsed
```

Or use in PATH ordering:

```bash
# Add GNU bin directory first in PATH
export PATH="$(brew --prefix)/opt/gnu-sed/libexec/gnubin:$PATH"
```

### Manual Path Setup

```bash
# If installing from source or custom location
export PATH="/custom/bin:$PATH"
sed --version
```

## Testing Installation

### Test with Real Data

```bash
# Create test file
cat > /tmp/test_sed.txt << 'EOF'
old_value in line 1
old_value in line 2
keep this line
EOF

# Test basic substitution
sed 's/old_value/new_value/' /tmp/test_sed.txt

# Test global substitution
sed 's/old_value/new_value/g' /tmp/test_sed.txt

# Test line selection
sed -n '1,2p' /tmp/test_sed.txt

# Test in-place edit (with backup)
cp /tmp/test_sed.txt /tmp/test_sed.txt.orig
sed -i.bak 's/old_value/new_value/g' /tmp/test_sed.txt
# Original backup is now at /tmp/test_sed.txt.bak
```

### Validate Variant

```bash
# Test for GNU-specific features
if sed 's/old/new/g' -e 's/foo/bar/g' /tmp/test_sed.txt >/dev/null 2>&1; then
  echo "sed is working"
fi

# Test extended regex
if sed -E 's/[0-9]+/NUM/g' /tmp/test_sed.txt >/dev/null 2>&1; then
  echo "Extended regex (-E) is available"
fi
```

## Troubleshooting Installation

### Command Not Found

```bash
# Ensure sed is installed
apt-get install -y sed    # Linux
brew install gnu-sed      # macOS

# Verify PATH
echo $PATH
which sed
```

### Version Output Not Recognized

```bash
# You have BSD sed (doesn't recognize --version)
# This is normal on macOS

# Run without --version flag
sed 's/test/pass/' /tmp/test_sed.txt
```

### Permission Denied

```bash
# Check permissions
ls -l /bin/sed
which sed

# Reinstall to fix permissions
apt-get install --reinstall sed
```

### Incompatible Flags

```bash
# BSD sed doesn't support some GNU flags
# Error: illegal option -- r

# Use -E instead of -r for extended regex
sed -E 's/[0-9]+/NUM/g' file.txt
```

## Building from Source (Advanced)

If binaries aren't available for your platform:

```bash
# Download GNU sed
cd /tmp
wget https://ftp.gnu.org/gnu/sed/sed-4.9.tar.xz
tar -xf sed-4.9.tar.xz
cd sed-4.9

# Configure and build
./configure --prefix=/usr/local
make
sudo make install

# Verify
/usr/local/bin/sed --version
```

## Resources

- `man sed` — Full manual and options
- GNU sed: <https://www.gnu.org/software/sed/manual/>
- BSD sed: <https://www.freebsd.org/cgi/man.cgi?query=sed>
